import { useState } from 'react';
import {
  Box,
  Button,
  Flex,
  LabeledList,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { NameInputModal } from './NameInputModal';
import {
  LoadoutItemData,
  LoadoutListData,
  LoadoutManagerData,
  LoadoutTabData,
} from './Types';

const LoadoutItem = (props: LoadoutItemData) => {
  const { act } = useBackend();
  const { loadout } = props;

  return (
    <Box>
      <LabeledList.Item
        labelColor="white"
        buttons={
          <>
            <Button
              icon="arrow-up"
              onClick={() =>
                act('edit_loadout_position', {
                  direction: 'up',
                  loadout_name: loadout.name,
                  loadout_job: loadout.job,
                })
              }
            />
            <Button
              icon="arrow-down"
              onClick={() =>
                act('edit_loadout_position', {
                  direction: 'down',
                  loadout_name: loadout.name,
                  loadout_job: loadout.job,
                })
              }
            />
            <Button
              onClick={() => {
                act('selectLoadout', {
                  loadout_name: loadout.name,
                  loadout_job: loadout.job,
                });
              }}
            >
              选择配装
            </Button>
          </>
        }
        label={loadout.name}
      />
    </Box>
  );
};

const LoadoutList = (props: LoadoutListData) => {
  const { loadout_list } = props;
  return (
    <Stack.Item>
      <Section height={23} fill scrollable>
        <LabeledList>
          {loadout_list.map((loadout_visible) => {
            return (
              <LoadoutItem
                key={loadout_visible.name}
                loadout={loadout_visible}
              />
            );
          })}
        </LabeledList>
      </Section>
    </Stack.Item>
  );
};

const JobTabs = (props: LoadoutTabData) => {
  const { job, setJob } = props;
  return (
    <Section>
      <Flex>
        <Flex.Item grow={1}>
          <div> </div>
        </Flex.Item>
        <Flex.Item>
          <Tabs>
            <Tabs.Tab
              selected={job === 'Squad Marine'}
              onClick={() => setJob('Squad Marine')}
            >
              小队陆战队员
            </Tabs.Tab>
            <Tabs.Tab
              selected={job === 'Squad Robot'}
              onClick={() => setJob('Squad Robot')}
            >
              小队机器人
            </Tabs.Tab>
            <Tabs.Tab
              selected={job === 'Squad Engineer'}
              onClick={() => setJob('Squad Engineer')}
            >
              小队工程师
            </Tabs.Tab>
            <Tabs.Tab
              selected={job === 'Squad Corpsman'}
              onClick={() => setJob('Squad Corpsman')}
            >
              小队医护兵
            </Tabs.Tab>
            <Tabs.Tab
              selected={job === 'Squad Smartgunner'}
              onClick={() => setJob('Squad Smartgunner')}
            >
              小队智能枪手
            </Tabs.Tab>
            <Tabs.Tab
              selected={job === 'Squad Leader'}
              onClick={() => setJob('Squad Leader')}
            >
              小队队长
            </Tabs.Tab>
            <Tabs.Tab
              selected={job === 'Field Commander'}
              onClick={() => setJob('Field Commander')}
            >
              战地指挥官
            </Tabs.Tab>
            <Tabs.Tab
              selected={job === 'Synthetic'}
              onClick={() => setJob('Synthetic')}
            >
              合成人
            </Tabs.Tab>
          </Tabs>
        </Flex.Item>
        <Flex.Item grow={1}>
          <div> </div>
        </Flex.Item>
      </Flex>
    </Section>
  );
};

export const LoadoutManager = (props) => {
  const { act, data } = useBackend<LoadoutManagerData>();
  const { loadout_list } = data;

  const [job, setJob] = useState('Squad Marine');
  const [saveNewLoadout, setSaveNewLoadout] = useState(false);
  const [importNewLoadout, setImportNewLoadout] = useState(false);

  return (
    <Window title="Loadout Manager" width={800} height={400}>
      <Window.Content>
        <Stack vertical>
          <JobTabs job={job} setJob={setJob} />
          <LoadoutList
            loadout_list={loadout_list.filter((loadout) => loadout.job === job)}
          />
          <Flex>
            <Flex.Item grow={1}>
              <div> </div>
            </Flex.Item>
            <Flex.Item>
              <Button onClick={() => setSaveNewLoadout(true)}>
                保存你已装备的配装
              </Button>
            </Flex.Item>
            <Flex.Item grow={1}>
              <div> </div>
            </Flex.Item>
            <Flex.Item>
              <Button onClick={() => setImportNewLoadout(true)}>
                导入配装
              </Button>
            </Flex.Item>
            <Flex.Item grow={1}>
              <div> </div>
            </Flex.Item>
          </Flex>
        </Stack>
        {saveNewLoadout && (
          <NameInputModal
            label="Name of the new Loadout"
            button_text="Save"
            onBack={() => setSaveNewLoadout(false)}
            onSubmit={(name) => {
              act('saveLoadout', {
                loadout_name: name,
                loadout_job: job,
              });
              setSaveNewLoadout(false);
            }}
          />
        )}
        {importNewLoadout && (
          <NameInputModal
            label="Format requested : ckey//job//name_of_loadout "
            button_text="Import the loadout"
            onBack={() => setImportNewLoadout(false)}
            onSubmit={(id) => {
              act('importLoadout', {
                loadout_id: id,
              });
              setImportNewLoadout(false);
            }}
          />
        )}
      </Window.Content>
    </Window>
  );
};
