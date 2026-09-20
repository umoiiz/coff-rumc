import { Box, Button, Section, Stack } from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type AlertOption = {
  name: string;
  ref: string;
};

type Data = {
  waiting: BooleanLike;
  auth_required: BooleanLike;
  event: string;
  is_silicon: BooleanLike;
  available_events: AlertOption[];
  maint_access: BooleanLike;
};

export const KeycardAuth = () => {
  const { act, data } = useBackend<Data>();
  const {
    waiting,
    auth_required,
    event,
    is_silicon,
    available_events = [],
    maint_access,
  } = data;

  return (
    <Window width={420} height={320} title="Keycard Authentication Device">
      <Window.Content>
        <Section>
          {!!waiting && (
            <Box>
              正在等待第二台设备的确认...
            </Box>
          )}
          {!waiting && !!auth_required && (
            <Box>
              <Box mb={1}>
                刷卡以授权: <b>{event}</b>
              </Box>
              <Button
                icon="check-square"
                color="bad"
                textAlign="center"
                lineHeight="40px"
                fluid
                onClick={() => act('auth_swipe')}
              >
                授权
              </Button>
              <Button fluid mt={1} onClick={() => act('reset')}>
                返回
              </Button>
            </Box>
          )}
          {!waiting && !auth_required && (
            <Stack vertical>
              <Stack.Item>
                <Box mb={1}>
                  This device triggers high-security events. Two bridge-level
                  IDs are required{is_silicon ? ' (or silicon confirmation)' : ''}.
                </Box>
              </Stack.Item>
              {available_events.map((entry) => (
                <Stack.Item key={entry.ref}>
                  <Button
                    fluid
                    icon="exclamation-triangle"
                    onClick={() =>
                      act('trigger_event', { event: entry.ref })
                    }
                  >
                    Set alert level to {entry.name}
                  </Button>
                </Stack.Item>
              ))}
              <Stack.Item>
                <Button
                  fluid
                  icon="wrench"
                  onClick={() =>
                    act('trigger_event', {
                      event: 'Grant Emergency Maintenance Access',
                    })
                  }
                >
                  授予紧急维护权限
                </Button>
              </Stack.Item>
              <Stack.Item>
                <Button
                  fluid
                  icon="lock"
                  disabled={!maint_access}
                  onClick={() =>
                    act('trigger_event', {
                      event: 'Revoke Emergency Maintenance Access',
                    })
                  }
                >
                  撤销紧急维护权限
                </Button>
              </Stack.Item>
            </Stack>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
