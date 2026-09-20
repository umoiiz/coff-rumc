import { Box, Button, Section } from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type EquipmentData = {
  name: string;
  eqp_tag: number;
  is_weapon: BooleanLike;
  is_interactable: BooleanLike;
};

type MiniDropshipProps = {
  fly_state: string;
  take_off_locked: BooleanLike;
  return_to_ship_locked: BooleanLike;
  takeoff_alarm: BooleanLike;
  equipment_data: EquipmentData[];
};

export const Minidropship = (_props) => {
  const { act, data } = useBackend<MiniDropshipProps>();
  const {
    fly_state,
    take_off_locked,
    return_to_ship_locked,
    takeoff_alarm,
    equipment_data,
  } = data;
  return (
    <Window width={220} height={340} title={'Navigation'}>
      <Window.Content scrollable>
        <Section title={`Fly state - ${fly_state}`}>
          <Button disabled={take_off_locked} onClick={() => act('take_off')}>
            脱下
          </Button>
          <Button onClick={() => act('toggle_shutters')}>
            切换百叶窗
          </Button>
          <Button
            disabled={return_to_ship_locked}
            onClick={() => act('return_to_ship')}
          >
            返回飞船
          </Button>
          <Button onClick={() => act('toggle_nvg')}>
            切换夜视模式
          </Button>
          <Button
            onClick={() => act('takeoff_alarm')}
            tooltip="这会警告附近所有人. 请谨慎使用. 将运输机送往新目的地会自动关闭此功能."
            color={takeoff_alarm ? 'red' : 'yellow'}
          >
            {takeoff_alarm ? 'Stop' : 'Start'} takeoff alarm
          </Button>
        </Section>
        <Section title="已安装设备">
          {equipment_data.length > 0 ? (
            equipment_data.map((equipment) => (
              <Box key={equipment.eqp_tag}>
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
      </Window.Content>
    </Window>
  );
};
