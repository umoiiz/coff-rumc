import { useState } from 'react';
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

// Job titles are also used as server-side preference keys. The localization
// pass translates those keys in DM, while the UI lists keep their stable
// English labels for compatibility with older servers.
const JOB_KEY_ALIASES: Record<string, string[]> = {
  Captain: ['Captain', '舰长'],
  'Field Commander': ['Field Commander', '战地指挥官'],
  'Staff Officer': ['Staff Officer', '参谋官'],
  'Pilot Officer': ['Pilot Officer', '飞行员'],
  'Transport Officer': ['Transport Officer', '运输官'],
  Synthetic: ['Synthetic', '合成人'],
  AI: ['AI', '人工智能'],
  'Mech Pilot': ['Mech Pilot', '机甲驾驶员'],
  'Ship Technician': ['Ship Technician', '舰船技术员'],
  'Requisitions Officer': ['Requisitions Officer', '征调官'],
  'Chief Medical Officer': ['Chief Medical Officer', '首席医疗官'],
  'Medical Doctor': ['Medical Doctor', '医生'],
  'Field Researcher': ['Field Researcher', '战地研究员'],
  'Assault Crewman': ['Assault Crewman', '突击队员'],
  'Transport Crewman': ['Transport Crewman', '运输船员'],
  'Squad Marine': ['Squad Marine', '小队陆战队员'],
  'Squad Robot': ['Squad Robot', '小队机器人'],
  'Squad Engineer': ['Squad Engineer', '小队工程师'],
  'Squad Corpsman': ['Squad Corpsman', '小队医护兵'],
  'Squad Smartgunner': ['Squad Smartgunner', '小队智能枪手'],
  'Squad Leader': ['Squad Leader', '小队队长'],
  'Corporate Liaison': ['Corporate Liaison', '企业联络员'],
  Survivor: ['Survivor', '幸存者'],
};

const resolveJobKey = (jobs: PreferencesJobsList | undefined, label: string) =>
  (JOB_KEY_ALIASES[label] || [label]).find((key) => jobs?.[key]) || label;

export const JobPreferences = (props) => {
  const { act, data } = useBackend<JobPreferencesData>();
  const {
    alternate_option,
    squads,
    preferred_squad,
    overflow_job,
    special_occupations,
    special_occupation,
  } = data;
  const [shownDescription, setShownDescription] = useState(null);

  const xenoJobs = ['Xeno Queen', 'Xenomorph'];
  const commandRoles = [
    'Captain',
    'Field Commander',
    'Staff Officer',
    'Pilot Officer',
    'Transport Officer',
    'Synthetic',
    'AI',
    'Mech Pilot',
  ];
  const supportRoles = [
    'Ship Technician',
    'Requisitions Officer',
    'Chief Medical Officer',
    'Medical Doctor',
    'Field Researcher',
    'Assault Crewman',
    'Transport Crewman',
  ];
  const marineJobs = [
    'Squad Marine',
    'Squad Robot',
    'Squad Engineer',
    'Squad Corpsman',
    'Squad Smartgunner',
    'Squad Leader',
  ];
  const flavourJobs = ['Corporate Liaison', 'Survivor'];

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
      title="职业偏好"
      buttons={
        <Button color="bad" icon="power-off" onClick={() => act('jobreset')}>
          全部重置!
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
      <Stack>
        <Stack.Item grow>
          <JobList name="Command Jobs" jobs={commandRoles} />
        </Stack.Item>
        <Stack.Item grow>
          <JobList name="Support Jobs" jobs={supportRoles} />
        </Stack.Item>
      </Stack>
      <Stack>
        <Stack.Item grow>
          <JobList name="Xenomorph Jobs" jobs={xenoJobs} />
        </Stack.Item>
        <Stack.Item grow>
          <JobList name="Flavour Jobs" jobs={flavourJobs} />
        </Stack.Item>
      </Stack>
      <Stack>
        <Stack.Item grow>
          <JobList name="Marine Jobs" jobs={marineJobs} />
        </Stack.Item>
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
                {Object.values(squads).map((squad) => (
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
                {Object.keys(special_occupations).map((special, idx) => (
                  <>
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
                  </>
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
  const jobKey = resolveJobKey(jobs, job);
  const jobData = jobs?.[jobKey];
  const preference = job_preferences?.[jobKey] || 0;

  // A job can disappear from joinable_occupations between static and dynamic
  // data snapshots. Do not dereference an absent record in that short window.
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
            onClick={() => act('bancheck', { role: jobKey })}
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
          onClick={() => act('jobselect', { job: jobKey, level: 3 })}
        />
        <Button.Checkbox
          inline
          content={'Medium'}
          checked={preference === 2}
          onClick={() => act('jobselect', { job: jobKey, level: 2 })}
        />
        <Button.Checkbox
          inline
          content={'Low'}
          checked={preference === 1}
          onClick={() => act('jobselect', { job: jobKey, level: 1 })}
        />
        <Button.Checkbox
          inline
          content={'Never'}
          checked={!preference}
          onClick={() => act('jobselect', { job: jobKey, level: 0 })}
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
