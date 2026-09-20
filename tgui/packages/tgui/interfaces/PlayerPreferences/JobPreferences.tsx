import { Fragment, useState } from 'react';
import {
  Box,
  Button,
  Flex,
  LabeledList,
  Modal,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../../backend';

export const JobPreferences = (props) => {
  const { act, data } = useBackend<JobPreferencesData>();
  const {
    job_groups,
    alternate_option,
    squads,
    preferred_squad,
    overflow_job,
    special_occupations,
    special_occupation,
  } = data;
  const [shownDescription, setShownDescription] = useState(null);

  // Titles and categories come from DM; never maintain a translated-name map here.
  const groups = Object.entries(job_groups ?? {});

  const JobList = ({ name, jobs }) => (
    <Section title={name}>
      <LabeledList>
        {jobs.map((job) => (
          <JobPreference
            key={job}
            job={job}
            setShownDescription={setShownDescription}
          />
        ))}
      </LabeledList>
    </Section>
  );

  return (
    <Section
      title="职位偏好"
      buttons={
        <Button color="bad" icon="power-off" onClick={() => act('jobreset')}>
          重置全部!
        </Button>
      }
    >
      {shownDescription && (
        <Modal width="500px" min-height="300px">
          <Box dangerouslySetInnerHTML={{ __html: shownDescription }} />
          <Box align="right">
            <Button align="right" onClick={() => setShownDescription(null)}>
              X
            </Button>
          </Box>
        </Modal>
      )}
      {groups.map(([name, jobs], index) =>
        index % 2 === 0 ? (
          <Stack key={name}>
            <Stack.Item grow basis={0}>
              <JobList name={name} jobs={jobs} />
            </Stack.Item>
            <Stack.Item grow basis={0}>
              {groups[index + 1] && (
                <JobList
                  name={groups[index + 1][0]}
                  jobs={groups[index + 1][1]}
                />
              )}
            </Stack.Item>
          </Stack>
        ) : null,
      )}
      <Stack>
        <Stack.Item grow>
          <Section title="其他设置">
            <Flex direction="column" height="100%">
              <Flex.Item>
                <h4>If failed to qualify for job</h4>
                <Button.Checkbox
                  inline
                  content={'Take a random job'}
                  checked={alternate_option === 0}
                  onClick={() => act('jobalternative', { newValue: 0 })}
                />
                <Button.Checkbox
                  inline
                  content={`Spawn as ${overflow_job}`}
                  checked={alternate_option === 1}
                  onClick={() => act('jobalternative', { newValue: 1 })}
                />
                <Button.Checkbox
                  inline
                  content={'Return to lobby'}
                  checked={alternate_option === 2}
                  onClick={() => act('jobalternative', { newValue: 2 })}
                />
              </Flex.Item>
              <Flex.Item>
                <h4>Preferred Squad</h4>
                {Object.values(squads ?? {}).map((squad) => (
                  <Button.Checkbox
                    key={squad}
                    inline
                    content={squad}
                    checked={preferred_squad === squad}
                    onClick={() => act('squad', { newValue: squad })}
                  />
                ))}
              </Flex.Item>
              <Flex.Item>
                <h4>Occupational choices</h4>
                {Object.keys(special_occupations ?? {}).map((special, idx) => (
                  <Fragment key={special}>
                    <Button.Checkbox
                      key={special_occupations[special]}
                      inline
                      content={special}
                      checked={
                        special_occupation & special_occupations[special]
                      }
                      onClick={() =>
                        act('be_special', {
                          flag: special_occupations[special],
                        })
                      }
                    />
                    {idx === 1 && <br />}
                  </Fragment>
                ))}
              </Flex.Item>
            </Flex>
          </Section>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const JobPreference = (props) => {
  const { act, data } = useBackend<JobPreferenceData>();
  const { jobs, job_preferences } = data;
  const { job, setShownDescription } = props;
  const jobData = jobs?.[job];
  const preference = job_preferences?.[job];

  if (!jobData) {
    return null;
  }

  if (jobData.banned) {
    return (
      <LabeledList.Item label={job}>
        <Box align="right">
          <Button.Checkbox
            inline
            icon="ban"
            color="bad"
            content={'Banned from Role'}
            onClick={() => act('bancheck', { role: job })}
          />
        </Box>
      </LabeledList.Item>
    );
  }

  if (jobData.playtime_req) {
    return (
      <LabeledList.Item label={job}>
        <Box align="right">
          <Button.Checkbox
            inline
            icon="times"
            color="light-grey"
            content={jobData.exp_string}
          />
        </Box>
      </LabeledList.Item>
    );
  }

  return (
    <LabeledList.Item label={job}>
      <Box align="right">
        <Button.Checkbox
          inline
          content={'High'}
          checked={preference === 3}
          onClick={() => act('jobselect', { job, level: 3 })}
        />
        <Button.Checkbox
          inline
          content={'Medium'}
          checked={preference === 2}
          onClick={() => act('jobselect', { job, level: 2 })}
        />
        <Button.Checkbox
          inline
          content={'Low'}
          checked={preference === 1}
          onClick={() => act('jobselect', { job, level: 1 })}
        />
        <Button.Checkbox
          inline
          content={'Never'}
          checked={!preference}
          onClick={() => act('jobselect', { job, level: 0 })}
        />
        {jobData.description && (
          <Button
            content="?"
            onClick={() => setShownDescription(jobData.description)}
          />
        )}
      </Box>
    </LabeledList.Item>
  );
};
