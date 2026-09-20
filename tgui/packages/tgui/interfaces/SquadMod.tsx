import { Box, Button, NoticeBox, Section, Stack } from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type SquadEntry = {
  name: string;
  color: string;
};

type Data = {
  id_name: string;
  has_id: BooleanLike;
  squads: SquadEntry[];
};

export const SquadMod = () => {
  const { act, data } = useBackend<Data>();
  const { squads = [], id_name, has_id } = data;

  return (
    <Window width={400} height={360} title="Squad Distribution">
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <Section>
              <Button fluid icon="eject" onClick={() => act('PRG_eject')}>
                {id_name}
              </Button>
              {!has_id && (
                <NoticeBox mt={1}>
                  输入你想要转移的人员ID.
                </NoticeBox>
              )}
            </Section>
          </Stack.Item>
          {!!has_id && (
            <Stack.Item grow>
              <Section title="小队转移" fill scrollable>
                {!squads.length && (
                  <Box color="label">没有可用的小队.</Box>
                )}
                {squads.map((entry) => (
                  <Button
                    key={entry.name}
                    fluid
                    backgroundColor={entry.color}
                    onClick={() => act('PRG_squad', { name: entry.name })}
                  >
                    {entry.name}
                  </Button>
                ))}
              </Section>
            </Stack.Item>
          )}
        </Stack>
      </Window.Content>
    </Window>
  );
};
