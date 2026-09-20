import {
  Button,
  ColorBox,
  LabeledList,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import {
  LoopingSelectionPreference,
  SelectFieldPreference,
  SliderInputPreference,
  TextFieldPreference,
  ToggleFieldPreference,
} from './FieldPreferences';

const MultiZPerfToString = (integer) => {
  let returnval = '';
  switch (integer) {
    case -1:
      returnval = '无剔除';
      break;
    case 0:
      returnval = '低';
      break;
    case 1:
      returnval = '中';
      break;
    case 2:
      returnval = '高';
      break;
    default:
      returnval = '错误!';
  }
  return returnval;
};

const ParallaxNumToString = (integer) => {
  let returnval = '';
  switch (integer) {
    case -1:
      returnval = '疯狂';
      break;
    case 0:
      returnval = '高';
      break;
    case 1:
      returnval = '中';
      break;
    case 2:
      returnval = '低';
      break;
    case 3:
      returnval = '已禁用';
      break;
    default:
      returnval = '错误!';
  }
  return returnval;
};

const PixelSizeNumToString = (integer) => {
  let returnval = '';
  switch (integer) {
    case 0:
      returnval = 'Auto-Scaling';
      break;
    case 1:
      returnval = 'Scaling 1X';
      break;
    case 1.5:
      returnval = 'Scaling 1.5X';
      break;
    case 2:
      returnval = 'Scaling 2X';
      break;
    case 3:
      returnval = 'Scaling 3X';
      break;
    default:
      returnval = 'Error!';
  }
  return returnval;
};

export const GameSettings = (props) => {
  const { act, data } = useBackend<GameSettingData>();
  const {
    ui_style_color,
    scaling_method,
    pixel_size,
    parallax,
    multiz_performance,
    volume_adminhelp,
    volume_adminmusic,
    volume_ambience,
    volume_lobby,
    volume_instruments,
    volume_weather,
    volume_end_of_round,
    is_admin,
  } = data;

  // Remember to update this alongside defines
  // todo: unfuck. Bruh why is this being handled in the tsx?
  const TTSRadioSetting = ['sl', 'squad', 'command', 'hivemind', 'all'];
  const TTSRadioSettingToBitfield = {
    sl: 1 << 0,
    squad: 1 << 1,
    command: 1 << 2,
    all: 1 << 3,
    hivemind: 1 << 4,
  };
  const TTSRadioSettingToName = {
    sl: '队长',
    squad: '小队',
    command: '指挥/巢穴领袖',
    hivemind: '巢穴意识',
    all: '所有频道',
  };

  return (
    <Section title="游戏设置">
      <Stack fill>
        <Stack.Item grow>
          <Section title="窗口设置">
            <LabeledList>
              <ToggleFieldPreference
                label="窗口闪烁"
                value="windowflashing"
                action="windowflashing"
                leftLabel={'已启用'}
                rightLabel={'已禁用'}
              />
              <ToggleFieldPreference
                label="独特动作行为"
                value="unique_action_use_active_hand"
                action="unique_action_use_active_hand"
                leftLabel={'在活动手上使用'}
                rightLabel={'在双手上使用'}
              />
              <SelectFieldPreference
                label="播放文本转语音"
                value="sound_tts"
                action="sound_tts"
              />
              <TextFieldPreference
                label="文本转语音音量"
                value="volume_tts"
              />
              <LabeledList.Item label={'文本转语音无线电配置'}>
                {TTSRadioSetting.map((setting) => (
                  <Button.Checkbox
                    inline
                    key={setting}
                    content={TTSRadioSettingToName[setting]}
                    checked={
                      TTSRadioSettingToBitfield[setting] &
                      data['radio_tts_flags']
                    }
                    onClick={() =>
                      act('toggle_radio_tts_setting', {
                        newsetting: setting,
                      })
                    }
                  />
                ))}
              </LabeledList.Item>
              <ToggleFieldPreference
                label="无障碍TGUI主题"
                value="accessible_tgui_themes"
                action="accessible_tgui_themes"
                leftLabel={'已启用'}
                rightLabel={'已禁用'}
                tooltip="尽可能在所有已实现的地方优先使用更无障碍/默认的TGUI主题."
              />
              <ToggleFieldPreference
                label="全屏模式"
                value="fullscreen_mode"
                action="fullscreen_mode"
                leftLabel={'全屏'}
                rightLabel={'窗口化'}
                tooltip="切换窗口化无边框模式"
              />
              <ToggleFieldPreference
                label="状态栏"
                value="show_status_bar"
                action="show_status_bar"
                leftLabel={'显示'}
                rightLabel={'隐藏'}
                tooltip="是否在屏幕左下角显示或隐藏状态栏"
              />
              <ToggleFieldPreference
                label="环境光遮蔽"
                value="ambient_occlusion"
                action="ambient_occlusion"
                leftLabel={'开启'}
                rightLabel={'关闭'}
                tooltip="是否渲染环境光遮蔽,这会为地板添加类似阴影的效果.关闭时提升性能."
              />
              <ToggleFieldPreference
                label="多Z层(3D)视差"
                value="multiz_parallax"
                action="multiz_parallax"
                leftLabel={'开启'}
                rightLabel={'关闭'}
                tooltip="切换视差是否跨多个Z层应用.关闭时提升性能."
              />
              <LoopingSelectionPreference
                label="多Z层细节"
                value={MultiZPerfToString(multiz_performance)}
                action="multiz_performance"
                tooltip="在开始剔除前渲染多少多Z层级别.如果多Z层地图出现卡顿,降低此值以提升性能."
              />
              <ToggleFieldPreference
                label="TGUI窗口位置"
                value="tgui_lock"
                action="tgui_lock"
                leftLabel={'自由(默认)'}
                rightLabel={'主显示器'}
              />
              <ToggleFieldPreference
                label="UI缩放"
                value="ui_scale"
                action="ui_scale"
                leftLabel={'已启用'}
                rightLabel={'已禁用'}
                tooltip="UI是否应缩放以匹配你的显示器缩放"
              />
              <ToggleFieldPreference
                label="TGUI输入框"
                value="tgui_input"
                action="tgui_input"
                leftLabel={'已启用'}
                rightLabel={'已禁用'}
              />
              <ToggleFieldPreference
                label="TGUI输入按钮"
                value="tgui_input_big_buttons"
                action="tgui_input_big_buttons"
                leftLabel={'正常'}
                leftValue={0}
                rightLabel={'大'}
                rightValue={1}
              />
              <ToggleFieldPreference
                label="TGUI输入按钮位置"
                value="tgui_input_buttons_swap"
                action="tgui_input_buttons_swap"
                leftLabel={'提交/取消'}
                rightLabel={'取消/提交'}
              />
              <ToggleFieldPreference
                label="工具提示"
                value="tooltips"
                action="tooltips"
                leftLabel={'已启用'}
                rightLabel={'已禁用'}
              />
              <TextFieldPreference label={'FPS'} value={'clientfps'} />
              <ToggleFieldPreference
                label="自动适配视口"
                value="auto_fit_viewport"
                action="auto_fit_viewport"
                leftLabel={'已启用'}
                rightLabel={'已禁用'}
              />
              <ToggleFieldPreference
                label="自动与可部署物交互"
                value="autointeractdeployablespref"
                action="autointeractdeployablespref"
                leftLabel={'已启用'}
                rightLabel={'已禁用'}
              />
              <ToggleFieldPreference
                label="使用方向性攻击"
                value="directional_attacks"
                action="directional_attacks"
                leftLabel={'已启用'}
                rightLabel={'已禁用'}
              />
              <ToggleFieldPreference
                label="切换点击拖拽"
                value="toggle_clickdrag"
                action="toggle_clickdrag"
                leftLabel={'已启用'}
                rightLabel={'已禁用'}
              />
            </LabeledList>
          </Section>
        </Stack.Item>
        <Stack.Item grow>
          <Section title="消息设置">
            <LabeledList>
              <ToggleFieldPreference
                label="符文聊天气泡"
                value="chat_on_map"
                action="chat_on_map"
                leftValue={1}
                leftLabel={'已启用'}
                rightValue={0}
                rightLabel={'已禁用'}
              />
              <TextFieldPreference
                label="符文聊天字符限制"
                value="max_chat_length"
              />
              <ToggleFieldPreference
                label="显示非生物符文聊天"
                value="see_chat_non_mob"
                action="see_chat_non_mob"
                leftValue={1}
                leftLabel={'已启用'}
                rightValue={0}
                rightLabel={'已禁用'}
              />
              <ToggleFieldPreference
                label="在符文聊天中显示表情"
                value="see_rc_emotes"
                action="see_rc_emotes"
                leftValue={1}
                leftLabel={'已启用'}
                rightValue={0}
                rightLabel={'已禁用'}
              />
              <ToggleFieldPreference
                label="显示正在输入指示器"
                value="show_typing"
                action="show_typing"
                leftValue={1}
                leftLabel={'已启用'}
                rightValue={0}
                rightLabel={'已禁用'}
              />
              <ToggleFieldPreference
                label="显示自身战斗信息"
                value="mute_self_combat_messages"
                action="mute_self_combat_messages"
                leftValue={0}
                leftLabel={'已启用'}
                rightValue={1}
                rightLabel={'已禁用'}
              />
              <ToggleFieldPreference
                label="显示他人战斗信息"
                value="mute_others_combat_messages"
                action="mute_others_combat_messages"
                leftValue={0}
                leftLabel={'已启用'}
                rightValue={1}
                rightLabel={'已禁用'}
              />
              <ToggleFieldPreference
                label="显示异形等级"
                value="show_xeno_rank"
                action="show_xeno_rank"
                leftValue={1}
                leftLabel={'已启用'}
                rightValue={0}
                rightLabel={'已禁用'}
              />
            </LabeledList>
          </Section>
        </Stack.Item>
      </Stack>
      <Stack>
        <Stack.Item grow>
          <Section title="界面设置">
            <LabeledList>
              <SelectFieldPreference
                label={'界面风格'}
                value={'ui_style'}
                action={'ui'}
              />
              <TextFieldPreference
                label={'界面颜色'}
                value={'ui_style_color'}
                noAction
                extra={
                  <>
                    <ColorBox color={ui_style_color} mr={1} />
                    <Button icon="edit" onClick={() => act('uicolor')} />
                  </>
                }
              />
              <TextFieldPreference
                label={'界面透明度'}
                value={'ui_style_alpha'}
                action={'uialpha'}
              />
              <ToggleFieldPreference
                label="宽屏模式"
                value="widescreenpref"
                action="widescreenpref"
                leftLabel={'已启用'}
                rightLabel={'已禁用'}
              />
              <ToggleFieldPreference
                label="自动打开更新日志"
                value="auto_open_changelogs"
                action="auto_open_changelogs"
                leftLabel={'已启用'}
                rightLabel={'已禁用'}
              />
              <ToggleFieldPreference
                label="径向医疗轮盘"
                value="radialmedicalpref"
                action="radialmedicalpref"
                leftLabel={'已启用'}
                rightLabel={'已禁用'}
              />
              <ToggleFieldPreference
                label="径向堆叠轮盘"
                value="radialstackspref"
                action="radialstackspref"
                leftLabel={'已启用'}
                rightLabel={'已禁用'}
              />
              <ToggleFieldPreference
                label="径向激光枪轮盘"
                value="radiallasersgunpref"
                action="radiallasersgunpref"
                leftLabel={'已启用'}
                rightLabel={'已禁用'}
              />
              <LoopingSelectionPreference
                label="缩放方式"
                value={scaling_method}
                action="scaling_method"
              />
              <LoopingSelectionPreference
                label="像素尺寸缩放"
                value={pixel_size}
                action="pixel_size"
              />
              <LoopingSelectionPreference
                label="视差"
                value={ParallaxNumToString(parallax)}
                action="parallax"
              />
            </LabeledList>
          </Section>
        </Stack.Item>
        <Stack.Item grow>
          <Section title="声音设置">
            <LabeledList>
              <SliderInputPreference
                label="管理员音乐音量"
                value={volume_adminmusic}
                action="volume_adminmusic"
              />
              <SliderInputPreference
                label="环境音量"
                value={volume_ambience}
                action="volume_ambience"
              />
              <SliderInputPreference
                label="大厅音乐音量"
                value={volume_lobby}
                action="volume_lobby"
              />
              <SliderInputPreference
                label="乐器音乐音量"
                value={volume_instruments}
                action="volume_instruments"
              />
              <SliderInputPreference
                label="天气音量"
                value={volume_weather}
                action="volume_weather"
              />
              <SliderInputPreference
                label="回合结束音效音量"
                value={volume_end_of_round}
                action="volume_end_of_round"
              />
              {!!is_admin && (
                <SliderInputPreference
                  label="管理员求助音量"
                  value={volume_adminhelp}
                  action="volume_adminhelp"
                />
              )}
            </LabeledList>
          </Section>
        </Stack.Item>
      </Stack>
      {!!is_admin && (
        <Stack>
          <Stack.Item grow>
            <Section title="工作人员设置">
              <LabeledList>
                <ToggleFieldPreference
                  label="快速MC刷新"
                  value="fast_mc_refresh"
                  action="fast_mc_refresh"
                  leftLabel={'已启用'}
                  rightLabel={'已禁用'}
                />
                <ToggleFieldPreference
                  label="分离管理员标签页"
                  value="split_admin_tabs"
                  action="split_admin_tabs"
                  leftLabel={'已启用'}
                  rightLabel={'已禁用'}
                  tooltip="启用后,工作人员命令将分为多个标签页(管理/娱乐等).否则,非调试命令将保留在一个状态面板标签页中."
                />
                <ToggleFieldPreference
                  label="随处收听OOC"
                  value="hear_ooc_anywhere_as_staff"
                  action="hear_ooc_anywhere_as_staff"
                  leftLabel={'已启用'}
                  rightLabel={'已禁用'}
                  tooltip="允许在任何情况下从任何位置收听OOC频道."
                />
              </LabeledList>
            </Section>
          </Stack.Item>
        </Stack>
      )}
    </Section>
  );
};
