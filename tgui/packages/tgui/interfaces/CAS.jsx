import {
  Box,
  Button,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const CAS = (props) => {
  const { act, data } = useBackend();

  return (
    <Window>
      <Window.Content scrollable>
        {data.screen_mode === 0 && <WeaponSelection />}
        {data.screen_mode === 1 && <FiringMode />}
      </Window.Content>
    </Window>
  );
};

const WeaponSelection = (props) => {
  const { act, data } = useBackend();

  return (
    <Section title="已安装设备">
      {data.equipment_data.length > 0 ? (
        data.equipment_data.map((equipment) => (
          <Box key={equipment.id}>
            <Button
              onClick={() =>
                act('equip_interact', { equip_interact: equipment.eqp_tag })
              }
              disabled={!equipment.is_interactable}
            >
              {equipment.name}
            </Button>
          </Box>
        ))
      ) : (
        <Box>未安装设备.</Box>
      )}
    </Section>
  );
};

const FiringMode = (props) => {
  const { act, data } = useBackend();

  return (
    <>
      <Section
        title={'Weapon Selected: ' + data.selected_eqp}
        buttons={<Button onClick={() => act('deselect')}>取消选择</Button>}
      >
        {!data.selected_eqp_ammo_name ? (
          <Box color="bad">未装填弹药</Box>
        ) : (
          <LabeledList>
            <LabeledList.Item label="已装填弹药">
              {data.selected_eqp_ammo_name}
            </LabeledList.Item>
            <LabeledList.Item label="弹药数量">
              <ProgressBar
                ranges={{
                  good: [0.5, Infinity],
                  average: [0, 0.5],
                  bad: [-Infinity, 0],
                }}
                value={
                  data.selected_eqp_ammo_amt / data.selected_eqp_max_ammo_amt
                }
                content={
                  data.selected_eqp_ammo_amt +
                  ' / ' +
                  data.selected_eqp_max_ammo_amt
                }
              />
            </LabeledList.Item>
          </LabeledList>
        )}
      </Section>
      <Section title="可用目标">
        {data.targets_data.length > 0 ? (
          data.targets_data.map((target) => (
            <Box key={target.id}>
              <Button
                disabled={!data.shuttle_mode}
                onClick={() =>
                  act('open_fire', { open_fire: target.target_tag })
                }
              >
                {target.target_name}
              </Button>
            </Box>
          ))
        ) : (
          <Box>未检测到激光目标.</Box>
        )}
      </Section>
    </>
  );
};
