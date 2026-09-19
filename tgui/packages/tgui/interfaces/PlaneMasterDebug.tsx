import { sortBy } from 'common/collections';
import { Component, createRef, RefObject } from 'react';
import {
  Box,
  Button,
  Dropdown,
  InfinitePlane,
  LabeledList,
  Modal,
  Section,
  Slider,
  Stack,
  Tooltip,
} from 'tgui-core/components';
import { flow } from 'tgui-core/fp';
import { classes, shallowDiffers } from 'tgui-core/react';

import { resolveAsset } from '../assets';
import { useBackend, useLocalState } from '../backend';
import { Window } from '../layouts';
import { Connection, Connections, Position } from './common/Connections';
import { MOUSE_BUTTON_LEFT, noop } from './IntegratedCircuit/constants';

enum ConnectionType {
  Relay,
  Filter,
}

enum ConnectionDirection {
  Incoming,
  Outgoing,
}

type ConnectionRef = {
  ref: string;
  sort_by: number;
};

type Plane = {
  name: string;
  documentation: string;
  plane: number;
  our_ref: string;
  offset: number;
  real_plane: number;
  renders_onto: number[];
  blend_mode: number;
  color: string | number[];
  alpha: number;
  render_target: string;
  incoming_relays: string[];
  outgoing_relays: string[];
  incoming_filters: string[];
  outgoing_filters: string[];
  intended_hidden: boolean;

  incoming_connections: ConnectionRef[];
  outgoing_connections: ConnectionRef[];

  x: number;
  y: number;
  step_size: number;
  size_x: number;
  size_y: number;
};

type Relay = {
  name: string;
  layer: number;
};

type Filter = {
  type: string;
  name: string;
  render_source: string;
};

// Type of something that spawn a connection
type Connected = {
  connect_color: string;
  source: number;
  source_ref: string;
  target: number;
  target_ref: string;
  our_ref: string;

  source_index: number;
  target_index: number;

  connect_type: ConnectionType;
};

interface AssocPlane {
  [index: string]: Plane;
}

interface AssocRelays {
  [index: string]: Relay & Connected;
}

interface AssocFilters {
  [index: string]: Filter & Connected;
}

interface AssocConnected {
  [index: string]: Connected;
}

interface AssocString {
  [index: string]: string;
}

type PlaneDebugData = {
  our_group: string;
  present_groups: string[];
  enable_group_view: boolean;
  relay_info: AssocRelays;
  plane_info: AssocPlane;
  filter_connect: AssocFilters;
  depth_stack: AssocString[];
  mob_name: string;
  mob_ref: string;
  our_ref: string;
  tracking_active: boolean;
};

// Stolen wholesale from fontcode
function textWidth(text: string, font: string, fontsize: number) {
  // default font height is 12 in tgui
  font = fontsize + 'x ' + font;
  const c = document.createElement('canvas');
  const ctx = c.getContext('2d') as CanvasRenderingContext2D;
  ctx.font = font;
  return ctx.measureText(text).width;
}

const planeToPosition = function (plane: Plane, index, is_incoming): Position {
  return {
    x: is_incoming ? plane.x : plane.x + plane.size_x,
    y:
      29 +
      plane.y +
      plane.step_size * index +
      (plane.step_size - plane.step_size / 3),
  };
};

// Takes a plane, returns the amount of node space it will need
const getPlaneNodeHeight = function (plane: Plane): number {
  return Math.max(
    plane.incoming_relays.length + plane.incoming_filters.length,
    plane.outgoing_relays.length + plane.outgoing_filters.length,
  );
};

const sortConnectionRefs = function (
  refs: ConnectionRef[],
  direction: ConnectionDirection,
  connectSources: AssocConnected,
) {
  refs = sortBy(refs, (connection: ConnectionRef) => connection.sort_by);
  refs.map((connection, index) => {
    let connectSource = connectSources[connection.ref];
    if (direction === ConnectionDirection.Outgoing) {
      connectSource.source_index = index;
    } else if (direction === ConnectionDirection.Incoming) {
      connectSource.target_index = index;
    }
  });
  return refs;
};

const addConnectionRefs = function (
  read_from: string[],
  add_type: ConnectionDirection,
  add_to: ConnectionRef[],
  reference: AssocConnected,
  plane_info: AssocPlane,
) {
  for (const ref of read_from) {
    const connected = reference[ref];
    let our_plane;
    // If we're incoming, use the target ref, and vis versa
    if (add_type === ConnectionDirection.Incoming) {
      our_plane = plane_info[connected.source_ref];
    } else if (add_type === ConnectionDirection.Outgoing) {
      our_plane = plane_info[connected.target_ref];
    }
    add_to.push({
      ref: ref,
      sort_by: our_plane.plane,
    });
  }
};

// Takes a list of planes, uses the depth stack to position them
const positionPlanes = (connectSources: AssocConnected) => {
  const { data } = useBackend<PlaneDebugData>();
  const { plane_info, relay_info, filter_connect, depth_stack } = data;

  // First, we concatinate our connection sources
  // We need them in one list partly for later purposes
  // But also so we can set their source/target index nicely
  for (const ref of Object.keys(relay_info)) {
    let connection_source: Connected = relay_info[ref];
    connection_source.connect_type = ConnectionType.Relay;
    connection_source.connect_color = 'blue';
    connectSources[ref] = connection_source;
  }
  for (const ref of Object.keys(filter_connect)) {
    let connection_source: Connected = filter_connect[ref];
    connection_source.connect_type = ConnectionType.Filter;
    connection_source.connect_color = 'purple';
    connectSources[ref] = connection_source;
  }

  for (const plane_ref of Object.keys(plane_info)) {
    let our_plane = plane_info[plane_ref];
    const incoming_conct: ConnectionRef[] = [] as any;
    const outgoing_conct: ConnectionRef[] = [] as any;
    addConnectionRefs(
      our_plane.incoming_relays,
      ConnectionDirection.Incoming,
      incoming_conct,
      relay_info,
      plane_info,
    );
    addConnectionRefs(
      our_plane.incoming_filters,
      ConnectionDirection.Incoming,
      incoming_conct,
      filter_connect,
      plane_info,
    );
    addConnectionRefs(
      our_plane.outgoing_relays,
      ConnectionDirection.Outgoing,
      outgoing_conct,
      relay_info,
      plane_info,
    );
    addConnectionRefs(
      our_plane.outgoing_filters,
      ConnectionDirection.Outgoing,
      outgoing_conct,
      filter_connect,
      plane_info,
    );
    our_plane.incoming_connections = sortConnectionRefs(
      incoming_conct,
      ConnectionDirection.Incoming,
      connectSources,
    );
    our_plane.outgoing_connections = sortConnectionRefs(
      outgoing_conct,
      ConnectionDirection.Outgoing,
      connectSources,
    );
  }

  // First we sort by the plane of each member,
  // then we sort by the plane of each member's head
  // This way we get a nicely sorted list
  // and get rid of the now unneeded parent refs
  const stack = depth_stack.map((layer) =>
    flow([
      (planes) => sortBy(planes, (plane: string) => plane_info[plane].plane),
      (planes) =>
        sortBy(planes, (plane: string) => {
          const read_from = plane_info[layer[plane]];
          if (!read_from) {
            return 0;
          }
          return read_from.plane;
        }),
    ])(Object.keys(layer)),
  );

  let base_x = 0;
  let longest_name = 0;
  let tallest_stack = 0;
  for (const layer of stack) {
    base_x += longest_name;
    base_x += 150;
    let new_longest = 0;
    let last_node_len = 0;
    let base_y = 0;
    for (const plane_ref of layer) {
      const old_y = base_y;
      const plane = plane_info[plane_ref];
      // - because we want to work backwards rather then forwards
      plane.x = -base_x;
      // I am assuming the height of a plane master with two connections looks
      // like 50% name 50% (two) nodes
      base_y += 45;
      // One extra for the relay add button
      base_y += 19 * (last_node_len + 1);
      // We need to know how large node steps are for later
      plane.step_size = 19;
      plane.y = base_y;
      const width = textWidth(plane.name, '', 16) + 30;
      plane.size_x = width;
      plane.size_y = old_y - base_y;
      new_longest = Math.max(new_longest, width);
      last_node_len = getPlaneNodeHeight(plane);
    }
    longest_name = new_longest;
    tallest_stack = Math.max(tallest_stack, base_y);
  }

  // Now that we've got everything stacked, we need to center it
  for (const layer of stack) {
    const last_ref = layer[layer.length - 1];
    const last_plane = plane_info[last_ref];
    const delta_tall = tallest_stack - last_plane.y;
    // Now that we know how "off" our height is, we can correct it
    // We halve because otherwise this looks dumb
    const offset = delta_tall / 2;
    for (const plane_ref of layer) {
      const plane = plane_info[plane_ref];
      plane.y += offset;
    }
  }
};

const arrayRemove = function (arr: any, value) {
  return arr.filter((element) => element !== value);
};

export class PlaneMasterDebug extends Component {
  constructor(props) {
    super(props);
    this.handlePortClick = this.handlePortClick.bind(this);
  }

  handlePortClick(connection: Connected, isOutput, event) {
    if (event.button !== MOUSE_BUTTON_LEFT) {
      return;
    }
    const { act, data } = useBackend<PlaneDebugData>();
    const { plane_info } = data;

    event.preventDefault();
    if (connection.connect_type === ConnectionType.Relay) {
      // Close the connection
      act('disconnect_relay', {
        source: connection.source_ref,
        target: connection.target_ref,
      });
      let source_plane = plane_info[connection.source_ref];
      let target_plane = plane_info[connection.source_ref];
      source_plane.outgoing_relays = arrayRemove(
        source_plane.outgoing_relays,
        connection.our_ref,
      );
      target_plane.incoming_relays = arrayRemove(
        target_plane.incoming_relays,
        connection.our_ref,
      );
    } else if (connection.connect_type === ConnectionType.Filter) {
      // Close the connection
      const filter = connection as Filter & Connected;
      act('disconnect_filter', {
        target: filter.target_ref,
        name: filter.name,
      });
      let source_plane = plane_info[connection.source_ref];
      let target_plane = plane_info[connection.source_ref];
      source_plane.outgoing_filters = arrayRemove(
        source_plane.outgoing_filters,
        connection.our_ref,
      );
      target_plane.incoming_filters = arrayRemove(
        target_plane.incoming_filters,
        connection.our_ref,
      );
    }
  }

  render() {
    const { act, data } = useBackend<PlaneDebugData>();
    const { plane_info, mob_name } = data;
    const [showAdd, setShowAdd] = useLocalState('showAdd', false);

    const [connectSources, setConnectSouces] = useLocalState<AssocConnected>(
      'connectionSources',
      {},
    );

    positionPlanes(connectSources);

    const connections: Connection[] = [];

    for (const ref of Object.keys(connectSources)) {
      const connect = connectSources[ref];
      const source_plane = plane_info[connect.source_ref];
      const target_plane = plane_info[connect.target_ref];
      connections.push({
        color: connect.connect_color,
        from: planeToPosition(source_plane, connect.source_index, false),
        to: planeToPosition(target_plane, connect.target_index, true),
        ref: ref,
      });
    }

    return (
      <Window width={1200} height={800} title={'Plane Debugging: ' + mob_name}>
        <Window.Content
          style={{
            backgroundImage: 'none',
          }}
        >
          <InfinitePlane
            width="100%"
            height="100%"
            backgroundImage={resolveAsset('grid_background.png')}
            imageWidth={900}
            initialLeft={800}
            initialTop={-740}
          >
            {Object.keys(plane_info).map(
              (plane_key, index) =>
                plane_key && (
                  <PlaneMaster
                    key={index}
                    {...plane_info[plane_key]}
                    our_plane={plane_info[plane_key]}
                    connected_list={connectSources}
                    onPortMouseDown={this.handlePortClick}
                    act={act}
                  />
                ),
            )}
            <Connections connections={connections} />
          </InfinitePlane>
          <DrawAbovePlane />
        </Window.Content>
      </Window>
    );
  }
}

type PlaneMasterProps = {
  name: string;
  incoming_connections: ConnectionRef[];
  outgoing_connections: ConnectionRef[];
  connected_list: AssocConnected;
  our_plane: Plane;
  x: number;
  y: number;
  onPortMouseDown: Function;
  act: Function;
};

class PlaneMaster extends Component<PlaneMasterProps> {
  shouldComponentUpdate(nextProps, nextState) {
    const { incoming_connections, outgoing_connections } = this
      .props as PlaneMasterProps;

    return (
      shallowDiffers(this.props, nextProps) ||
      shallowDiffers(this.state as object, nextState) ||
      shallowDiffers(incoming_connections, nextProps.incoming_connections) ||
      shallowDiffers(outgoing_connections, nextProps.outgoing_connections)
    );
  }

  render() {
    const {
      name,
      incoming_connections,
      outgoing_connections,
      connected_list,
      our_plane,
      x,
      y,
      onPortMouseDown = noop,
      act = noop,
      ...rest
    } = this.props as PlaneMasterProps;
    const [showAdd, setShowAdd] = useLocalState('showAdd', false);
    const [currentPlane, setCurrentPlane] = useLocalState('currentPlane', {});
    const [readPlane, setReadPlane] = useLocalState('readPlane', '');

    // Assigned onto the ports
    const PortOptions = {
      onPortMouseDown: onPortMouseDown,
    };
    return (
      <Box position="absolute" left={`${x}px`} top={`${y}px`} {...rest}>
        <Box
          backgroundColor={our_plane.intended_hidden ? '#191919' : '#000000'}
          py={1}
          px={1}
          className="ObjectComponent__Titlebar"
        >
          {name}
          <Button
            ml={2}
            icon="pager"
            tooltip="检查并编辑此平面"
            onClick={() => setReadPlane(our_plane.our_ref)}
          />
        </Box>
        <Box
          className={
            our_plane.intended_hidden
              ? 'ObjectComponent__Greyed_Content'
              : 'ObjectComponent__Content'
          }
          py={1}
          px={1}
        >
          <Stack>
            <Stack.Item>
              <Stack vertical fill>
                {incoming_connections.map((con_ref, portIndex) => (
                  <Stack.Item key={portIndex}>
                    <Port
                      act={act}
                      connection={connected_list[con_ref.ref]}
                      {...PortOptions}
                    />
                  </Stack.Item>
                ))}
              </Stack>
            </Stack.Item>
            <Stack.Item ml={5} width="100%">
              <Stack vertical>
                {outgoing_connections.map((con_ref, portIndex) => (
                  <Stack.Item key={portIndex}>
                    <Port
                      act={act}
                      connection={connected_list[con_ref.ref]}
                      {...PortOptions}
                      isOutput
                    />
                  </Stack.Item>
                ))}
                <Stack.Item align="flex-end">
                  <Button
                    icon="plus"
                    onClick={() => {
                      setShowAdd(true);
                      setCurrentPlane(our_plane);
                    }}
                    right="-4px"
                    tooltip="连接到另一个平面"
                  />
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </Stack>
        </Box>
      </Box>
    );
  }
}

type PortProps = {
  connection: Connected;
  isOutput?: boolean;
  onPortMouseDown?: Function;
  act: Function;
};
class Port extends Component<PortProps> {
  // Ok so like, we're basically treating iconRef as a string here
  // Mostly so svg can work later. You're really not supposed to do this.
  // Should really be a RefObject<Element>
  // But it's how it was being done in circuit code, so eh
  iconRef: RefObject<SVGCircleElement> | RefObject<HTMLSpanElement> | any;

  constructor(props) {
    super(props);
    this.iconRef = createRef();
    this.handlePortMouseDown = this.handlePortMouseDown.bind(this);
  }

  handlePortMouseDown(e) {
    const {
      connection,
      isOutput,
      onPortMouseDown = noop,
    } = this.props as PortProps;
    onPortMouseDown(connection, isOutput, e);
  }

  render() {
    const { connection, isOutput, ...rest } = this.props as PortProps;

    return (
      <Stack {...rest} justify={isOutput ? 'flex-end' : 'flex-start'}>
        <Stack.Item>
          <Box
            className={classes(['ObjectComponent__Port'])}
            onMouseDown={this.handlePortMouseDown}
            textAlign="center"
          >
            <svg
              style={{
                width: '100%',
                height: '100%',
                position: 'absolute',
              }}
              viewBox="0, 0, 100, 100"
            >
              <circle
                stroke={connection.connect_color}
                strokeDasharray={`${100 * Math.PI}`}
                strokeDashoffset={-100 * Math.PI}
                className={`color-stroke-${connection.connect_color}`}
                strokeWidth="50px"
                cx="50"
                cy="50"
                r="50"
                fillOpacity="0"
                transform="rotate(90, 50, 50)"
              />
              <circle
                ref={this.iconRef}
                cx="50"
                cy="50"
                r="50"
                className={`color-fill-${connection.connect_color}`}
              />
            </svg>
            <span ref={this.iconRef} className="ObjectComponent__PortPos" />
          </Box>
        </Stack.Item>
      </Stack>
    );
  }
}

const DrawAbovePlane = (props) => {
  const [showAdd, setShowAdd] = useLocalState('showAdd', false);
  const [showInfo, setShowInfo] = useLocalState('showInfo', false);
  const [readPlane, setReadPlane] = useLocalState('readPlane', '');

  const { act, data } = useBackend<PlaneDebugData>();
  // Plane groups don't use relays right now, because of a byond bug
  // This exists mostly so enabling viewing them is easy and simple
  const { enable_group_view } = data;

  return (
    <>
      {!!readPlane && <PlaneWindow />}
      {!readPlane && (
        <>
          <InfoButton />
          <MobResetButton />
          <ToggleMirror />
          <VVButton />
          <RebuildButton />
        </>
      )}
      {!!enable_group_view && <GroupDropdown />}
      {!!showAdd && <AddModal />}
      {!!showInfo && <InfoModal />}
    </>
  );
};

const PlaneWindow = (props) => {
  const { data, act } = useBackend<PlaneDebugData>();
  const { plane_info } = data;
  const [readPlane, setReadPlane] = useLocalState('readPlane', '');

  const workingPlane: Plane = plane_info[readPlane];

  // NOT sanitized, since this would only be editable by admins or coders
  const doc_html = {
    __html: workingPlane.documentation,
  };

  const setAlpha = (event, value) =>
    act('set_alpha', {
      edit: workingPlane.our_ref,
      alpha: value,
    });

  return (
    <Section
      top="27px"
      right="0px"
      width="40%"
      height="100%"
      position="absolute"
      backgroundColor="#000000"
      title={'Plane Master: ' + workingPlane.name}
      buttons={
        <>
          <ClosePlaneWindow />
          <InfoButton no_position />
          <MobResetButton no_position />
          <ToggleMirror no_position />
          <VVButton no_position />
          <RebuildButton no_position />
        </>
      }
    >
      <Section title="信息">
        <Box dangerouslySetInnerHTML={doc_html} />
        <LabeledList>
          <LabeledList.Divider />
          <Tooltip
            content="Any atoms in the world with the same plane will be drawn to this plane master"
            position="right"
          >
            <LabeledList.Item label="平面">
              {workingPlane.plane}
            </LabeledList.Item>
          </Tooltip>
          <Tooltip
            content="You can think of this as the 'layer' this plane is on. We make duplicates of each plane for each layer, so we can make multiz work"
            position="right"
          >
            <LabeledList.Item label="偏移">
              {workingPlane.offset}
            </LabeledList.Item>
          </Tooltip>
          <Tooltip
            content="Render targets can be used to either reference or draw existing drawn items on the map. For plane masters, we use these for either relays (the blue lines), or filters (the pink ones)"
            position="right"
          >
            <LabeledList.Item label="渲染目标">
              {workingPlane.render_target || '""'}
            </LabeledList.Item>
          </Tooltip>
          <Tooltip
            content="Defines how this plane draws to the things it is relay'd onto. Check the byond ref for more details"
            position="right"
          >
            <LabeledList.Item label="混合模式">
              {workingPlane.blend_mode}
            </LabeledList.Item>
          </Tooltip>
          <Tooltip
            content="If this is 1, the plane master is being forced to hide from its mob. This is most often done as an optimization tactic, since some planes only rarely need to be used"
            position="right"
          >
            <LabeledList.Item label="强制隐藏">
              {workingPlane.intended_hidden}
            </LabeledList.Item>
          </Tooltip>
        </LabeledList>
      </Section>
      <Section title="视觉效果">
        <Button
          tooltip="打开此平面的VV菜单"
          onClick={() =>
            act('vv_plane', {
              edit: workingPlane.our_ref,
            })
          }
        >
          查看变量
        </Button>
        <Button
          tooltip="在整个平面上应用并编辑效果"
          onClick={() =>
            act('edit_filters', {
              edit: workingPlane.our_ref,
            })
          }
        >
          编辑滤镜
        </Button>
        <Button
          tooltip="修改不同颜色分量如何映射到最终平面"
          onClick={() =>
            act('edit_color_matrix', {
              edit: workingPlane.our_ref,
            })
          }
        >
          编辑颜色矩阵
        </Button>
        <Slider
          value={workingPlane.alpha}
          minValue={0}
          maxValue={255}
          step={1}
          stepPixelSize={1.9}
          onChange={(_event, value) =>
            act('set_alpha', { edit: workingPlane.plane, alpha: value })
          }
        >
          Alpha ({workingPlane.alpha})
        </Slider>
      </Section>
    </Section>
  );
};

const InfoButton = (props) => {
  const [showInfo, setShowInfo] = useLocalState('showInfo', false);
  const { no_position } = props;
  const foreign = has_foreign_mob();

  return (
    <Button
      top={no_position ? '' : '30px'}
      right={no_position ? '' : foreign ? '100px' : '76px'}
      position={no_position ? '' : 'absolute'}
      icon="exclamation"
      onClick={() => setShowInfo(true)}
      tooltip="关于此窗口是什么/为何存在的信息"
    />
  );
};

const MobResetButton = (props): any => {
  const { act } = useBackend();
  const { no_position } = props;
  if (!has_foreign_mob()) {
    return;
  }

  return (
    <Button
      top={no_position ? '' : '30px'}
      right={no_position ? '' : '76px'}
      position={no_position ? '' : 'absolute'}
      color="bad"
      icon="power-off"
      onClick={() => act('reset_mob')}
      tooltip="将我们聚焦的生物重置为你的活动生物"
    />
  );
};

const ToggleMirror = (props) => {
  const { act, data } = useBackend<PlaneDebugData>();
  const { no_position } = props;
  const { tracking_active } = data;

  return (
    <Button
      top={no_position ? '' : '30px'}
      right={no_position ? '' : '52px'}
      position={no_position ? '' : 'absolute'}
      color={tracking_active ? 'bad' : 'good'}
      icon="eye"
      onClick={() => act('toggle_mirroring')}
      tooltip={
        (tracking_active ? '禁用' : '启用') +
        " 通过被编辑生物的眼睛'看'，用于调试等"
      }
    />
  );
};

const has_foreign_mob = () => {
  const { data } = useBackend<PlaneDebugData>();
  const { mob_ref, our_ref } = data;
  return mob_ref !== our_ref;
};

const VVButton = (props) => {
  const { act } = useBackend();
  const { no_position } = props;

  return (
    <Button
      top={no_position ? '' : '30px'}
      right={no_position ? '' : '28px'}
      position={no_position ? '' : 'absolute'}
      icon="pen"
      onClick={() => act('vv_mob')}
      tooltip="查看我们当前聚焦生物的变量"
    />
  );
};

const GroupDropdown = (props) => {
  const { act, data } = useBackend<PlaneDebugData>();
  const { our_group, present_groups } = data;

  return (
    <Box top={'30px'} left={'28px'} position={'absolute'}>
      <Tooltip
        content="Plane masters are stored in groups, based off where they came from. MAIN is the main group, but if you open something that displays atoms in a new window, it'll show up here"
        position="right"
      >
        <Dropdown
          options={present_groups}
          selected={our_group}
          onSelected={(value) =>
            act('set_group', {
              target_group: value,
            })
          }
        />
      </Tooltip>
    </Box>
  );
};

const RebuildButton = (props) => {
  const { act } = useBackend();
  const { no_position } = props;

  return (
    <Button
      top={no_position ? '' : '30px'}
      right={no_position ? '' : '6px'}
      position={no_position ? '' : 'absolute'}
      icon="recycle"
      onClick={() => act('rebuild')}
      tooltip="重建所有平面主控. 有点卡，但有用"
    />
  );
};

const ClosePlaneWindow = (props) => {
  const [readPlane, setReadPlane] = useLocalState('readPlane', '');
  return <Button icon="times" onClick={() => setReadPlane('')} />;
};

const AddModal = (props) => {
  const { act, data } = useBackend<PlaneDebugData>();
  const { plane_info } = data;

  const [showAdd, setShowAdd] = useLocalState('showAdd', false);
  const [currentPlane, setCurrentPlane] = useLocalState<Plane>(
    'currentPlane',
    {} as Plane,
  );
  const [currentTarget, setCurrentTarget] = useLocalState<Plane>(
    'currentTarget',
    {} as Plane,
  );

  const plane_list = Object.keys(plane_info).map((plane) => plane_info[plane]);
  const planes = sortBy(plane_list, (plane: Plane) => -plane.plane);

  const plane_options = planes.map((plane) => plane.name);

  return (
    <Modal>
      <Section fill title={'Add relay from ' + currentPlane.name} pr="13px">
        <Dropdown
          options={plane_options}
          selected={currentTarget?.name || 'planes'}
          width="300px"
          onSelected={(value) => {
            setCurrentTarget(planes[plane_options.indexOf(value)]);
          }}
        />
        <Stack justify="center" fill pt="10px">
          <Stack.Item>
            <Button
              color="good"
              onClick={() => {
                act('connect_relay', {
                  source: currentPlane.plane,
                  target: currentTarget.plane,
                });
                setShowAdd(false);
              }}
            >
              确认
            </Button>
          </Stack.Item>
          <Stack.Item>
            <Button color="bad" onClick={() => setShowAdd(false)}>
              取消
            </Button>
          </Stack.Item>
        </Stack>
      </Section>
    </Modal>
  );
};

const InfoModal = (props) => {
  const [showInfo, setShowInfo] = useLocalState('showInfo', false);
  const pain = '';
  const display = {
    __html: pain,
  };
  return (
    <Modal
      position="absolute"
      top="100px"
      right="180px"
      left="180px"
      bottom="100px"
    >
      <Section
        fill
        scrollable
        title="信息面板"
        buttons={
          <Button
            icon="times"
            tooltip="关闭"
            onClick={() => setShowInfo(false)}
          />
        }
      >
        <Box dangerouslySetInnerHTML={display} />
        <h3>What is all this?</h3>
        此UI用于帮助可视化平面主控，我们
        渲染系统的骨干. <br />
        它还提供了一些用于编辑和摆弄它们的工具. <br />
        <br />
        <h3>How to use this UI</h3> <br />
        此UI主要作为可视化工具存在，主要是因为此信息
        相当晦涩，我希望它更容易理解.
        <br />
        <br />
        话虽如此，它也支持编辑平面主控，添加和移除
        中继，并提供了对颜色矩阵/滤镜/透明度/vv
        编辑的便捷访问. <br />
        <br />
        To start off with, each little circle represents a{' '}
        <code>render_target</code> 基于连接.
        <br />
        蓝色节点是中继，用于将一个平面绘制到另一个上。紫色节点
        是基于滤镜的连接. <br />
        你可以根据平面所在的侧边来判断节点的起点和终点
        它&amp;apos;位于. <br />
        <br />
        添加新中继很简单，你只需点击+按钮，然后
        按名称选择要中继到的平面. <br />
        <br />
        点击每个平面右上角的小按钮可以更仔细地查看
        它&amp;apos;的右上角。这会打开一个侧边栏，并显示很多
        关于该平面及其用途的更多常规信息，同时暴露
        一些有用的按钮和有趣的数值. <br />
        <br />
        Planes are aligned based off their initial setup. If you end up breaking
        things byond repair, or just want to reset things, you can hit the
        recycle button in the top left to totally refresh your plane masters.{' '}
        <br />
        <br />
        <h3>What is a plane master?</h3>
        你可以将平面主控视为将一组对象分组到
        一个渲染板上的方式. <br />
        它也是按客户端处理的，这使其非常强大。这是通过使用
        该 <code>plane</code> 变量 <code>/atom</code>. <br />
        <br />
        We first create an atom with an appearance flag that contains{' '}
        <code>PLANE_MASTER</code> 并给它一个 <code>plane</code> 值. <br />
        然后我们镜像相同的 <code>plane</code> 值到所有我们
        想在此组中渲染的原子.
        <br />
        <br />
        最后，我们将 <code>PLANE_MASTER</code>&amp;apos;d 原子放入
        相关客户端的屏幕内容中. <br />
        这就设置了最低限度.
        <br />
        <br />
        值得注意的是 <code>plane</code> var 不仅影响
        此渲染分组行为. <br />
        它还会影响地图上对象的层叠. <br />
        <br />
        因此，有些效果几乎不可能
        用平面实现. <br />
        遮罩一个物体同时按正确顺序绘制该物体
        与地图上其他物体就是一个很好的例子.
        <br />
        它 <b>is</b> 可能做到，但它&amp;apos;相当具有破坏性.
        <br />
        <br />
        通常，平面只会分组，应用效果，然后绘制
        直接到游戏.
        <br />
        如果我们想绘制 <b>planes</b> 那到其他平面上呢? <br />
        <br />
        <h3>Render Targets and Relays</h3>
        <br />
        将一件事物渲染到另一件事物上实际上并不那么复杂。 <br />
        我们可以设置 <code>render_target</code> 一个原子的变量来中继
        它到某个 <code>render_source</code>.<br />
        <br />
        如果那个 <code>render_target</code> 前面有 *，它将
        <b>not</b> be drawn to the actual client view, and instead just relayed.{' '}
        <br />
        <br />
        Ok so we can relay a plane master onto some other atom, but how do we
        get it on another plane master? We can&apos;t just draw it with{' '}
        <code>render_source</code>, 因为我们可能想要中继不止一个
        平面主控。
        <br />
        <br />
        那为什么不把它中继到另一个原子呢? 然后，设置那个
        原子的 <code>plane</code> 变量为我们想要的平面主控? <br />
        <br />
        这基本上就是我们所做的。 <br />
        值得注意的是，渲染源经常被滤镜使用，
        通常用于应用一些位移或遮罩。
        <br />
        <br />
        <h3>Applying effects</h3> <br />
        好了，所以我们可以分组和中继平面，但我们实际上能用
        它做什么? <br />
        <br />
        结果有很多东西。滤镜非常强大，而且我们经常使用它们
        相当多。 <br />
        你可以使用滤镜用一个平面遮罩另一个平面，或者将一个平面作为
        另一个平面的扭曲源。 <br />
        <br />
        也可以做更基础的事情，设置平面的颜色矩阵可以
        非常强大。 <br />
        Even just setting alpha to show and hide things can be quite useful.{' '}
        <br />
        <br />
        我不会在这里深入讲解我们做的每一个效果，你可以通过点击每个平面右上角的小按钮来了解更多关于
        每个平面的信息。 <br />
        <br />
      </Section>
    </Modal>
  );
};
