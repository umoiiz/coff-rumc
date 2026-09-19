import {
  Box,
  Button,
  Flex,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  authenticated: number | BooleanLike;
  current_orbit: number;
  power_amount: number;
  engines_ready: BooleanLike;
  can_change_orbit: BooleanLike;
  changing_orbit: BooleanLike;
  ship_map_name: string;
  required_power: number;
  high_orbit: number;
  standard_orbit: number;
  low_orbit: number;
};

export const NavigationConsole = () => {
  const { data } = useBackend<Data>();
  const { authenticated } = data;

  return (
    <Window width={420} height={360} title="Navigation">
      <Window.Content>
        {!authenticated ? <LoginPage /> : <MainPage />}
      </Window.Content>
    </Window>
  );
};

const LoginPage = () => {
  const { act } = useBackend<Data>();
  return (
    <Section title="身份验证">
      <Button fluid icon="sign-in-alt" onClick={() => act('login')}>
        登录
      </Button>
    </Section>
  );
};

const MainPage = () => {
  const { act, data } = useBackend<Data>();
  const {
    ship_map_name,
    current_orbit,
    power_amount,
    engines_ready,
    can_change_orbit,
    changing_orbit,
    required_power,
    high_orbit,
    low_orbit,
  } = data;

  const atHighOrbit = current_orbit >= high_orbit;
  const atLowOrbit = current_orbit <= low_orbit;

  return (
    <Stack vertical fill>
      <Stack.Item>
        <Section
          title={ship_map_name}
          buttons={
            <Button icon="sign-out-alt" onClick={() => act('logout')}>
              登出
            </Button>
          }
        >
          <Box textAlign="center" fontSize="28px" mb={1} bold>
            {current_orbit}
          </Box>
          <LabeledList>
            <LabeledList.Item label="功率等级">
              {Math.round(power_amount)}
            </LabeledList.Item>
            <LabeledList.Item label="引擎已准备">
              {engines_ready ? (
                <Box color="good">就绪</Box>
              ) : (
                <Box color="average">重新计算中</Box>
              )}
            </LabeledList.Item>
            <LabeledList.Item label="所需电力">
              {required_power}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>

      <Stack.Item grow>
        <Section title="轨道控制" fill>
          {!!changing_orbit && (
            <NoticeBox>轨道变更进行中.</NoticeBox>
          )}
          {!can_change_orbit ? (
            <NoticeBox color="bad">
              电力储备不足,无法变更轨道
            </NoticeBox>
          ) : (
            <Flex>
              <Flex.Item grow>
                <Button
                  fluid
                  icon="arrow-up"
                  disabled={!engines_ready || atHighOrbit}
                  tooltip={
                    atHighOrbit
                      ? '已处于最高轨道.'
                      : !engines_ready
                        ? '引擎正在重新计算.'
                        : undefined
                  }
                  onClick={() => act('UP')}
                >
                  提升轨道等级
                </Button>
              </Flex.Item>
              <Flex.Item grow>
                <Button
                  fluid
                  icon="arrow-down"
                  disabled={!engines_ready || atLowOrbit}
                  tooltip={
                    atLowOrbit
                      ? '已处于最低轨道.'
                      : !engines_ready
                        ? '引擎正在重新计算.'
                        : undefined
                  }
                  onClick={() => act('DOWN')}
                >
                  降低轨道等级
                </Button>
              </Flex.Item>
            </Flex>
          )}
        </Section>
      </Stack.Item>
    </Stack>
  );
};
