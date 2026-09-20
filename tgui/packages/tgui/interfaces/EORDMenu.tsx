import { Box, Button, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

/**
 * Показывается только игрокам в лобби (/mob/new_player), когда начинается
 * End Of Round Deathmatch. Действия вызывают те же do_eord_respawn()/do_xeno_eord_respawn(),
 * что и OOC-глаголы «EORD Respawn» / «EORD Xeno Respawn».
 */
export function EORDMenu(props) {
  const { act } = useBackend();

  return (
    <Window width={420} height={310} title="Конец раунда">
      <Window.Content>
        <Section fill>
          <Stack vertical fill>
            <Stack.Item>
              <Box bold fontSize="1.2em" mb={1}>
                回合结束!
              </Box>
              <Box color="label">
                你可以安心等待下一回合开始,或者
                在回合结束时的死亡竞赛中重返战斗.
              </Box>
            </Stack.Item>
            <Stack.Item grow />
            <Stack.Item>
              <Stack vertical>
                <Stack.Item>
                  <Button fluid icon="clock" onClick={() => act('wait')}>
                    在大厅等待下一回合
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    fluid
                    color="good"
                    icon="user"
                    onClick={() => act('join_human')}
                  >
                    以人类身份加入EORD
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    fluid
                    color="bad"
                    icon="biohazard"
                    onClick={() => act('join_xeno')}
                  >
                    以异形身份加入EORD
                  </Button>
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
}
