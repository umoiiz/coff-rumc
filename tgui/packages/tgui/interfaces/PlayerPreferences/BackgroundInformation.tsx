import { useState } from 'react';
import { Box, Button, Section, Stack, TextArea } from 'tgui-core/components';

import { useBackend } from '../../backend';

export const BackgroundInformation = (props) => {
  const { act, data } = useBackend<BackgroundInformationData>();
  const {
    slot,
    flavor_text,
    med_record,
    gen_record,
    sec_record,
    exploit_record,
  } = data;
  const [characterDesc, setCharacterDesc] = useState(flavor_text);
  const [medicalDesc, setMedicalDesc] = useState(med_record);
  const [employmentDesc, setEmploymentDesc] = useState(gen_record);
  const [securityDesc, setSecurityDesc] = useState(sec_record);
  const [exploitsDesc, setExploitsDesc] = useState(exploit_record);
  return (
    <Section title="背景信息">
      <Section
        title="角色描述"
        buttons={
          <Box>
            <Button
              icon="save"
              disabled={characterDesc === flavor_text}
              onClick={() => act('flavor_text', { characterDesc })}
            >
              保存
            </Button>
            <Button icon="times" onClick={() => setCharacterDesc(flavor_text)}>
              重置
            </Button>
          </Box>
        }
      >
        <TextArea
          expensive
          key="character"
          fluid
          height="100px"
          value={characterDesc}
          onChange={setCharacterDesc}
        />
      </Section>

      <Stack>
        <Stack.Item grow>
          <Section
            title="医疗记录"
            buttons={
              <Box>
                <Button
                  icon="save"
                  disabled={medicalDesc === med_record}
                  onClick={() => act('med_record', { medicalDesc })}
                >
                  保存
                </Button>
                <Button icon="times" onClick={() => setMedicalDesc(med_record)}>
                  重置
                </Button>
              </Box>
            }
          >
            <TextArea
              fluid
              height="100px"
              expensive
              maxLength={1024}
              value={medicalDesc}
              onChange={setMedicalDesc}
            />
          </Section>
        </Stack.Item>
        <Stack.Item grow>
          <Section
            title="就业记录"
            buttons={
              <Box>
                <Button
                  icon="save"
                  disabled={employmentDesc === gen_record}
                  onClick={() => act('gen_record', { employmentDesc })}
                >
                  保存
                </Button>
                <Button
                  icon="times"
                  onClick={() => setEmploymentDesc(gen_record)}
                >
                  重置
                </Button>
              </Box>
            }
          >
            <TextArea
              fluid
              height="100px"
              maxLength={1024}
              value={employmentDesc}
              expensive
              onChange={setEmploymentDesc}
            />
          </Section>
        </Stack.Item>
      </Stack>
      <Stack>
        <Stack.Item grow>
          <Section
            title="安全记录"
            buttons={
              <Box>
                <Button
                  icon="save"
                  disabled={securityDesc === sec_record}
                  onClick={() => act('sec_record', { securityDesc })}
                >
                  保存
                </Button>
                <Button
                  icon="times"
                  onClick={() => setSecurityDesc(sec_record)}
                >
                  重置
                </Button>
              </Box>
            }
          >
            <TextArea
              fluid
              height="100px"
              maxLength={1024}
              value={securityDesc}
              expensive
              onChange={setSecurityDesc}
            />
          </Section>
        </Stack.Item>
        <Stack.Item grow>
          <Section
            title="利用记录"
            buttons={
              <Box>
                <Button
                  icon="save"
                  disabled={exploitsDesc === exploit_record}
                  onClick={() => act('exploit_record', { exploitsDesc })}
                >
                  保存
                </Button>
                <Button
                  icon="times"
                  onClick={() => setExploitsDesc(exploit_record)}
                >
                  重置
                </Button>
              </Box>
            }
          >
            <TextArea
              fluid
              height="100px"
              maxLength={1024}
              value={exploitsDesc}
              expensive
              onChange={setExploitsDesc}
            />
          </Section>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
