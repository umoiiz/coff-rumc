import {
  Box,
  Button,
  ColorBox,
  Flex,
  LabeledList,
  Section,
} from 'tgui-core/components';
import { capitalize } from 'tgui-core/string';

import { useBackend } from '../../backend';
import {
  SelectFieldPreference,
  TextFieldPreference,
  ToggleFieldPreference,
} from './FieldPreferences';
import { ProfilePicture } from './ProfilePicture';

export const CharacterCustomization = (props) => {
  const { act, data } = useBackend<CharacterCustomizationData>();
  const {
    random_name,
    gender,
    r_hair,
    g_hair,
    b_hair,
    r_grad,
    g_grad,
    b_grad,
    r_eyes,
    g_eyes,
    b_eyes,
    r_facial,
    g_facial,
    b_facial,
  } = data;

  const rgbToHex = (red, green, blue) => {
    const convert = (comp) => {
      const hex = comp.toString(16);
      return hex.length === 1 ? `0${hex}` : hex;
    };
    return '#' + convert(red) + convert(green) + convert(blue);
  };
  const genders = ['male', 'female', 'plural', 'neuter'];
  const genderToName = {
    male: '男性',
    female: '女性',
    neuter: '物体',
    plural: '其他',
  };
  return (
    <>
      <Section title="档案">
        <Flex>
          <Flex.Item>
            <LabeledList>
              <TextFieldPreference
                label={'全名'}
                action={'name_real'}
                value={'real_name'}
                extra={
                  <Box as="span">
                    <Button onClick={() => act('randomize_name')}>
                      随机
                    </Button>
                    <Button.Checkbox
                      inline
                      content="始终随机"
                      checked={random_name === 1}
                      onClick={() => act('toggle_always_random')}
                    />
                  </Box>
                }
              />
              <TextFieldPreference label={'异形'} value={'xeno_name'} />
              <TextFieldPreference
                label={'小队机器人名称'}
                value={'squad_robot_name'}
              />
              <TextFieldPreference
                label={'合成人名称'}
                value={'synthetic_name'}
              />
              <TextFieldPreference label={'AI名称'} value={'ai_name'} />
            </LabeledList>
          </Flex.Item>
          <Flex.Item>
            <ProfilePicture />
          </Flex.Item>
        </Flex>
      </Section>
      <Section
        title="身体"
        buttons={
          <Button color="bad" icon="power-off" onClick={() => act('random')}>
            全部随机
          </Button>
        }
      >
        <Flex>
          <Flex.Item>
            <LabeledList>
              <TextFieldPreference label={'年龄'} value={'age'} />
              <LabeledList.Item label={'性别'}>
                {genders.map((thisgender) => (
                  <Button.Checkbox
                    inline
                    key={thisgender}
                    content={capitalize(genderToName[thisgender])}
                    checked={gender === thisgender}
                    onClick={() =>
                      act('toggle_gender', { newgender: thisgender })
                    }
                  />
                ))}
              </LabeledList.Item>
              <SelectFieldPreference
                label={'发型'}
                value={'h_style'}
                action={'hairstyle'}
              />
              <TextFieldPreference
                label={'发色'}
                value={rgbToHex(r_hair, g_hair, b_hair)}
                noAction
                extra={
                  <>
                    <ColorBox color={rgbToHex(r_hair, g_hair, b_hair)} mr={1} />
                    <Button icon="edit" onClick={() => act('haircolor')} />
                  </>
                }
              />
              <SelectFieldPreference
                label={'渐变发型'}
                value={'grad_style'}
                action={'grad_style'}
              />
              <TextFieldPreference
                label={'渐变色'}
                value={rgbToHex(r_grad, g_grad, b_grad)}
                noAction
                extra={
                  <>
                    <ColorBox color={rgbToHex(r_grad, g_grad, b_grad)} mr={1} />
                    <Button icon="edit" onClick={() => act('grad_color')} />
                  </>
                }
              />
              <TextFieldPreference
                label={'眼睛颜色'}
                value={rgbToHex(r_eyes, g_eyes, b_eyes)}
                noAction
                extra={
                  <>
                    <ColorBox color={rgbToHex(r_eyes, g_eyes, b_eyes)} mr={1} />
                    <Button icon="edit" onClick={() => act('eyecolor')} />
                  </>
                }
              />
              <ToggleFieldPreference
                label={'视力'}
                value={'good_eyesight'}
                leftLabel={'良好'}
                rightLabel={'差'}
                action={'toggle_eyesight'}
              />
              <SelectFieldPreference
                label={'面部毛发'}
                value={'f_style'}
                action={'facial_style'}
              />
              <TextFieldPreference
                label={'面部毛发颜色'}
                value={rgbToHex(r_facial, g_facial, b_facial)}
                noAction
                extra={
                  <>
                    <ColorBox
                      color={rgbToHex(r_facial, g_facial, b_facial)}
                      mr={1}
                    />
                    <Button icon="edit" onClick={() => act('facialcolor')} />
                  </>
                }
              />
            </LabeledList>
          </Flex.Item>
          <Flex.Item>
            <LabeledList>
              <SelectFieldPreference
                label={'种族'}
                value={'species'}
                action={'species'}
              />
              <SelectFieldPreference
                label={'合成人类型'}
                value={'synthetic_type'}
                action={'synthetic_type'}
              />
              <SelectFieldPreference
                label={'民族'}
                value={'ethnicity'}
                action={'ethnicity'}
              />
              <SelectFieldPreference
                label={'机器人型号'}
                value={'squad_robot_type'}
                action={'squad_robot_type'}
              />
              <SelectFieldPreference
                label={'国籍'}
                value={'citizenship'}
                action={'citizenship'}
              />
              <SelectFieldPreference
                label={'宗教'}
                value={'religion'}
                action={'religion'}
              />
              <SelectFieldPreference
                label={'TTS语音'}
                value={'tts_voice'}
                action={'tts_voice'}
              />
              <TextFieldPreference label={'TTS音调'} value={'tts_pitch'} />
            </LabeledList>
          </Flex.Item>
        </Flex>
      </Section>
    </>
  );
};
