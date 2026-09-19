import { Fragment, useState } from 'react';
import {
  AnimatedNumber,
  Box,
  Button,
  Collapsible,
  Divider,
  Flex,
  Icon,
  Input,
  LabeledList,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const category_icon = {
  "作战": 'parachute-box',
  "武器": 'fighter-jet',
  "智能枪": 'star',
  "固定式": 'bolt',
  "发射器": 'rocket',
  "爆炸物": 'bomb',
  "护甲": 'hard-hat',
  "服装": 'tshirt',
  "医疗": 'medkit',
  "工程": 'tools',
  "补给": 'hamburger',
  "进口": 'boxes',
  "载具": 'road',
  "工厂": 'industry',
  'Pending Order': 'shopping-cart',
};

export const Cargo = () => {
  const { data } = useBackend();

  const [selectedMenu, setSelectedMenu] = useState(null);

  const {
    supplypacks,
    approvedrequests,
    deniedrequests,
    shopping_history,
    awaiting_delivery,
  } = data;

  const selectedPackCat = supplypacks[selectedMenu]
    ? supplypacks[selectedMenu]
    : null;

  return (
    <Window width={1100} height={700}>
      <Flex height="650px" align="stretch">
        <Flex.Item width="280px">
          <Menu selectedMenu={selectedMenu} setSelectedMenu={setSelectedMenu} />
        </Flex.Item>
        <Flex.Item position="relative" grow={1} height="100%">
          <Window.Content scrollable>
            {selectedMenu === '先前购买' && (
              <OrderList
                type={shopping_history}
                readOnly={1}
                selectedMenu={selectedMenu}
                setSelectedMenu={setSelectedMenu}
              />
            )}
            {selectedMenu === '导出历史' && <Exports />}
            {selectedMenu === '等待交付' && (
              <OrderList
                type={awaiting_delivery}
                readOnly={1}
                selectedMenu={selectedMenu}
                setSelectedMenu={setSelectedMenu}
              />
            )}
            {selectedMenu === '待处理订单' && (
              <ShoppingCart
                selectedMenu={selectedMenu}
                setSelectedMenu={setSelectedMenu}
              />
            )}
            {selectedMenu === '请求' && <Requests />}
            {selectedMenu === '已批准请求' && (
              <OrderList
                type={approvedrequests}
                selectedMenu={selectedMenu}
                setSelectedMenu={setSelectedMenu}
              />
            )}
            {selectedMenu === '已拒绝请求' && (
              <OrderList
                type={deniedrequests}
                selectedMenu={selectedMenu}
                setSelectedMenu={setSelectedMenu}
              />
            )}
            {!!selectedPackCat && (
              <Category
                selectedPackCat={selectedPackCat}
                should_filter
                selectedMenu={selectedMenu}
                setSelectedMenu={setSelectedMenu}
              />
            )}
          </Window.Content>
        </Flex.Item>
      </Flex>
    </Window>
  );
};

const Exports = () => {
  const { data } = useBackend();

  const { export_history } = data;

  return (
    <Section title="导出">
      <Table>
        {export_history.map((exp) => (
          <Table.Row key={exp.id}>
            <Table.Cell>{exp.name}</Table.Cell>
            <Table.Cell>
              {exp.amount} x {exp.points} points ({exp.total})
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};

const MenuButton = (props) => {
  const { condition, menuname, icon, width, selectedMenu, setSelectedMenu } =
    props;

  return (
    <Button
      icon={icon}
      selected={selectedMenu === menuname}
      onClick={() => setSelectedMenu(menuname)}
      disabled={condition}
      width={width}
      content={menuname}
    />
  );
};

const Menu = (props) => {
  const { act, data } = useBackend();
  const { readOnly, selectedMenu, setSelectedMenu } = props;

  const {
    requests,
    currentpoints,
    personalpoints,
    categories,
    shopping_list_cost,
    shopping_list_items,
    elevator,
    elevator_dir,
    export_history,
    deniedrequests,
    approvedrequests,
    awaiting_delivery_orders,
    shopping_history,
  } = data;

  const elev_status = elevator === 'Raised' || elevator === 'Lowered';

  return (
    <Section height="100%" p="5px">
      <Section>
        个人点数: <AnimatedNumber value={personalpoints} />
      </Section>
      点数: <AnimatedNumber value={currentpoints} />
      <Divider />
      <Flex>
        <Flex.Item grow={1}>
          <MenuButton
            icon="luggage-cart"
            menuname="等待交付"
            condition={!awaiting_delivery_orders}
            selectedMenu={selectedMenu}
            setSelectedMenu={setSelectedMenu}
          />
        </Flex.Item>
        <Flex.Item>
          <AnimatedNumber value={awaiting_delivery_orders} /> order
          {awaiting_delivery_orders !== 1 && 's'}
        </Flex.Item>
      </Flex>
      {!readOnly && (
        <Flex>
          <Flex.Item grow={1}>
            <Button
              onClick={() => act('send')}
              disabled={!elev_status}
              icon={'angle-double-' + elevator_dir}
            >
              {elevator_dir === 'up' ? 'Raise' : 'Lower'}
            </Button>
          </Flex.Item>
          <Flex.Item>Elevator: {elevator}</Flex.Item>
        </Flex>
      )}
      <Divider />
      <Flex>
        <Flex.Item grow={1}>
          <MenuButton
            icon="shopping-cart"
            menuname="待处理订单"
            condition={!shopping_list_items}
            selectedMenu={selectedMenu}
            setSelectedMenu={setSelectedMenu}
          />
        </Flex.Item>
        <Flex.Item>
          <AnimatedNumber value={shopping_list_items} /> item
          {shopping_list_items !== 1 && 's'}
        </Flex.Item>
        <Flex.Item width="5px" />
        <Flex.Item>
          Cost:
          <AnimatedNumber value={shopping_list_cost} />
        </Flex.Item>
      </Flex>
      {!readOnly && (
        <>
          <MenuButton
            icon="history"
            menuname="先前购买"
            condition={!shopping_history.length}
            selectedMenu={selectedMenu}
            setSelectedMenu={setSelectedMenu}
          />
          <MenuButton
            icon="shipping-fast"
            menuname="导出历史"
            condition={!export_history.length}
            selectedMenu={selectedMenu}
            setSelectedMenu={setSelectedMenu}
          />
        </>
      )}
      <Divider />
      <Flex>
        <Flex.Item grow={1}>
          <MenuButton
            icon="clipboard-list"
            menuname="请求"
            condition={!requests.length}
            selectedMenu={selectedMenu}
            setSelectedMenu={setSelectedMenu}
          />
        </Flex.Item>
        <Flex.Item>{requests.length} pending</Flex.Item>
      </Flex>
      <MenuButton
        icon="clipboard-check"
        menuname="已批准请求"
        condition={!approvedrequests.length}
        selectedMenu={selectedMenu}
        setSelectedMenu={setSelectedMenu}
      />
      <MenuButton
        icon="trash"
        menuname="已拒绝请求"
        condition={!deniedrequests.length}
        selectedMenu={selectedMenu}
        setSelectedMenu={setSelectedMenu}
      />
      <Divider />
      {categories.map((category) => (
        <Fragment key={category.id}>
          <MenuButton
            key={category.id}
            icon={category_icon[category]}
            menuname={category}
            condition={0}
            width="100%"
            selectedMenu={selectedMenu}
            setSelectedMenu={setSelectedMenu}
          />
          <br />
        </Fragment>
      ))}
    </Section>
  );
};

const OrderList = (props) => {
  const { act, data } = useBackend();

  const { type, buttons, readOnly, selectedMenu, setSelectedMenu } = props;

  return (
    <Section title={selectedMenu} buttons={buttons}>
      {type.map((request) => {
        const { id, orderer_rank, orderer, authed_by, reason, cost, packs } =
          request;
        const rank = orderer_rank || '';

        return (
          <Section
            key={id}
            level={2}
            title={'Order #' + id}
            buttons={
              <>
                {!readOnly &&
                  (!authed_by || selectedMenu === '已拒绝请求') && (
                    <Button
                      onClick={() => act('approve', { id: id })}
                      icon="check"
                      content="批准"
                    />
                  )}
                {!readOnly && !authed_by && (
                  <Button
                    onClick={() => act('deny', { id: id })}
                    icon="times"
                    content="拒绝"
                  />
                )}
                {selectedMenu === '等待交付' && (
                  <Button
                    onClick={() => act('delivery', { id: id })}
                    icon="luggage-cart"
                    content="交付"
                    tooltip="使用它将花费150点数!"
                    disabled={!data.beacon}
                  />
                )}
              </>
            }
          >
            <LabeledList>
              <LabeledList.Item label="请求者">
                {rank + ' ' + orderer}
              </LabeledList.Item>
              <LabeledList.Item label="原因">{reason}</LabeledList.Item>
              <LabeledList.Item label="总费用">
                {cost} points
              </LabeledList.Item>
              <LabeledList.Item label="内容">
                <Packs packs={packs} />
              </LabeledList.Item>
            </LabeledList>
          </Section>
        );
      })}
    </Section>
  );
};

const Packs = (props) => {
  const { packs } = props;

  return Object.keys(packs).map((pack) => (
    <Pack pack={pack} key={pack} amount={packs[pack]} />
  ));
};

const Pack = (props) => {
  const { data } = useBackend();
  const { pack, amount } = props;
  const { supplypackscontents } = data;
  const { name, item_notes, cost, contains } = supplypackscontents[pack];

  return !!contains && contains.constructor === Object ? (
    <Collapsible
      color="transparent"
      title={<PackName cost={cost} name={name} pl={0} amount={amount} />}
    >
      <b>{item_notes ? 'Notes: ' : null} </b> {item_notes}
      <Table>
        <PackContents contains={contains} />
      </Table>
    </Collapsible>
  ) : (
    <PackName cost={cost} name={name} pl="22px" />
  );
};

const PackName = (props) => {
  const { cost, name, pl, amount } = props;

  return (
    <Box inline pl={pl}>
      <Box textAlign="right" inline width="140px">
        {amount ? amount + 'x' : ''}
        {cost} points {amount ? '(' + amount * cost + ')' : ''}
      </Box>
      <Box width="15px" inline />
      <Box inline>{name}</Box>
    </Box>
  );
};

const Requests = (props) => {
  const { act, data } = useBackend();
  const { readOnly, selectedMenu, setSelectedMenu } = props;
  const { requests } = data;

  return (
    <OrderList
      type={requests}
      readOnly={readOnly}
      selectedMenu={selectedMenu}
      setSelectedMenu={setSelectedMenu}
      buttons={
        !readOnly && (
          <>
            <Button
              icon="check-double"
              onClick={() => act('approveall')}
              content="全部批准"
            />
            <Button
              icon="times-circle"
              onClick={() => act('denyall')}
              content="全部拒绝"
            />
          </>
        )
      }
    />
  );
};

const ShoppingCart = (props) => {
  const { act, data } = useBackend();

  const { shopping_list, shopping_list_items } = data;
  const { readOnly, selectedMenu, setSelectedMenu } = props;
  const shopping_list_array = Object.keys(shopping_list);
  const [reason, setReason] = useState(null);

  return (
    <Section>
      <Box textAlign="center">
        <Button
          p="5px"
          icon="dollar-sign"
          content={readOnly ? '提交请求' : '购买购物车'}
          disabled={(readOnly && !reason) || !shopping_list_items}
          onClick={() =>
            act(readOnly ? 'submitrequest' : 'buycart', {
              reason: reason,
            })
          }
        />
        <Button
          p="5px"
          content="个人购买"
          icon="dollar-sign"
          onClick={() => act('buypersonal')}
        />
        <Button
          p="5px"
          content="清空购物车"
          disabled={!shopping_list_items}
          icon="snowplow"
          onClick={() => act('clearcart')}
        />
      </Box>
      {readOnly && (
        <>
          <Box width="10%" inline>
            Reason:{' '}
          </Box>
          <Input
            autoFocus
            placeholder="Reason"
            width="89%"
            inline
            expensive
            value={reason}
            onChange={setReason}
          />
        </>
      )}
      <Category
        selectedPackCat={shopping_list_array}
        level={2}
        selectedMenu={selectedMenu}
        setSelectedMenu={setSelectedMenu}
      />
    </Section>
  );
};

const CategoryButton = (props) => {
  const { act } = useBackend();
  const { icon, disabled, id, mode } = props;

  return (
    <Button
      icon={icon}
      disabled={disabled}
      onClick={() =>
        act('cart', {
          id: id,
          mode: mode,
        })
      }
    />
  );
};

const Category = (props) => {
  const { data } = useBackend();

  const {
    shopping_list,
    shopping_list_cost,
    currentpoints,
    supplypackscontents,
  } = data;

  const spare_points = currentpoints - shopping_list_cost;

  const {
    selectedPackCat,
    should_filter,
    level,
    selectedMenu,
    setSelectedMenu,
  } = props;

  const [filter, setFilter] = useState(null);

  const filterSearch = (entry) =>
    should_filter && filter
      ? supplypackscontents[entry].name
          ?.toLowerCase()
          .includes(filter.toLowerCase())
      : true;

  return (
    <Section
      level={level || 1}
      title={
        <>
          <Icon name={category_icon[selectedMenu]} mr="5px" />
          {selectedMenu}
        </>
      }
    >
      <Stack vertical>
        {should_filter && (
          <Stack.Item>
            <Input
              autoFocus
              placeholder="Search..."
              fluid
              expensive
              onChange={setFilter}
            />
          </Stack.Item>
        )}
        <Stack.Item>
          <Table>
            {selectedPackCat.filter(filterSearch).map((entry) => {
              const shop_list = shopping_list[entry] || 0;
              const count = shop_list ? shop_list.count : 0;
              const { cost } = supplypackscontents[entry];
              return (
                <Table.Row key={entry.id}>
                  <Table.Cell width="130px">
                    <CategoryButton
                      icon="fast-backward"
                      disabled={!count}
                      id={entry}
                      mode="removeall"
                    />
                    <CategoryButton
                      icon="backward"
                      disabled={!count}
                      id={entry}
                      mode="removeone"
                    />
                    <Box width="25px" inline textAlign="center">
                      {!!count && <AnimatedNumber value={count} />}
                    </Box>
                    <CategoryButton icon="forward" id={entry} mode="addone" />
                    <CategoryButton
                      icon="fast-forward"
                      disabled={cost > spare_points}
                      id={entry}
                      mode="addall"
                    />
                  </Table.Cell>
                  <Table.Cell>
                    <Pack pack={entry} />
                  </Table.Cell>
                </Table.Row>
              );
            })}
          </Table>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const PackContents = (props) => {
  const { contains } = props;

  return (
    <>
      <Table.Row>
        <Table.Cell bold>Item Type</Table.Cell>
        <Table.Cell bold>Quantity</Table.Cell>
      </Table.Row>
      {Object.values(contains).map((value, index) => (
        <Table.Row key={index}>
          <Table.Cell width="70%">{value.name}</Table.Cell>
          <Table.Cell>x {value.count}</Table.Cell>
        </Table.Row>
      ))}
    </>
  );
};

export const CargoRequest = (props) => {
  const { data } = useBackend();

  const [selectedMenu, setSelectedMenu] = useState(null);

  const { supplypacks, approvedrequests, deniedrequests, awaiting_delivery } =
    data;

  const selectedPackCat = supplypacks[selectedMenu]
    ? supplypacks[selectedMenu]
    : null;

  return (
    <Window width={1100} height={700}>
      <Flex height="650px" align="stretch">
        <Flex.Item width="280px">
          <Menu
            readOnly={1}
            selectedMenu={selectedMenu}
            setSelectedMenu={setSelectedMenu}
          />
        </Flex.Item>
        <Flex.Item position="relative" grow={1} height="100%">
          <Window.Content scrollable>
            {selectedMenu === '等待交付' && (
              <OrderList
                type={awaiting_delivery}
                readOnly={1}
                selectedMenu={selectedMenu}
                setSelectedMenu={setSelectedMenu}
              />
            )}
            {selectedMenu === '待处理订单' && (
              <ShoppingCart
                readOnly={1}
                selectedMenu={selectedMenu}
                setSelectedMenu={setSelectedMenu}
              />
            )}
            {selectedMenu === '请求' && (
              <Requests
                readOnly={1}
                selectedMenu={selectedMenu}
                setSelectedMenu={setSelectedMenu}
              />
            )}
            {selectedMenu === '已批准请求' && (
              <OrderList
                type={approvedrequests}
                selectedMenu={selectedMenu}
                setSelectedMenu={setSelectedMenu}
              />
            )}
            {selectedMenu === '已拒绝请求' && (
              <OrderList
                type={deniedrequests}
                readOnly={1}
                selectedMenu={selectedMenu}
                setSelectedMenu={setSelectedMenu}
              />
            )}
            {!!selectedPackCat && (
              <Category
                selectedPackCat={selectedPackCat}
                should_filter
                selectedMenu={selectedMenu}
                setSelectedMenu={setSelectedMenu}
              />
            )}
          </Window.Content>
        </Flex.Item>
      </Flex>
    </Window>
  );
};
