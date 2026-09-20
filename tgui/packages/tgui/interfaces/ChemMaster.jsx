import {
  AnimatedNumber,
  Box,
  Button,
  ColorBox,
  LabeledList,
  NumberInput,
  Section,
  Table,
} from 'tgui-core/components';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';

export const ChemMaster = (props) => {
  const { data } = useBackend();
  const { screen } = data;
  return (
    <Window width={465} height={550}>
      <Window.Content scrollable>
        {(screen === 'analyze' && <AnalysisResults />) || <ChemMasterContent />}
      </Window.Content>
    </Window>
  );
};

const ChemMasterContent = (props) => {
  const { act, data } = useBackend();
  const {
    screen,
    beakerContents = [],
    bufferContents = [],
    beakerCurrentVolume,
    beakerMaxVolume,
    isBeakerLoaded,
    isPillBottleLoaded,
    pillBottleCurrentAmount,
    pillBottleMaxAmount,
  } = data;
  if (screen === 'analyze') {
    return <AnalysisResults />;
  }
  return (
    <>
      <Section
        title="烧杯"
        buttons={
          !!data.isBeakerLoaded && (
            <>
              <Box inline color="label" mr={2}>
                <AnimatedNumber value={beakerCurrentVolume} initial={0} />
                {` / ${beakerMaxVolume} units`}
              </Box>
              <Button
                icon="eject"
                content="弹出"
                onClick={() => act('eject')}
              />
            </>
          )
        }
      >
        {!isBeakerLoaded && (
          <Box color="label" mt="3px" mb="5px">
            未装载烧杯.
          </Box>
        )}
        {!!isBeakerLoaded && beakerContents.length === 0 && (
          <Box color="label" mt="3px" mb="5px">
            烧杯是空的.
          </Box>
        )}
        <ChemicalBuffer>
          {beakerContents.map((chemical) => (
            <ChemicalBufferEntry
              key={chemical.id}
              chemical={chemical}
              transferTo="buffer"
            />
          ))}
        </ChemicalBuffer>
      </Section>
      <Section
        title="缓冲"
        buttons={
          <>
            <Box inline color="label" mr={1}>
              模式:
            </Box>
            <Button
              color={data.mode ? 'good' : 'bad'}
              icon={data.mode ? 'exchange-alt' : 'times'}
              content={data.mode ? '转移' : '销毁'}
              onClick={() => act('toggleMode')}
            />
          </>
        }
      >
        {bufferContents.length === 0 && (
          <Box color="label" mt="3px" mb="5px">
            缓冲区为空.
          </Box>
        )}
        <ChemicalBuffer>
          {bufferContents.map((chemical) => (
            <ChemicalBufferEntry
              key={chemical.id}
              chemical={chemical}
              transferTo="beaker"
            />
          ))}
        </ChemicalBuffer>
      </Section>
      <Section title="包装">
        <PackagingControls />
      </Section>
      {!!isPillBottleLoaded && (
        <Section
          title="药瓶"
          buttons={
            <>
              <Box inline color="label" mr={2}>
                {pillBottleCurrentAmount} / {pillBottleMaxAmount} pills
              </Box>
              <Button
                icon="eject"
                content="弹出"
                onClick={() => act('ejectPillBottle')}
              />
            </>
          }
        />
      )}
    </>
  );
};

const ChemicalBuffer = Table;

const ChemicalBufferEntry = (props) => {
  const { act } = useBackend();
  const { chemical, transferTo } = props;
  return (
    <Table.Row key={chemical.id}>
      <Table.Cell color="label">
        <AnimatedNumber value={chemical.volume} initial={0} />
        {` units of ${chemical.name}`}
      </Table.Cell>
      <Table.Cell collapsing>
        <Button
          content="1"
          onClick={() =>
            act('transfer', {
              id: chemical.id,
              amount: 1,
              to: transferTo,
            })
          }
        />
        <Button
          content="5"
          onClick={() =>
            act('transfer', {
              id: chemical.id,
              amount: 5,
              to: transferTo,
            })
          }
        />
        <Button
          content="10"
          onClick={() =>
            act('transfer', {
              id: chemical.id,
              amount: 10,
              to: transferTo,
            })
          }
        />
        <Button
          content="全部"
          onClick={() =>
            act('transfer', {
              id: chemical.id,
              amount: 1000,
              to: transferTo,
            })
          }
        />
        <Button
          icon="ellipsis-h"
          title="自定义数量"
          onClick={() =>
            act('transfer', {
              id: chemical.id,
              amount: -1,
              to: transferTo,
            })
          }
        />
        <Button
          icon="question"
          title="分析"
          onClick={() =>
            act('analyze', {
              id: chemical.id,
            })
          }
        />
      </Table.Cell>
    </Table.Row>
  );
};

const PackagingControlsItem = (props) => {
  const { label, amountUnit, amount, onChangeAmount, onCreate, sideNote } =
    props;
  return (
    <LabeledList.Item label={label}>
      <NumberInput
        width="84px"
        unit={amountUnit}
        step={1}
        stepPixelSize={15}
        value={amount}
        minValue={1}
        maxValue={10}
        onChange={onChangeAmount}
      />
      <Button ml="6px" content="创建" onClick={onCreate} />
      <Box inline ml="6px" color="label">
        {sideNote}
      </Box>
    </LabeledList.Item>
  );
};

const PackagingControls = (props) => {
  const { act, data } = useBackend();
  const [pillAmount, setPillAmount] = useSharedState('pillAmount', 1);
  const [patchAmount, setPatchAmount] = useSharedState('patchAmount', 1);
  const [bottleAmount, setBottleAmount] = useSharedState('bottleAmount', 1);
  const [packAmount, setPackAmount] = useSharedState('packAmount', 1);
  const { condi, chosenPillStyle, pillStyles = [] } = data;
  return (
    <LabeledList>
      {!condi && (
        <LabeledList.Item label="药丸类型">
          {pillStyles.map((pill) => (
            <Button
              key={pill.id}
              width="30px"
              selected={pill.id === chosenPillStyle}
              textAlign="center"
              color="transparent"
              onClick={() => act('pillStyle', { id: pill.id })}
            >
              <Box mx={-1} className={pill.className} />
            </Button>
          ))}
        </LabeledList.Item>
      )}
      {!condi && (
        <PackagingControlsItem
          label="Pills"
          amount={pillAmount}
          amountUnit="pills"
          sideNote="max 50u"
          onChangeAmount={(e, value) => setPillAmount(value)}
          onCreate={() =>
            act('create', {
              type: 'pill',
              amount: pillAmount,
              volume: 'auto',
            })
          }
        />
      )}
      {!condi && (
        <PackagingControlsItem
          label="Patches"
          amount={patchAmount}
          amountUnit="patches"
          sideNote="max 40u"
          onChangeAmount={(e, value) => setPatchAmount(value)}
          onCreate={() =>
            act('create', {
              type: 'patch',
              amount: patchAmount,
              volume: 'auto',
            })
          }
        />
      )}
      {!condi && (
        <PackagingControlsItem
          label="Bottles"
          amount={bottleAmount}
          amountUnit="bottles"
          sideNote="max 30u"
          onChangeAmount={(e, value) => setBottleAmount(value)}
          onCreate={() =>
            act('create', {
              type: 'bottle',
              amount: bottleAmount,
              volume: 'auto',
            })
          }
        />
      )}
      {!!condi && (
        <PackagingControlsItem
          label="Packs"
          amount={packAmount}
          amountUnit="packs"
          sideNote="max 10u"
          onChangeAmount={(e, value) => setPackAmount(value)}
          onCreate={() =>
            act('create', {
              type: 'condimentPack',
              amount: packAmount,
              volume: 'auto',
            })
          }
        />
      )}
      {!!condi && (
        <PackagingControlsItem
          label="Bottles"
          amount={bottleAmount}
          amountUnit="bottles"
          sideNote="max 50u"
          onChangeAmount={(e, value) => setBottleAmount(value)}
          onCreate={() =>
            act('create', {
              type: 'condimentBottle',
              amount: bottleAmount,
              volume: 'auto',
            })
          }
        />
      )}
    </LabeledList>
  );
};

const AnalysisResults = (props) => {
  const { act, data } = useBackend();
  const { analyzeVars } = data;
  return (
    <Section
      title="分析结果"
      buttons={
        <Button
          icon="arrow-left"
          content="返回"
          onClick={() =>
            act('goScreen', {
              screen: 'home',
            })
          }
        />
      }
    >
      <LabeledList>
        <LabeledList.Item label="名称">{analyzeVars.name}</LabeledList.Item>
        <LabeledList.Item label="状态">{analyzeVars.state}</LabeledList.Item>
        <LabeledList.Item label="颜色">
          <ColorBox color={analyzeVars.color} mr={1} />
          {analyzeVars.color}
        </LabeledList.Item>
        <LabeledList.Item label="描述">
          {analyzeVars.description}
        </LabeledList.Item>
        <LabeledList.Item label="代谢速率">
          {analyzeVars.metaRate} u/minute
        </LabeledList.Item>
        <LabeledList.Item label="过量阈值">
          {analyzeVars.overD}
        </LabeledList.Item>
        <LabeledList.Item label="成瘾阈值">
          {analyzeVars.addicD}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
