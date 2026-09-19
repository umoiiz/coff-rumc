import { Box, Button, Section } from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  InjectMode: BooleanLike;
  CurrentLabel: string;
  CurrentTag: string;
  TransferAmount: number;
  IsAdvanced: boolean;
};

export const Hypospray = (props) => {
  const { act, data } = useBackend<Data>();
  const { InjectMode, CurrentLabel, CurrentTag, TransferAmount, IsAdvanced } =
    data;
  return (
    <Window width={300} height={375}>
      <Section fill>
        <Box>
          <Button m={2} onClick={() => act('ActivateAutolabeler')}>
            激活自动贴标器
          </Button>
          <Box ml={2}>
            <b>Current label: </b>
            {CurrentLabel}
          </Box>
          <Button m={2} onClick={() => act('ActivateTagger')}>
            激活贴标器
          </Button>
          <Box ml={2}>
            <b>Current tag: </b>
            {CurrentTag}
          </Box>
          <Button m={2} onClick={() => act('ToggleMode')}>
            切换模式
          </Button>
          <Box ml={2}>
            <b>Current mode: </b>
            {InjectMode ? 'Injecting' : 'Drawing'}
          </Box>
          <Button m={2} onClick={() => act('SetTransferAmount')}>
            设置传输量
          </Button>
          <Box ml={2}>
            <b>Current transfer amount: </b>
            {TransferAmount}
          </Box>
          {IsAdvanced ? (
            <Box>
              <Button m={2} onClick={() => act('DisplayReagentContent')}>
                显示试剂含量
              </Button>
            </Box>
          ) : (
            <Box />
          )}
          <Button color={'red'} m={2} onClick={() => act('EmptyHypospray')}>
            清空注射器
          </Button>
        </Box>
      </Section>
    </Window>
  );
};
