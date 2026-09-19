import {
  Box,
  Button,
  LabeledList,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';

import { useBackend } from '../../backend';

export const DrawOrder = (props) => {
  const { act, data } = useBackend<DrawOrder>();
  const { draw_order = [], quick_equip = [] } = data;
  return (
    <Section title="绘制顺序">
      <Stack fill>
        <Stack.Item grow>
          <Section title="装备槽位顺序">
            <Section>
              <Table>
                {draw_order.map((item) => (
                  <Table.Row key={item}>
                    <Table.Cell>{item}</Table.Cell>
                    <Button
                      icon="arrow-up"
                      onClick={() =>
                        act('equip_slot_equip_position', {
                          direction: 'up',
                          changing_item: item,
                        })
                      }
                    />
                    <Button
                      icon="arrow-down"
                      onClick={() =>
                        act('equip_slot_equip_position', {
                          direction: 'down',
                          changing_item: item,
                        })
                      }
                    />
                  </Table.Row>
                ))}
              </Table>
            </Section>
          </Section>
        </Stack.Item>
        <Stack.Item grow>
          <Section title="按键绑定设置">
            <LabeledList>
              {quick_equip.map((equip_slot, index_slot) => (
                <>
                  <Box>Quick equip #{index_slot + 1}</Box>
                  <Button
                    key={equip_slot}
                    content={equip_slot}
                    onClick={() =>
                      act('change_quick_equip', { selection: index_slot + 1 })
                    }
                  />
                </>
              ))}
            </LabeledList>
          </Section>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
