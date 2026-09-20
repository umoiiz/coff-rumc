import {
  AnimatedNumber,
  Box,
  Button,
  Icon,
  LabeledList,
  ProgressBar,
  Section,
} from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const ChemDispenser = (props) => {
  const { act, data } = useBackend();
  const recording = !!data.recordingRecipe;
  // TODO: Change how this piece of shit is built on server side
  // It has to be a list, not a fucking OBJECT!
  const recipes = Object.keys(data.recipes).map((name) => ({
    name,
    contents: data.recipes[name],
  }));
  const beakerTransferAmounts = data.beakerTransferAmounts || [];
  const beakerContents =
    (recording && data.recordingContents) || data.beakerContents || [];
  return (
    <Window width={565} height={620}>
      <Window.Content scrollable>
        <Section
          title="状态"
          buttons={
            recording && (
              <Box inline mx={1} color="red">
                <Icon name="circle" mr={1} />
                录制中
              </Box>
            )
          }
        >
          <LabeledList>
            <LabeledList.Item label="能量">
              <ProgressBar value={data.energy / data.maxEnergy}>
                {toFixed(data.energy) + ' units'}
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section
          title="配方"
          buttons={
            <>
              {!recording && (
                <Box inline mx={1}>
                  <Button
                    color={data.clearingRecipe ? 'red' : 'transparent'}
                    content="清除配方"
                    onClick={() => act('clear_recipes')}
                  />
                </Box>
              )}
              {!recording && (
                <Button
                  icon="circle"
                  disabled={!data.isBeakerLoaded}
                  content="录制"
                  onClick={() => act('record_recipe')}
                />
              )}
              {recording && (
                <Button
                  icon="ban"
                  color="transparent"
                  content="丢弃"
                  onClick={() => act('cancel_recording')}
                />
              )}
              {recording && (
                <Button
                  icon="save"
                  color="green"
                  content="保存"
                  onClick={() => act('save_recording')}
                />
              )}
            </>
          }
        >
          <Box mr={-1}>
            {recipes.map((recipe) => (
              <Button
                key={recipe.name}
                icon="tint"
                width="129.5px"
                lineHeight={1.75}
                content={recipe.name}
                onClick={() =>
                  act('dispense_recipe', {
                    recipe: recipe.name,
                  })
                }
              />
            ))}
            {recipes.length === 0 && <Box color="light-gray">没有配方.</Box>}
          </Box>
        </Section>
        <Section
          title="分配"
          buttons={beakerTransferAmounts.map((amount) => (
            <Button
              key={amount}
              icon="plus"
              selected={amount === data.amount}
              content={amount}
              onClick={() =>
                act('amount', {
                  target: amount,
                })
              }
            />
          ))}
        >
          <Box mr={-1}>
            {data.chemicals.map((chemical) => (
              <Button
                key={chemical.id}
                icon="tint"
                width="129.5px"
                lineHeight={1.75}
                content={chemical.title}
                onClick={() =>
                  act('dispense', {
                    reagent: chemical.id,
                  })
                }
              />
            ))}
          </Box>
        </Section>
        <Section
          title="烧杯"
          buttons={beakerTransferAmounts.map((amount) => (
            <Button
              key={amount}
              icon="minus"
              disabled={recording}
              content={amount}
              onClick={() => act('remove', { amount })}
            />
          ))}
        >
          <LabeledList>
            <LabeledList.Item
              label="烧杯"
              buttons={
                !!data.isBeakerLoaded && (
                  <Button
                    icon="eject"
                    content="弹出"
                    disabled={!data.isBeakerLoaded}
                    onClick={() => act('eject')}
                  />
                )
              }
            >
              {(recording && 'Virtual beaker') ||
                (data.isBeakerLoaded && (
                  <>
                    <AnimatedNumber
                      initial={0}
                      value={data.beakerCurrentVolume}
                    />
                    /{data.beakerMaxVolume} units
                  </>
                )) ||
                'No beaker'}
            </LabeledList.Item>
            <LabeledList.Item label="内容物">
              <Box color="label">
                {(!data.isBeakerLoaded && !recording && 'N/A') ||
                  (beakerContents.length === 0 && 'Nothing')}
              </Box>
              {beakerContents.map((chemical) => (
                <Box key={chemical.name} color="label">
                  <AnimatedNumber initial={0} value={chemical.volume} /> units
                  of {chemical.name}
                </Box>
              ))}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
