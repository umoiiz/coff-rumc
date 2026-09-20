import {
  Box,
  Button,
  Collapsible,
  Divider,
  Flex,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Message = {
  title: string;
  text: string;
  number: number;
};

type AlertLevelOption = {
  name: string;
  ref: string;
};

type Data = {
  authenticated: number;
  page: string;
  worldtime: number;
  alert_level: number;
  alert_level_text: string;
  tmp_alertlevel: number;
  tmp_alertlevel_text: string;
  evac_status: number;
  dest_status: number;
  evac_eta?: string;
  time_message: number | BooleanLike;
  time_request: number | BooleanLike;
  time_central: number | BooleanLike;
  stat_msg1?: string;
  stat_msg2?: string;
  admins_online: BooleanLike;
  cannot_switch_alert: BooleanLike;
  state_of_emergency: BooleanLike;
  available_alert_levels: AlertLevelOption[];
  messages: Message[] | null;
  current_message: Message | null;
  cooldown_request: number;
  cooldown_central: number;
  cooldown_message: number;
  evacuation_time_lock: number;
  ert_allowed: BooleanLike;
  ship_map_name: string;
};

const SEC_LEVEL_GREEN = 1;
const SEC_LEVEL_BLUE = 2;
const SEC_LEVEL_RED = 3;
const SEC_LEVEL_DELTA = 4;

const EVAC_STANDING_BY = 0;
const EVAC_INITIATING = 1;
const EVAC_IN_PROGRESS = 2;
const EVAC_COMPLETE = 3;

const PAGE_MAIN = 'main';
const PAGE_MESSAGES = 'messages';
const PAGE_VIEW_MESSAGE = 'viewmessage';
const PAGE_STATUS = 'status';
const PAGE_ALERT = 'alert';
const PAGE_CONFIRM_ALERT = 'confirm_alert';

const alertColor = (level: number) => {
  switch (level) {
    case SEC_LEVEL_DELTA:
      return 'purple';
    case SEC_LEVEL_RED:
      return 'red';
    case SEC_LEVEL_BLUE:
      return 'blue';
    case SEC_LEVEL_GREEN:
      return 'green';
    default:
      return undefined;
  }
};

const cooldownRemaining = (
  lastUsed: number | BooleanLike,
  worldTime: number,
  length: number,
) => {
  if (!lastUsed || typeof lastUsed !== 'number') {
    return 0;
  }
  return Math.max(0, Math.ceil((lastUsed + length - worldTime) / 10));
};

export const CommunicationsConsole = () => {
  const { data } = useBackend<Data>();
  const { authenticated, page } = data;

  return (
    <Window width={450} height={700} title="Communications Console">
      <Window.Content scrollable>
        {!authenticated && <LoginPage />}
        {!!authenticated && page === PAGE_MAIN && <MainPage />}
        {!!authenticated && page === PAGE_ALERT && <AlertPage />}
        {!!authenticated && page === PAGE_CONFIRM_ALERT && <ConfirmAlertPage />}
        {!!authenticated && page === PAGE_STATUS && <StatusPage />}
        {!!authenticated && page === PAGE_MESSAGES && <MessagesPage />}
        {!!authenticated && page === PAGE_VIEW_MESSAGE && <ViewMessagePage />}
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

const MainMenuButton = () => {
  const { act } = useBackend<Data>();
  return (
    <Button fluid icon="arrow-left" onClick={() => act('main')}>
      主菜单
    </Button>
  );
};

const MainPage = () => {
  const { act, data } = useBackend<Data>();
  const {
    authenticated,
    alert_level,
    alert_level_text,
    worldtime,
    time_message,
    time_central,
    time_request,
    cooldown_message,
    cooldown_central,
    cooldown_request,
    evacuation_time_lock,
    evac_status,
    evac_eta,
    ert_allowed,
    admins_online,
    messages,
    ship_map_name,
  } = data;

  const announceSecs = cooldownRemaining(
    time_message,
    worldtime,
    cooldown_message,
  );
  const centralSecs = cooldownRemaining(
    time_central,
    worldtime,
    cooldown_central,
  );
  const requestSecs = cooldownRemaining(
    time_request,
    worldtime,
    cooldown_request,
  );
  const evacLockSecs = Math.max(
    0,
    Math.ceil((evacuation_time_lock - worldtime) / 10),
  );

  const canAnnounce = announceSecs <= 0;
  const canCentral = centralSecs <= 0 && !!admins_online;
  const canEvac =
    evac_status === EVAC_STANDING_BY && alert_level >= SEC_LEVEL_RED;
  const canDistress =
    !!ert_allowed &&
    alert_level >= SEC_LEVEL_RED &&
    alert_level < SEC_LEVEL_DELTA &&
    requestSecs <= 0;

  let distressReason = '';
  if (!ert_allowed) {
    distressReason = 'Distress beacon is disabled.';
  } else if (alert_level >= SEC_LEVEL_DELTA) {
    distressReason = 'Self-destruct in progress. Beacon disabled.';
  } else if (alert_level < SEC_LEVEL_RED) {
    distressReason = 'Ship is not under an active emergency.';
  } else if (requestSecs > 0) {
    distressReason = `Beacon is currently recharging. Time remaining: ${requestSecs} secs.`;
  }

  return (
    <Stack vertical>
      <Stack.Item>
        <Section
          title="舰船控制"
          buttons={
            <Button icon="sign-out-alt" onClick={() => act('logout')}>
              登出
            </Button>
          }
        >
          <Flex direction="column">
            <Flex.Item>
              <Button
                fluid
                color={alertColor(alert_level)}
                icon="triangle-exclamation"
                onClick={() => act('changeseclevel')}
              >
                Change alert level; current: {alert_level_text.toUpperCase()}
              </Button>
            </Flex.Item>
            <Flex.Item>
              <Button fluid icon="tv" onClick={() => act('status')}>
                设置状态显示
              </Button>
            </Flex.Item>
            <Flex.Item>
              <Button fluid icon="envelope" onClick={() => act('messagelist')}>
                消息列表
              </Button>
            </Flex.Item>
          </Flex>
        </Section>
      </Stack.Item>

      {authenticated >= 2 && (
        <Stack.Item>
          <Section title="指挥">
            <Flex direction="column">
              <Flex.Item>
                {!canAnnounce ? (
                  <Button color="bad" fluid icon="ban">
                    Announcement recharging: {announceSecs} secs
                  </Button>
                ) : (
                  <Button
                    fluid
                    icon="bullhorn"
                    onClick={() => act('announce')}
                  >
                    发布公告
                  </Button>
                )}
              </Flex.Item>
              <Flex.Item>
                {!admins_online ? (
                  <Button color="bad" fluid icon="ban">
                    TGMC通讯离线
                  </Button>
                ) : !canCentral ? (
                  <Button color="bad" fluid icon="ban">
                    Quantum relay re-cycling: {centralSecs} secs
                  </Button>
                ) : (
                  <Button
                    fluid
                    icon="paper-plane"
                    onClick={() => act('messageTGMC')}
                  >
                    向TGMC发送消息
                  </Button>
                )}
              </Flex.Item>
              <Flex.Item>
                <Button fluid icon="medal" onClick={() => act('award')}>
                  授予勋章
                </Button>
              </Flex.Item>
            </Flex>
          </Section>
        </Stack.Item>
      )}

      {authenticated >= 2 && (
        <Stack.Item>
          <Section title="紧急措施">
            {alert_level < SEC_LEVEL_RED && (
              <NoticeBox color="bad" textAlign="center">
                The ship must be under red alert in order to enact evacuation
                procedures.
              </NoticeBox>
            )}
            {evac_status === EVAC_STANDING_BY && (
              <Button.Confirm
                fluid
                color="orange"
                icon="door-open"
                confirmColor="bad"
                confirmContent={`Evacuate ${ship_map_name}?`}
                confirmIcon="question"
                disabled={!canEvac || evacLockSecs > 0}
                tooltip={
                  evacLockSecs > 0
                    ? `Evacuation locked for ${Math.ceil(evacLockSecs / 60)} more minutes.`
                    : undefined
                }
                onClick={() => act('evacuation_start')}
              >
                Initiate emergency evacuation
              </Button.Confirm>
            )}
            {evac_status === EVAC_INITIATING && (
              <>
                <NoticeBox color="good" textAlign="center">
                  Evacuation ongoing
                  {evac_eta ? `. ETA: ${evac_eta}` : '.'}
                </NoticeBox>
                <Button.Confirm
                  fluid
                  color="red"
                  icon="ban"
                  confirmColor="bad"
                  confirmContent="Cancel Delta Alert?"
                  confirmIcon="question"
                  onClick={() => act('delta_cancel')}
                >
                  Cancel Delta Alert
                </Button.Confirm>
              </>
            )}
            {evac_status === EVAC_IN_PROGRESS && (
              <NoticeBox color="good" textAlign="center">
                逃生舱发射中.
              </NoticeBox>
            )}
            {evac_status === EVAC_COMPLETE && (
              <NoticeBox color="good" textAlign="center">
                撤离完成.
              </NoticeBox>
            )}
            {!!ert_allowed &&
              (!canDistress ? (
                <Button
                  disabled
                  tooltip={distressReason}
                  fluid
                  icon="ban"
                >
                  求救信标已禁用
                </Button>
              ) : (
                <Button.Confirm
                  fluid
                  color="orange"
                  icon="phone-volume"
                  confirmColor="bad"
                  confirmContent="Confirm distress signal?"
                  confirmIcon="question"
                  onClick={() => act('distress')}
                >
                  Send Distress Beacon
                </Button.Confirm>
              ))}
          </Section>
        </Stack.Item>
      )}

      {messages && (
        <Stack.Item>
          <Divider />
          <Collapsible title="Messages">
            <Flex direction="column">
              {messages.map((entry) => (
                <Flex.Item key={entry.number}>
                  <Section
                    title={entry.title}
                    buttons={
                      <Button
                        color="red"
                        icon="trash"
                        onClick={() =>
                          act('delmessage', { number: entry.number })
                        }
                      >
                        删除
                      </Button>
                    }
                  >
                    <Box>{entry.text}</Box>
                  </Section>
                </Flex.Item>
              ))}
            </Flex>
          </Collapsible>
        </Stack.Item>
      )}
    </Stack>
  );
};

const AlertPage = () => {
  const { act, data } = useBackend<Data>();
  const {
    alert_level_text,
    available_alert_levels,
    cannot_switch_alert,
    state_of_emergency,
    dest_status,
    evac_status,
  } = data;

  return (
    <Section title="更改警戒等级" buttons={<MainMenuButton />}>
      <Box mb={1}>
        当前警戒等级: <b>{alert_level_text}</b>
      </Box>
      {!!state_of_emergency && (
        <>
          {dest_status >= 1 && (
            <NoticeBox color="bad">
              The self-destruct mechanism is active.
              {evac_status !== EVAC_INITIATING
                ? ' You have to manually deactivate the self-destruct mechanism.'
                : ''}
            </NoticeBox>
          )}
          {evac_status === EVAC_INITIATING && (
            <NoticeBox color="bad">
              撤离已启动. 请撤离或撤销撤离命令.
            </NoticeBox>
          )}
          {evac_status === EVAC_IN_PROGRESS && (
            <NoticeBox color="bad">撤离进行中.</NoticeBox>
          )}
          {evac_status === EVAC_COMPLETE && (
            <NoticeBox color="bad">撤离完成.</NoticeBox>
          )}
        </>
      )}
      {!!cannot_switch_alert && (
        <NoticeBox>当前无法更改警戒等级.</NoticeBox>
      )}
      {!cannot_switch_alert &&
        available_alert_levels.map((level) => (
          <Button
            key={level.ref}
            fluid
            onClick={() =>
              act('securitylevel', { newalertlevel: level.ref })
            }
          >
            {level.name}
          </Button>
        ))}
    </Section>
  );
};

const ConfirmAlertPage = () => {
  const { act, data } = useBackend<Data>();
  const { alert_level_text, tmp_alertlevel_text } = data;

  return (
    <Section title="确认警戒变更" buttons={<MainMenuButton />}>
      <LabeledList>
        <LabeledList.Item label="当前警戒等级">
          {alert_level_text}
        </LabeledList.Item>
        <LabeledList.Item label="确认变更为">
          {tmp_alertlevel_text}
        </LabeledList.Item>
      </LabeledList>
      <Box mt={1} mb={1}>
        刷卡以确认变更.
      </Box>
      <Button fluid icon="id-card" onClick={() => act('swipeidseclevel')}>
        刷卡
      </Button>
    </Section>
  );
};

const StatusPage = () => {
  const { act, data } = useBackend<Data>();
  const { stat_msg1, stat_msg2 } = data;

  return (
    <Section title="设置状态显示" buttons={<MainMenuButton />}>
      <Flex direction="column">
        <Flex.Item>
          <Button
            fluid
            icon="ban"
            onClick={() => act('setstat', { statdisp: 'blank' })}
          >
            清除
          </Button>
        </Flex.Item>
        <Flex.Item>
          <Button
            fluid
            icon="clock"
            onClick={() => act('setstat', { statdisp: 'time' })}
          >
            空间站时间
          </Button>
        </Flex.Item>
        <Flex.Item>
          <Button
            fluid
            icon="shuttle-space"
            onClick={() => act('setstat', { statdisp: 'shuttle' })}
          >
            穿梭机预计到达时间
          </Button>
        </Flex.Item>
        <Flex.Item>
          <Button
            fluid
            icon="comment"
            onClick={() => act('setstat', { statdisp: 'message' })}
          >
            消息
          </Button>
        </Flex.Item>
      </Flex>
      <LabeledList>
        <LabeledList.Item label="第一行">
          <Button onClick={() => act('setmsg1')}>
            {stat_msg1 || '(none)'}
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="第二行">
          <Button onClick={() => act('setmsg2')}>
            {stat_msg2 || '(none)'}
          </Button>
        </LabeledList.Item>
      </LabeledList>
      <Box mt={1} mb={1}>
        警戒:
      </Box>
      <Flex>
        <Flex.Item grow>
          <Button
            fluid
            onClick={() =>
              act('setstat', { statdisp: 'alert', alert: 'default' })
            }
          >
            无
          </Button>
        </Flex.Item>
        <Flex.Item grow>
          <Button
            fluid
            color="red"
            onClick={() =>
              act('setstat', { statdisp: 'alert', alert: 'redalert' })
            }
          >
            红色警戒
          </Button>
        </Flex.Item>
        <Flex.Item grow>
          <Button
            fluid
            onClick={() =>
              act('setstat', { statdisp: 'alert', alert: 'lockdown' })
            }
          >
            封锁
          </Button>
        </Flex.Item>
        <Flex.Item grow>
          <Button
            fluid
            color="orange"
            onClick={() =>
              act('setstat', { statdisp: 'alert', alert: 'biohazard' })
            }
          >
            生物危害
          </Button>
        </Flex.Item>
      </Flex>
    </Section>
  );
};

const MessagesPage = () => {
  const { act, data } = useBackend<Data>();
  const { messages } = data;

  return (
    <Section title="消息" buttons={<MainMenuButton />}>
      {!messages && <NoticeBox>没有消息.</NoticeBox>}
      {messages?.map((entry) => (
        <Button
          key={entry.number}
          fluid
          onClick={() =>
            act('viewmessage', { 'message-num': entry.number })
          }
        >
          {entry.title}
        </Button>
      ))}
    </Section>
  );
};

const ViewMessagePage = () => {
  const { act, data } = useBackend<Data>();
  const { current_message } = data;

  if (!current_message) {
    return (
      <Section title="消息" buttons={<MainMenuButton />}>
        <NoticeBox>未找到消息.</NoticeBox>
      </Section>
    );
  }

  return (
    <Section
      title={current_message.title}
      buttons={
        <>
          <Button.Confirm
            color="red"
            icon="trash"
            confirmContent="Delete?"
            onClick={() =>
              act('delmessage', { number: current_message.number })
            }
          >
            Delete
          </Button.Confirm>
          <MainMenuButton />
        </>
      }
    >
      <Box>{current_message.text}</Box>
      <Box mt={1}>
        <Button
          icon="list"
          onClick={() => act('messagelist')}
        >
          返回列表
        </Button>
      </Box>
    </Section>
  );
};
