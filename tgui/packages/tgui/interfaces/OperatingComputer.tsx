import { LabeledList, NoticeBox, ProgressBar, Section } from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

const STAT_LABELS = [
  ['good', 'Stable'],
  ['average', 'Unconscious'],
  ['bad', 'Non-Responsive'],
] as const;

const DAMAGES = [
  ['Brute Damage', 'bruteLoss'],
  ['Fire Damage', 'fireLoss'],
  ['Toxin Damage', 'toxLoss'],
  ['Suffocation Damage', 'oxyLoss'],
] as const;

type PatientData = {
  name: string;
  age: number;
  blood_type: string;
  health: number;
  maxHealth: number;
  bruteLoss: number;
  toxLoss: number;
  fireLoss: number;
  oxyLoss: number;
  stat: number;
  pulse: string | number;
};

type Data = {
  hasTable: BooleanLike;
  patient: PatientData | null;
};

export const OperatingComputer = (props) => {
  const { data } = useBackend<Data>();
  const { hasTable, patient } = data;

  return (
    <Window width={350} height={330} title="Operating Computer">
      <Window.Content scrollable>
        {!hasTable ? (
          <NoticeBox>未检测到手术台.</NoticeBox>
        ) : !patient ? (
          <NoticeBox>未检测到患者</NoticeBox>
        ) : (
          <PatientState />
        )}
      </Window.Content>
    </Window>
  );
};

const PatientState = (props) => {
  const { data } = useBackend<Data>();
  const patient = data.patient!;
  const status = STAT_LABELS[patient.stat] || STAT_LABELS[0];

  return (
    <Section title="患者信息">
      <LabeledList>
        <LabeledList.Item label="姓名">{patient.name}</LabeledList.Item>
        <LabeledList.Item label="年龄">{patient.age}</LabeledList.Item>
        <LabeledList.Item label="血型">
          {patient.blood_type || 'Unknown'}
        </LabeledList.Item>
        <LabeledList.Item label="状态" color={status[0]}>
          {status[1]}
        </LabeledList.Item>
        <LabeledList.Item label="健康">
          <ProgressBar
            value={patient.health}
            minValue={-patient.maxHealth}
            maxValue={patient.maxHealth}
            color={patient.health >= 0 ? 'good' : 'average'}
          >
            {patient.health}
          </ProgressBar>
        </LabeledList.Item>
        {DAMAGES.map(([label, key]) => (
          <LabeledList.Item key={key} label={label}>
            <ProgressBar value={patient[key] / patient.maxHealth} color="bad">
              {patient[key]}
            </ProgressBar>
          </LabeledList.Item>
        ))}
        <LabeledList.Item label="心率">
          {patient.pulse} BPM
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
