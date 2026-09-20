import { sortBy } from 'common/collections';
import { Box, Flex, ProgressBar, Section, Table } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const JOB_REPORT_MENU_FAIL_REASON_TRACKING_DISABLED = 1;
const JOB_REPORT_MENU_FAIL_REASON_NO_RECORDS = 2;

type Playtimes = Record<string, number>;

type TrackedPlaytimeData = {
  failReason?: number;
  jobPlaytimes: Playtimes;
  specialPlaytimes: Playtimes;
  castePlaytimes: Playtimes;
  livingTime: number;
  ghostTime: number;
};

const PlaytimeSection = (props: { playtimes: Playtimes }) => {
  const sortedPlaytimes = sortBy(
    Object.entries(props.playtimes),
    ([, playtime]) => -playtime,
  );
  // Empty categories and new players must not produce a zero-width scale.
  const mostPlayed = Math.max(sortedPlaytimes[0]?.[1] ?? 0, 1);

  return (
    <Table>
      {sortedPlaytimes.map(([jobName, playtime]) => (
        <Table.Row key={jobName}>
          <Table.Cell collapsing p={0.5} style={{ verticalAlign: 'middle' }}>
            <Box textAlign="right">{jobName}</Box>
          </Table.Cell>
          <Table.Cell>
            <ProgressBar maxValue={mostPlayed} value={playtime}>
              <Flex>
                <Flex.Item width={`${(playtime / mostPlayed) * 100}%`} />
                <Flex.Item>
                  {(playtime / 60).toLocaleString(undefined, {
                    minimumFractionDigits: 1,
                    maximumFractionDigits: 1,
                  })}
                  h
                </Flex.Item>
              </Flex>
            </ProgressBar>
          </Table.Cell>
        </Table.Row>
      ))}
    </Table>
  );
};

export const TrackedPlaytime = () => {
  const { data } = useBackend<TrackedPlaytimeData>();
  const {
    failReason,
    jobPlaytimes = {},
    specialPlaytimes = {},
    castePlaytimes = {},
    livingTime = 0,
    ghostTime = 0,
  } = data;

  return (
    <Window width={550} height={650}>
      <Window.Content scrollable>
        {failReason ? (
          <Box>
            {failReason === JOB_REPORT_MENU_FAIL_REASON_TRACKING_DISABLED &&
              'This server has disabled tracking.'}
            {failReason === JOB_REPORT_MENU_FAIL_REASON_NO_RECORDS &&
              'No playtime records are available for this player.'}
          </Box>
        ) : (
          <Box>
            <Section title="Total">
              <PlaytimeSection
                playtimes={{ Ghost: ghostTime, Living: livingTime }}
              />
            </Section>
            <Section title="Jobs">
              <PlaytimeSection playtimes={jobPlaytimes} />
            </Section>
            <Section title="Special">
              <PlaytimeSection playtimes={specialPlaytimes} />
            </Section>
            <Section title="Xenomorph Castes">
              <PlaytimeSection playtimes={castePlaytimes} />
            </Section>
          </Box>
        )}
      </Window.Content>
    </Window>
  );
};
