import {
  AnimatedNumber,
  Box,
  Button,
  LabeledList,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../../backend';

export const PortableBasicInfo = (props) => {
  const { act, data } = useBackend();
  const {
    connected,
    holding,
    on,
    pressure,
    hasHypernobCrystal,
    reactionSuppressionEnabled,
  } = data;
  return (
    <>
      <Section
        title="状态"
        buttons={
          <Button
            icon={on ? 'power-off' : 'times'}
            content={on ? '开启' : '关闭'}
            selected={on}
            onClick={() => act('power')}
          />
        }
      >
        <LabeledList>
          <LabeledList.Item label="压力">
            <AnimatedNumber value={pressure} />
            {' kPa'}
          </LabeledList.Item>
          <LabeledList.Item label="端口" color={connected ? 'good' : 'average'}>
            {connected ? 'Connected' : 'Not Connected'}
          </LabeledList.Item>
          {!!hasHypernobCrystal && (
            <LabeledList.Item label="反应抑制">
              <Button
                icon={data.reactionSuppressionEnabled ? 'snowflake' : 'times'}
                content={
                  data.reactionSuppressionEnabled ? '已启用' : '已禁用'
                }
                selected={data.reactionSuppressionEnabled}
                onClick={() => act('reaction_suppression')}
              />
            </LabeledList.Item>
          )}
        </LabeledList>
      </Section>
      <Section
        title="储存罐"
        minHeight="82px"
        buttons={
          <Button
            icon="eject"
            content="弹出"
            disabled={!holding}
            onClick={() => act('eject')}
          />
        }
      >
        {holding ? (
          <LabeledList>
            <LabeledList.Item label="标签">{holding.name}</LabeledList.Item>
            <LabeledList.Item label="压力">
              <AnimatedNumber value={holding.pressure} />
              {' kPa'}
            </LabeledList.Item>
          </LabeledList>
        ) : (
          <Box color="average">无储存罐</Box>
        )}
      </Section>
    </>
  );
};
