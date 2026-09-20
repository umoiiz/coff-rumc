import {
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import { OperatorData } from './data';

export const MechStatPane = () => {
  const { act, data } = useBackend<OperatorData>();
  const { name, integrity, weapons_safety } = data;
  return (
    <Stack fill vertical>
      <Stack.Item>
        <Section
          title={name}
          buttons={<Button onClick={() => act('changename')}>重命名</Button>}
        />
      </Stack.Item>
      <Stack.Item>
        <Section title="状态">
          <LabeledList>
            <LabeledList.Item label="完整度">
              <ProgressBar
                ranges={{
                  good: [0.5, Infinity],
                  average: [0.25, 0.5],
                  bad: [-Infinity, 0.25],
                }}
                value={integrity}
              />
            </LabeledList.Item>
            <LabeledList.Item label="电量">
              <PowerBar />
            </LabeledList.Item>
            <LabeledList.Item label="保险">
              <Button
                color={weapons_safety ? 'red' : ''}
                onClick={() => act('toggle_safety')}
              >
                {weapons_safety ? 'Dis' : 'En'}able
              </Button>
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const PowerBar = () => {
  const { data } = useBackend<OperatorData>();
  const { power_level, power_max } = data;
  if (power_max === null) {
    return <Box> 未安装电池!</Box>;
  } else {
    return (
      <ProgressBar
        ranges={{
          good: [0.75 * power_max, Infinity],
          average: [0.25 * power_max, 0.75 * power_max],
          bad: [-Infinity, 0.25 * power_max],
        }}
        maxValue={power_max}
        value={power_level}
      />
    );
  }
};
