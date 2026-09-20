import { useState } from 'react';
import {
  Box,
  Button,
  Dropdown,
  Input,
  LabeledList,
  NoticeBox,
  NumberInput,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';
import { sanitizeText } from '../sanitize';

type AccessEntry = {
  desc: string;
  ref: number | string;
};

type Region = {
  name: string;
  regid: number;
  accesses: AccessEntry[];
};

type PaygradeOption = {
  paygrade: string;
  name: string;
};

type Data = {
  authenticated: BooleanLike;
  has_id: BooleanLike;
  id_name: string;
  id_rank: string;
  id_owner: string;
  access_on_card: (number | string)[];
  id_account: number;
  has_auth_card: BooleanLike;
  auth_name: string;
  paygrade: string | null;
  paygrade_name: string | null;
  can_modify_paygrade: BooleanLike;
  available_paygrades: PaygradeOption[];
  mode: number;
  printing: BooleanLike;
  manifest: string;
  jobs: string[];
  regions: Region[];
};

const MODE_CARD = 0;
const MODE_MANIFEST = 1;

const accessSelected = (
  selected: (number | string)[],
  ref: number | string,
) => {
  const asString = String(ref);
  return selected.some((entry) => String(entry) === asString);
};

export const CardMod = () => {
  const { act, data } = useBackend<Data>();
  const {
    authenticated,
    has_id,
    id_name,
    id_rank,
    id_owner,
    access_on_card = [],
    id_account,
    has_auth_card,
    auth_name,
    paygrade,
    paygrade_name,
    can_modify_paygrade,
    available_paygrades = [],
    mode,
    printing,
    manifest = '',
    jobs = [],
    regions = [],
  } = data;
  const [tab, setTab] = useState(1);

  const selectedPaygrade =
    available_paygrades.find((entry) => entry.paygrade === paygrade)?.name ||
    paygrade_name ||
    'Unknown';

  return (
    <Window width={520} height={640} title="Identification Card Modifier">
      <Window.Content scrollable>
        <Section
          title="身份卡"
          buttons={
            <>
              <Button
                icon={authenticated ? 'sign-out-alt' : 'sign-in-alt'}
                color={authenticated ? 'bad' : 'good'}
                onClick={() =>
                  act(authenticated ? 'PRG_logout' : 'PRG_authenticate')
                }
              >
                {authenticated ? 'Log Out' : 'Log In'}
              </Button>
              <Button
                icon="users"
                selected={mode === MODE_MANIFEST}
                onClick={() =>
                  act('PRG_mode', {
                    mode: mode === MODE_MANIFEST ? MODE_CARD : MODE_MANIFEST,
                  })
                }
              >
                名单
              </Button>
            </>
          }
        >
          <Stack vertical>
            <Stack.Item>
              <Button fluid icon="eject" onClick={() => act('PRG_eject')}>
                Target: {id_name}
              </Button>
            </Stack.Item>
            <Stack.Item>
              <Button fluid icon="eject" onClick={() => act('PRG_eject_auth')}>
                Auth: {auth_name}
              </Button>
            </Stack.Item>
          </Stack>
          {!authenticated && (
            <NoticeBox mt={1}>
              Insert target and authorization IDs, then log in
              {!has_id && !has_auth_card
                ? '.'
                : !has_id
                  ? ' (target ID missing).'
                  : !has_auth_card
                    ? ' (auth ID missing).'
                    : '.'}
            </NoticeBox>
          )}
        </Section>

        {mode === MODE_MANIFEST && (
          <Section
            title="船员名单"
            buttons={
              <Button
                icon="print"
                disabled={!!printing}
                onClick={() => act('PRG_print')}
              >
                {printing ? 'Printing...' : 'Print'}
              </Button>
            }
          >
            <Box mb={1} color="label">
              无法从此终端修改条目.
            </Box>
            <Box
              dangerouslySetInnerHTML={{
                __html: sanitizeText(manifest),
              }}
            />
          </Section>
        )}

        {mode === MODE_CARD && !!authenticated && !!has_id && (
          <>
            <Section title="注册身份">
              <LabeledList>
                <LabeledList.Item label="名称">
                  <Input
                    value={id_owner}
                    width="250px"
                    expensive
                    onChange={(value) =>
                      act('PRG_edit', {
                        name: value,
                      })
                    }
                  />
                </LabeledList.Item>
                <LabeledList.Item label="账户">
                  <NumberInput
                    step={1}
                    value={id_account || 0}
                    minValue={0}
                    maxValue={999999}
                    width="100px"
                    onChange={(value) =>
                      act('PRG_account', {
                        account: value,
                      })
                    }
                  />
                </LabeledList.Item>
                <LabeledList.Item label="职务">
                  {id_rank}
                </LabeledList.Item>
                <LabeledList.Item label="薪资等级">
                  {can_modify_paygrade ? (
                    <Dropdown
                      width="220px"
                      options={available_paygrades.map((entry) => entry.name)}
                      selected={selectedPaygrade}
                      onSelected={(value) => {
                        const match = available_paygrades.find(
                          (entry) => entry.name === value,
                        );
                        if (match) {
                          act('PRG_paygrade', {
                            paygrade: match.paygrade,
                          });
                        }
                      }}
                    />
                  ) : (
                    <Box>
                      {paygrade_name || paygrade || 'None'} — UNABLE TO MODIFY
                    </Box>
                  )}
                </LabeledList.Item>
              </LabeledList>
            </Section>

            <Tabs>
              <Tabs.Tab selected={tab === 1} onClick={() => setTab(1)}>
                权限
              </Tabs.Tab>
              <Tabs.Tab selected={tab === 2} onClick={() => setTab(2)}>
                职务
              </Tabs.Tab>
            </Tabs>

            {tab === 1 && (
              <Section
                title="权限"
                buttons={
                  <>
                    <Button
                      icon="check-double"
                      color="good"
                      onClick={() => act('PRG_grantall')}
                    >
                      全部授予
                    </Button>
                    <Button
                      icon="times"
                      color="bad"
                      onClick={() => act('PRG_denyall')}
                    >
                      全部拒绝
                    </Button>
                  </>
                }
              >
                {regions.map((region) => (
                  <Section
                    key={region.regid}
                    level={2}
                    title={region.name}
                    buttons={
                      <>
                        <Button
                          icon="check"
                          color="good"
                          onClick={() =>
                            act('PRG_grantregion', {
                              region: region.regid,
                            })
                          }
                        >
                          授予
                        </Button>
                        <Button
                          icon="times"
                          color="bad"
                          onClick={() =>
                            act('PRG_denyregion', {
                              region: region.regid,
                            })
                          }
                        >
                          拒绝
                        </Button>
                      </>
                    }
                  >
                    {region.accesses.map((access) => (
                      <Button
                        key={String(access.ref)}
                        m={0.5}
                        selected={accessSelected(access_on_card, access.ref)}
                        onClick={() =>
                          act('PRG_access', {
                            access_target: access.ref,
                          })
                        }
                      >
                        {access.desc}
                      </Button>
                    ))}
                  </Section>
                ))}
              </Section>
            )}

            {tab === 2 && (
              <Section title={`Jobs — ${id_rank}`}>
                <Button.Input
                  fluid
                  buttonText="Custom..."
                  onCommit={(value) =>
                    act('PRG_assign', {
                      assign_target: 'Custom',
                      custom_name: value,
                    })
                  }
                />
                <Box mt={1}>
                  {jobs
                    .filter((job) => job !== 'Custom')
                    .map((job) => (
                      <Button
                        key={job}
                        m={0.5}
                        selected={job === id_rank}
                        onClick={() =>
                          act('PRG_assign', {
                            assign_target: job,
                          })
                        }
                      >
                        {job}
                      </Button>
                    ))}
                </Box>
              </Section>
            )}
          </>
        )}

        {mode === MODE_CARD && !!authenticated && !has_id && (
          <NoticeBox>
            插入目标身份卡以修改职务和权限.
          </NoticeBox>
        )}
      </Window.Content>
    </Window>
  );
};
