import { Box, Button, Section } from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type EscapePodData = {
  can_launch: BooleanLike;
};

export const EscapePod = (props) => {
  const { act, data } = useBackend<EscapePodData>();
  return (
    <Window title="Escape Pod" width={400} height={140}>
      <Window.Content>
        <Section title="逃生舱">
          欢迎来到纳米传讯最不豪华的生存舱!祝您
          旅途愉快!
          <Box width="100%" textAlign="center">
            <Button.Confirm
              m="50"
              disabled={!data.can_launch}
              color="red"
              onClick={() => act('launch')}
            >
              Launch evacuation pod
            </Button.Confirm>
          </Box>
        </Section>
      </Window.Content>
    </Window>
  );
};
