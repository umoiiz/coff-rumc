import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
} from 'tgui-core/components';

import { useBackend } from '../../backend';
import {
  COLOR_BRUTE,
  COLOR_BURN,
  REVIVABLE_STATES_TO_COLORS,
} from './constants';
import { MedScannerData } from './data';
import { MedDamageType } from './MedDamageType';

/** The most basic info: name, species, health, damage, revivability and hugged state */
export function PatientBasics() {
  const { data } = useBackend<MedScannerData>();
  const {
    patient,
    species,
    dead,
    health,
    max_health,
    crit_threshold,
    dead_threshold,
    total_brute,
    total_burn,
    total_tox,
    total_oxy,
    total_clone,
    hugged,
    revivable_status,
    revivable_reason,
    ssd,
    accessible_theme,
  } = data;
  return (
    <Section
      title={`${species.name}: ${patient}`}
      buttons={
        <Button
          icon="info"
          tooltip="要了解某事物的信息,请将鼠标悬停在其上 - 几乎每个元素都有工具提示.此外,情境建议将显示在治疗建议下方."
          color="transparent"
          mt={
            // with the "hackerman" theme, the buttons have this ugly outline that messes with the section titlebar, let's fix that
            accessible_theme && species.is_robotic_species ? '-5px' : '0px'
          }
        >
          信息
        </Button>
      }
    >
      {!!hugged && (
        <NoticeBox danger>
          患者已被植入异形胚胎!
        </NoticeBox>
      )}
      {!!ssd && <NoticeBox>{ssd}</NoticeBox>}
      <LabeledList>
        <LabeledList.Item
          label="健康"
          tooltip={`
            How healthy the patient is.${
              !!species.is_robotic_species &&
              ` If the patient's health dips below ${crit_threshold}%, they enter critical condition and suffocate rapidly.`
            }
            If the patient's health hits ${(dead_threshold / max_health) * 100}%, they die.
          `}
        >
          {health >= 0 ? (
            <ProgressBar
              value={health / max_health}
              ranges={{
                good: [0.4, Infinity],
                average: [0.2, 0.4],
                bad: [-Infinity, 0.2],
              }}
            />
          ) : (
            <ProgressBar value={1 + health / max_health} color="bad" bold>
              {Math.trunc((health / max_health) * 100)}%
            </ProgressBar>
          )}
        </LabeledList.Item>
        {!!dead && (
          <LabeledList.Item label="可复活">
            <Box color={REVIVABLE_STATES_TO_COLORS[revivable_status]} bold>
              {revivable_status}
              {!!revivable_reason && ` (${revivable_reason})`}
            </Box>
          </LabeledList.Item>
        )}
        <LabeledList.Item
          label="伤害"
          tooltip="独特的伤害类型.每一种都有工具提示,描述其如何造成以及可能的治疗方法."
        >
          <MedDamageType
            name="钝击"
            color={COLOR_BRUTE}
            damage={total_brute}
            tooltip={
              species.is_robotic_species
                ? '钝击.由物理创伤来源造成,例如近战、交火等.用喷灯或机器人摇篮修复.'
                : '钝击.由物理创伤来源造成,例如近战、交火等.用双卡因或高级创伤包治疗.'
            }
            noPadding
          />
          <MedDamageType
            name="烧伤"
            color={COLOR_BURN}
            damage={total_burn}
            tooltip={
              species.is_robotic_species
                ? '烧伤.由燃烧来源造成,例如能量武器、酸液、火焰等.用电缆线圈或机器人摇篮修复.'
                : '烧伤.由燃烧来源造成,例如过热、能量武器、酸液、火焰等.用凯洛坦或高级烧伤包治疗.'
            }
          />
          {!species.is_robotic_species && (
            <>
              <MedDamageType
                name="毒素"
                color="green"
                damage={total_tox}
                tooltip="毒素.由化学物质或器官损伤造成.用迪洛文治疗."
              />
              <MedDamageType
                name="缺氧"
                color="blue"
                damage={total_oxy}
                tooltip="缺氧损伤. 由处于危急状态, 器官损伤或极度疲惫引起. 可通过心肺复苏, 地塞林/地塞林加强型治疗, 或在患者脱离危急状态后自行缓解."
              />
            </>
          )}
          {!species.is_synthetic && (
            <MedDamageType
              name={species.is_combat_robot ? 'Integrity' : 'Clone'}
              color="teal"
              damage={total_clone}
              tooltip={
                species.is_robotic_species
                  ? '完整性损伤. 由异形精神吸取引起. 可通过机械摇篮治疗.'
                  : '克隆损伤. 由异形精神吸取或特殊化学物质引起. 可通过低温冷冻或睡眠治疗.'
              }
            />
          )}
          {!!species.is_robotic_species && (
            <>
              <MedDamageType
                name="毒素"
                tooltip="机械种族无法积累毒素."
                disabled
              />
              <MedDamageType
                name="缺氧"
                tooltip="机械种族不会窒息."
                disabled
              />
              {!!species.is_synthetic && (
                <MedDamageType
                  name="克隆"
                  tooltip="合成体不会遭受细胞损伤或长期完整性损失."
                  disabled
                />
              )}
            </>
          )}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
}
