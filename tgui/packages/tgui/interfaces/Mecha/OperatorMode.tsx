import { ByondUi, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { AlertPane } from './AlertPane';
import { ArmorPane } from './ArmorPane';
import { ArmPane } from './ArmPane';
import { OperatorData } from './data';
import { MechStatPane } from './MechStatPane';
import { PowerModulesPane } from './PowerModulesPane';
import { RadioPane } from './RadioPane';
import { UtilityModulesPane } from './UtilityModulesPane';

export const OperatorMode = (props) => {
  const { act, data } = useBackend<OperatorData>();
  const { left_arm_weapon, right_arm_weapon, mech_view } = data;
  return (
    <Stack fill>
      <Stack.Item grow>
        <Stack fill vertical>
          <Stack.Item grow>
            <Section fill>
              {left_arm_weapon ? <ArmPane weapon={left_arm_weapon} /> : null}
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section title="电源模块">
              <PowerModulesPane />
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section title="警报">
              <AlertPane />
            </Section>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>
        <Stack fill vertical>
          <Stack.Item>
            <ByondUi
              height="170px"
              params={{
                id: mech_view,
                zoom: 5,
                type: 'map',
              }}
            />
          </Stack.Item>
          <Stack.Item>
            <Section title="护甲模块">
              <ArmorPane />
            </Section>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>
        <Stack fill vertical>
          <Stack.Item grow>
            <Section fill>
              {right_arm_weapon ? <ArmPane weapon={right_arm_weapon} /> : null}
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section title="实用模块">
              <UtilityModulesPane />
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section title="无线电控制">
              <RadioPane />
            </Section>
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item grow>
        <Stack fill vertical>
          <Stack.Item grow>
            <Section fill>
              <MechStatPane />
            </Section>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};
