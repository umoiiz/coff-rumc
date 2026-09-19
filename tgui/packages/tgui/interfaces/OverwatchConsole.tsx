import { useMemo } from 'react';
import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type SquadInfo = {
  id: string | number;
  name: string;
  color?: string;
  leader?: string;
  leader_ref?: string;
  overwatch_officer?: string;
  primary_objective?: string;
  secondary_objective?: string;
};

type MarineRow = {
  ref: string;
  name: string;
  role: string;
  acting_sl: BooleanLike;
  fireteam?: string;
  state: string;
  area: string;
  distance: string;
  is_dead: BooleanLike;
  is_leader: BooleanLike;
  sort_health: number;
  sort_rank: number;
};

type MonitorData = {
  marines: MarineRow[];
  leader_count: number;
  medic_count: number;
  engi_count: number;
  smart_count: number;
  marine_count: number;
  living_count: number;
  total_deployed: number;
  smart_label: string;
  primary_objective?: string;
  secondary_objective?: string;
  overwatch_officer?: string;
};

type FireTarget = {
  name: string;
  ref: string;
};

type FireSupportData = {
  ob_ready: BooleanLike;
  ob_status: string;
  selected_target?: string;
  selected_target_ref?: string;
  ob_lasers: FireTarget[];
  beacons: FireTarget[];
  rail_ready: BooleanLike;
  rail_status: string;
  rail_lasers: FireTarget[];
};

type Data = {
  console_type: 'basic' | 'military' | 'main';
  operator?: string;
  can_interact: BooleanLike;
  on_monitor: BooleanLike;
  sort_by_health: BooleanLike;
  hide_dead: BooleanLike;
  z_hidden: number;
  ship_map_name: string;
  squads: SquadInfo[];
  current_squad: SquadInfo | null;
  monitor: MonitorData | null;
  firesupport?: FireSupportData;
};

const HIDE_NONE = 0;
const HIDE_ON_GROUND = 1;
const HIDE_ON_SHIP = 2;

const zFilterLabel = (zHidden: number, shipName: string) => {
  switch (zHidden) {
    case HIDE_ON_SHIP:
      return `Hiding: ${shipName}`;
    case HIDE_ON_GROUND:
      return 'Hiding: Ground';
    default:
      return 'Showing: All locations';
  }
};

export const OverwatchConsole = () => {
  const { data } = useBackend<Data>();
  const { operator, on_monitor, console_type } = data;

  return (
    <Window width={640} height={780} title="Overwatch Console">
      <Window.Content scrollable>
        {!operator && <LoginPanel />}
        {!!operator && on_monitor && <MonitorPanel />}
        {!!operator && !on_monitor && console_type === 'main' && (
          <MainPanel />
        )}
        {!!operator &&
          !on_monitor &&
          console_type !== 'main' &&
          !data.current_squad && <PickSquadPanel />}
        {!!operator &&
          !on_monitor &&
          console_type !== 'main' &&
          !!data.current_squad && <SquadPanel />}
      </Window.Content>
    </Window>
  );
};

const LoginPanel = () => {
  const { act } = useBackend<Data>();
  return (
    <Section title="操作员">
      <Button fluid icon="sign-in-alt" onClick={() => act('claim')}>
        申请监督
      </Button>
    </Section>
  );
};

const OperatorHeader = () => {
  const { act, data } = useBackend<Data>();
  return (
    <Section
      title={`Operator: ${data.operator}`}
      buttons={
        <Button icon="sign-out-alt" color="bad" onClick={() => act('logout')}>
          停止监督
        </Button>
      }
    />
  );
};

const PickSquadPanel = () => {
  const { act, data } = useBackend<Data>();
  return (
    <Stack vertical>
      <Stack.Item>
        <OperatorHeader />
      </Stack.Item>
      <Stack.Item>
        <Section title="选择小队">
          {!data.squads?.length && (
            <NoticeBox>没有可用的小队.</NoticeBox>
          )}
          {data.squads?.map((squad) => (
            <Button
              key={squad.id}
              fluid
              onClick={() => act('pick_squad', { squad_id: squad.id })}
            >
              {squad.name}
            </Button>
          ))}
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const SquadPanel = () => {
  const { act, data } = useBackend<Data>();
  const squad = data.current_squad!;
  const isMilitary = data.console_type === 'military';

  return (
    <Stack vertical>
      <Stack.Item>
        <OperatorHeader />
      </Stack.Item>
      <Stack.Item>
        <Section
          title={`${squad.name} Squad`}
          buttons={
            isMilitary ? (
              <Button icon="bullhorn" onClick={() => act('message')}>
                发送消息至小队
              </Button>
            ) : undefined
          }
        >
          <LabeledList>
            <LabeledList.Item
              label="小队长"
              buttons={
                <>
                  {!!squad.leader_ref && (
                    <Button
                      icon="video"
                      onClick={() =>
                        act('jump', { target: squad.leader_ref })
                      }
                    >
                      {squad.leader}
                    </Button>
                  )}
                  {!squad.leader && <Box color="bad">无</Box>}
                  {isMilitary && (
                    <>
                      {!!squad.leader && (
                        <Button onClick={() => act('sl_message')}>消息</Button>
                      )}
                      <Button onClick={() => act('change_lead')}>
                        {squad.leader
                          ? 'CHANGE SQUAD LEADER'
                          : 'ASSIGN SQUAD LEADER'}
                      </Button>
                    </>
                  )}
                </>
              }
            >
              {squad.leader || 'NONE'}
            </LabeledList.Item>
            {isMilitary && (
              <>
                <LabeledList.Item
                  label="主要目标"
                  buttons={
                    <Button onClick={() => act('set_primary')}>设置</Button>
                  }
                >
                  {squad.primary_objective || (
                    <Box color="bad">无!</Box>
                  )}
                </LabeledList.Item>
                <LabeledList.Item
                  label="次要目标"
                  buttons={
                    <Button onClick={() => act('set_secondary')}>设置</Button>
                  }
                >
                  {squad.secondary_objective || (
                    <Box color="bad">无!</Box>
                  )}
                </LabeledList.Item>
              </>
            )}
          </LabeledList>
          {isMilitary && (
            <Box mt={1}>
              <Button fluid onClick={() => act('squad_transfer')}>
                将一名陆战队员转移到其他小队
              </Button>
            </Box>
          )}
          <Box mt={1}>
            <Button fluid icon="desktop" onClick={() => act('monitor')}>
              小队监控
            </Button>
          </Box>
        </Section>
      </Stack.Item>
      {isMilitary && data.firesupport && (
        <Stack.Item>
          <FireSupportPanel />
        </Stack.Item>
      )}
    </Stack>
  );
};

const MainPanel = () => {
  const { act, data } = useBackend<Data>();
  return (
    <Stack vertical>
      <Stack.Item>
        <OperatorHeader />
      </Stack.Item>
      <Stack.Item>
        <Section title="小队">
          {data.squads?.map((squad) => (
            <Section
              key={squad.id}
              title={`${squad.name} Squad`}
              buttons={
                <>
                  <Button
                    onClick={() =>
                      act('message', { squad_id: squad.id })
                    }
                  >
                    发送消息至小队
                  </Button>
                  <Button
                    onClick={() =>
                      act('monitor', { squad_id: squad.id })
                    }
                  >
                    监控
                  </Button>
                </>
              }
            >
              <LabeledList>
                <LabeledList.Item
                  label="队长"
                  buttons={
                    !!squad.leader_ref && (
                      <>
                        <Button
                          icon="video"
                          onClick={() =>
                            act('jump', { target: squad.leader_ref })
                          }
                        >
                          摄像头
                        </Button>
                        <Button
                          onClick={() =>
                            act('sl_message', { squad_id: squad.id })
                          }
                        >
                          消息
                        </Button>
                      </>
                    )
                  }
                >
                  {squad.leader || <Box color="bad">无</Box>}
                </LabeledList.Item>
                <LabeledList.Item label="小队监督">
                  {squad.overwatch_officer || (
                    <Box color="bad">无</Box>
                  )}
                </LabeledList.Item>
              </LabeledList>
            </Section>
          ))}
        </Section>
      </Stack.Item>
      {data.firesupport && (
        <Stack.Item>
          <FireSupportPanel />
        </Stack.Item>
      )}
    </Stack>
  );
};

const MonitorPanel = () => {
  const { act, data } = useBackend<Data>();
  const monitor = data.monitor;

  const marines = useMemo(() => {
    const list = monitor?.marines ? [...monitor.marines] : [];
    if (data.sort_by_health) {
      list.sort((a, b) => a.sort_health - b.sort_health);
    } else {
      list.sort((a, b) => a.sort_rank - b.sort_rank);
    }
    return list;
  }, [monitor?.marines, data.sort_by_health]);

  if (!monitor) {
    return (
      <Stack vertical>
        <Stack.Item>
          <OperatorHeader />
        </Stack.Item>
        <Stack.Item>
          <NoticeBox>未选择小队.</NoticeBox>
          <Button fluid onClick={() => act('back')}>
            返回
          </Button>
        </Stack.Item>
      </Stack>
    );
  }

  return (
    <Stack vertical>
      <Stack.Item>
        <OperatorHeader />
      </Stack.Item>
      <Stack.Item>
        <Section
          title={`${data.current_squad?.name || 'Squad'} Monitor`}
          buttons={
            <Button icon="arrow-left" onClick={() => act('back')}>
              返回
            </Button>
          }
        >
          <LabeledList>
            <LabeledList.Item label="小队监督">
              {monitor.overwatch_officer || <Box color="bad">无</Box>}
            </LabeledList.Item>
            <LabeledList.Item label="小队长">
              {monitor.leader_count ? (
                'Deployed'
              ) : (
                <Box color="bad">未部署小队长!</Box>
              )}
            </LabeledList.Item>
            <LabeledList.Item label={monitor.smart_label}>
              {monitor.smart_count} Deployed
            </LabeledList.Item>
            <LabeledList.Item label="医护兵 / 工程师">
              {monitor.medic_count} / {monitor.engi_count} Deployed
            </LabeledList.Item>
            <LabeledList.Item label="陆战队员">
              {monitor.marine_count} Deployed
            </LabeledList.Item>
            <LabeledList.Item label="总数 / 存活">
              {monitor.total_deployed} / {monitor.living_count}
            </LabeledList.Item>
            <LabeledList.Item label="主要">
              {monitor.primary_objective || <Box color="bad">无!</Box>}
            </LabeledList.Item>
            <LabeledList.Item label="次要">
              {monitor.secondary_objective || <Box color="bad">无!</Box>}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section
          title="陆战队员"
          buttons={
            <>
              <Button onClick={() => act('toggle_sort')}>
                {data.sort_by_health ? 'Sort by rank' : 'Sort by health'}
              </Button>
              <Button onClick={() => act('toggle_dead')}>
                {data.hide_dead ? 'Show Dead' : 'Hide Dead'}
              </Button>
              <Button onClick={() => act('cycle_z')}>
                {zFilterLabel(data.z_hidden, data.ship_map_name)}
              </Button>
            </>
          }
        >
          <Table>
            <Table.Row header>
              <Table.Cell>Name</Table.Cell>
              <Table.Cell>Role</Table.Cell>
              <Table.Cell>State</Table.Cell>
              <Table.Cell>Location</Table.Cell>
              <Table.Cell>SL Dist</Table.Cell>
            </Table.Row>
            {marines.map((marine) => (
              <Table.Row key={marine.ref}>
                <Table.Cell>
                  <Button
                    onClick={() => act('jump', { target: marine.ref })}
                  >
                    {marine.name}
                  </Button>
                </Table.Cell>
                <Table.Cell>
                  {marine.role}
                  {marine.acting_sl ? ' (acting SL)' : ''}
                  {marine.fireteam ? ` [${marine.fireteam}]` : ''}
                </Table.Cell>
                <Table.Cell color={marine.is_dead ? 'bad' : undefined}>
                  {marine.state}
                </Table.Cell>
                <Table.Cell>{marine.area}</Table.Cell>
                <Table.Cell>{marine.distance}</Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const FireSupportPanel = () => {
  const { act, data } = useBackend<Data>();
  const fs = data.firesupport!;
  const squadPrefix = data.current_squad
    ? `${data.current_squad.name} `
    : '';

  return (
    <Stack vertical>
      <Stack.Item>
        <Section title="轨道轰炸控制">
          <LabeledList>
            <LabeledList.Item label="当前火炮状态">
              <Box color={fs.ob_ready ? 'good' : 'bad'}>{fs.ob_status}</Box>
            </LabeledList.Item>
            <LabeledList.Item label="选定目标">
              {fs.selected_target || <Box color="average">无</Box>}
            </LabeledList.Item>
          </LabeledList>
          <Box mt={1} mb={0.5} bold>
            {squadPrefix}Laser Targets:
          </Box>
          {!fs.ob_lasers?.length && <Box color="average">无</Box>}
          {fs.ob_lasers?.map((target) => (
            <Button
              key={target.ref}
              fluid
              onClick={() => act('select_target', { target: target.ref })}
            >
              {target.name}
            </Button>
          ))}
          <Box mt={1} mb={0.5} bold>
            信标目标:
          </Box>
          {!fs.beacons?.length && (
            <Box color="average">无信号传输</Box>
          )}
          {fs.beacons?.map((beacon) => (
            <Button
              key={beacon.ref}
              fluid
              onClick={() => act('select_target', { target: beacon.ref })}
            >
              {beacon.name}
            </Button>
          ))}
          <Box mt={1}>
            <Button.Confirm
              fluid
              color="bad"
              icon="bomb"
              confirmContent="FIRE OB?"
              onClick={() => act('dropbomb')}
            >
              FIRE!
            </Button.Confirm>
          </Box>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="电磁炮控制">
          <LabeledList>
            <LabeledList.Item label="当前电磁炮状态">
              <Box color={fs.rail_ready ? 'good' : 'average'}>
                {fs.rail_status}
              </Box>
            </LabeledList.Item>
            <LabeledList.Item label="选定目标">
              {fs.selected_target || <Box color="average">无</Box>}
            </LabeledList.Item>
          </LabeledList>
          <Box mt={1} mb={0.5} bold>
            {squadPrefix}Laser Targets:
          </Box>
          {!fs.rail_lasers?.length && <Box color="average">无</Box>}
          {fs.rail_lasers?.map((target) => (
            <Button
              key={target.ref}
              fluid
              onClick={() => act('select_target', { target: target.ref })}
            >
              {target.name}
            </Button>
          ))}
          <Box mt={1}>
            <Button.Confirm
              fluid
              color="bad"
              icon="crosshairs"
              confirmContent="FIRE RAILGUN?"
              disabled={!fs.rail_ready}
              onClick={() => act('shootrailgun')}
            >
              FIRE!
            </Button.Confirm>
          </Box>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
