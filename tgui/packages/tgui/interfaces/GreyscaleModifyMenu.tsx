import {
  Button,
  ColorBox,
  Icon,
  Image,
  Input,
  LabeledList,
  Section,
  Table,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type ColorEntry = {
  index: Number;
  value: string;
};

type SpriteData = {
  finished: SpriteEntry;
  steps: Array<SpriteEntry>;
};

type SpriteEntry = {
  layer: string;
  result: string;
};

type GreyscaleMenuData = {
  colors: Array<ColorEntry>;
  sprites: SpriteData;
};

const ColorDisplay = (props) => {
  const { act, data } = useBackend<GreyscaleMenuData>();
  const colors = data.colors || [];
  return (
    <Section title="颜色">
      <LabeledList>
        <LabeledList.Item label="全彩字符串">
          <Input
            value={colors.map((item) => item.value).join('')}
            onChange={(value) =>
              act('recolor_from_string', { color_string: value })
            }
          />
        </LabeledList.Item>
        {colors.map((item) => (
          <LabeledList.Item
            key={`colorgroup${item.index}${item.value}`}
            label={`Color Group ${item.index}`}
            color={item.value}
          >
            <ColorBox color={item.value} />{' '}
            <Button
              content={<Icon name="palette" />}
              onClick={() => act('pick_color', { color_index: item.index })}
            />
            <Input
              value={item.value}
              onChange={(value) =>
                act('recolor', { color_index: item.index, new_color: value })
              }
            />
          </LabeledList.Item>
        ))}
      </LabeledList>
    </Section>
  );
};

const PreviewDisplay = (props) => {
  const { data } = useBackend<GreyscaleMenuData>();
  return (
    <Section title="预览">
      <Table>
        <Table.Row header>
          <Table.Cell textAlign="center">Step Layer</Table.Cell>
          <Table.Cell textAlign="center">Step Result</Table.Cell>
        </Table.Row>
        {data.sprites.steps.map((item) => (
          <Table.Row key={`${item.result}|${item.layer}`}>
            <Table.Cell width="50%">
              <SingleSprite source={item.result} />
            </Table.Cell>
            <Table.Cell width="50%">
              <SingleSprite source={item.layer} />
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};

const SingleSprite = (props) => {
  const { source } = props;
  return <Image src={source} width="100%" />;
};

export const GreyscaleModifyMenu = (props) => {
  const { act, data } = useBackend<GreyscaleMenuData>();
  return (
    <Window title="Greyscale Modification" width={325} height={800}>
      <Window.Content scrollable>
        <ColorDisplay />
        <Button onClick={() => act('refresh_file')}>
          刷新图标文件
        </Button>{' '}
        <Button content="应用" onClick={() => act('apply')} />
        <PreviewDisplay />
      </Window.Content>
    </Window>
  );
};
