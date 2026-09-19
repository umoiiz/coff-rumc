import {
  Button,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const SelfDestruct = (props) => {
  const { act, data } = useBackend();
  const { dest_status, detonation_time, detonation_pcent } = data;
  return (
    <Window width={470} height={290}>
      <Window.Content>
        <Section title="总览">
          <LabeledList>
            <LabeledList.Item label="状态:">
              {(dest_status === 0 && <span className="idle">DISARMED</span>) ||
                (dest_status === 1 && (
                  <span className="average">AWAITING INPUT</span>
                )) ||
                (dest_status === 2 && <span className="good">ARMED</span>) || (
                  <span className="bad">ERROR</span>
                )}
            </LabeledList.Item>
          </LabeledList>
        </Section>

        {dest_status === 2 && (
          <Section title="引爆倒计时">
            <ProgressBar
              value={detonation_pcent}
              ranges={{
                good: [1, Infinity],
                average: [0.3, 0.7],
                bad: [-Infinity, 0.3],
              }}
            />
            <LabeledList>
              <LabeledList.Item label="剩余时间:">
                {detonation_time}
              </LabeledList.Item>
            </LabeledList>
          </Section>
        )}

        <Section title="控制">
          {(dest_status === 1 && (
            <Button
              icon="exclamation-triangle"
              content="激活系统"
              color="yellow"
              onClick={() => act('dest_start')}
            />
          )) ||
            (dest_status === 2 && (
              <>
                <Button
                  icon="exclamation-triangle"
                  content="启动"
                  color="red"
                  onClick={() => act('dest_trigger')}
                />
                <Button
                  icon="exclamation-triangle"
                  content="取消"
                  color="yellow"
                  onClick={() => act('dest_cancel')}
                />
              </>
            )) ||
            (dest_status === 0 && <span className="idle">OFFLINE</span>) || (
              <span className="bad">ERROR</span>
            )}
        </Section>
      </Window.Content>
    </Window>
  );
};
