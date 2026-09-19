import { Button, LabeledList, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { ControllerData } from './types';

export function OverviewSection(props) {
  const { act, data } = useBackend<ControllerData>();
  const {
    fast_update,
    rolling_length,
    map_cpu,
    subsystems = [],
    world_time,
  } = data;

  let avgUsage = 0;
  let overallOverrun = 0;
  for (let i = 0; i < subsystems.length; i++) {
    avgUsage += subsystems[i].usage_per_tick;
    overallOverrun += subsystems[i].tick_overrun;
  }

  return (
    <Section
      fill
      title="主控概览"
      buttons={
        <>
          <Button
            tooltip="快速更新"
            icon={fast_update ? 'check-square-o' : 'square-o'}
            color={fast_update && 'average'}
            onClick={() => {
              act('toggle_fast_update');
            }}
          >
            快速
          </Button>
          <Button.Input
            buttonText={`Average: ${(rolling_length / 10).toFixed(2)} Second(s)`}
            value={(rolling_length / 10).toString()}
            onCommit={(value) => {
              act('set_rolling_length', {
                rolling_length: value,
              });
            }}
          />
        </>
      }
    >
      <Stack fill>
        <Stack.Item grow>
          <LabeledList>
            <LabeledList.Item label="世界时间">
              {world_time.toFixed(1)}
            </LabeledList.Item>
            <LabeledList.Item label="地图CPU">
              {map_cpu.toFixed(2)}%
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
        <Stack.Item grow>
          <LabeledList>
            <LabeledList.Item label="总体平均使用率">
              {avgUsage.toFixed(2)}%
            </LabeledList.Item>
            <LabeledList.Item label="总体超限">
              {overallOverrun.toFixed(2)}%
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
      </Stack>
    </Section>
  );
}
