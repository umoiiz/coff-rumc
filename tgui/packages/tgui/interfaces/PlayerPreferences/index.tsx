import { Button, Flex, Section, Tabs } from 'tgui-core/components';

import { useBackend } from '../../backend';
import { Window } from '../../layouts';
import { BackgroundInformation } from './BackgroundInformation';
import { CharacterCustomization } from './CharacterCustomization';
import { DrawOrder } from './DrawOrder';
import { GameSettings } from './GameSettings';
import { GearCustomization } from './GearCustomisation';
import { JobPreferences } from './JobPreferences';
import { KeybindSettings } from './KeybindSettings';
import { YautjaCustomization } from './YautjaCustomization';

export const PlayerPreferences = (props) => {
  const { act, data } = useBackend<PlayerPreferencesData>();

  const { save_slot_names, slot, tabIndex } = data;
  const activeTab = Number(tabIndex) || 1;

  let affectsSave = false;
  let CurrentTab = CharacterCustomization;
  switch (activeTab) {
    case 1:
      CurrentTab = CharacterCustomization;
      affectsSave = true;
      break;
    case 2:
      CurrentTab = YautjaCustomization;
      affectsSave = true;
      break;
    case 3:
      CurrentTab = BackgroundInformation;
      affectsSave = true;
      break;
    case 4:
      CurrentTab = GearCustomization;
      affectsSave = true;
      break;
    case 5:
      CurrentTab = JobPreferences;
      affectsSave = true;
      break;
    case 6:
      CurrentTab = GameSettings;
      break;
    case 7:
      CurrentTab = KeybindSettings;
      break;
    case 8:
      CurrentTab = DrawOrder;
      break;
    default:
  }

  // I dont like this shit, but it doesn't matter in the end
  // i'd rather massage the data in js than byond.
  const slotNames = Object.values(save_slot_names || {}).map(
    (name) => name.split(' ')[0],
  );

  const saveSlots = new Array(10).fill(1).map((_, idx) => (
    <Button
      key={idx + 1}
      selected={idx + 1 === slot}
      onClick={() => act('changeslot', { changeslot: idx + 1 })}
    >
      {slotNames[idx] || `Character ${idx + 1}`}
    </Button>
  ));

  return (
    <Window width={1140} height={650}>
      <Window.Content scrollable>
        <Flex>
          <Flex.Item>
            <NavigationSelector tabIndex={activeTab} />
          </Flex.Item>
          <Flex.Item grow={1} basis={0}>
            {affectsSave ? (
              <Section title="保存槽位" buttons={saveSlots}>
                <CurrentTab key={activeTab} />
              </Section>
            ) : (
              <CurrentTab key={activeTab} />
            )}
          </Flex.Item>
        </Flex>
      </Window.Content>
    </Window>
  );
};

const NavigationSelector = (props) => {
  const { tabIndex } = props;
  const { act } = useBackend();
  return (
    <Tabs vertical>
      <Tabs.Tab
        selected={tabIndex === 1}
        onClick={() => act('tab_change', { tabIndex: 1 })}
      >
        角色自定义
      </Tabs.Tab>
      <Tabs.Tab
        selected={tabIndex === 2}
        onClick={() => act('tab_change', { tabIndex: 2 })}
      >
        铁血战士自定义
      </Tabs.Tab>
      <Tabs.Tab
        selected={tabIndex === 3}
        onClick={() => act('tab_change', { tabIndex: 3 })}
      >
        背景信息
      </Tabs.Tab>
      <Tabs.Tab
        selected={tabIndex === 4}
        onClick={() => act('tab_change', { tabIndex: 4 })}
      >
        装备自定义
      </Tabs.Tab>
      <Tabs.Tab
        selected={tabIndex === 5}
        onClick={() => act('tab_change', { tabIndex: 5 })}
      >
        职业偏好
      </Tabs.Tab>
      <Tabs.Tab
        selected={tabIndex === 6}
        onClick={() => act('tab_change', { tabIndex: 6 })}
      >
        游戏设置
      </Tabs.Tab>
      <Tabs.Tab
        selected={tabIndex === 7}
        onClick={() => act('tab_change', { tabIndex: 7 })}
      >
        按键绑定
      </Tabs.Tab>
      <Tabs.Tab
        selected={tabIndex === 8}
        onClick={() => act('tab_change', { tabIndex: 8 })}
      >
        绘制顺序
      </Tabs.Tab>
    </Tabs>
  );
};
