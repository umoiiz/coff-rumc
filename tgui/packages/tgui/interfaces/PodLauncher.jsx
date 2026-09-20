import { Button, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const Crew = (props) => {
  const { act, data } = useBackend();

  return (
    <Window title="Pod Launcher" width={1000} height={700}>
      <Window.Content>
        <Section title="补给舱舱位">
          <Button
            onClick={() => act('bay', { bay: 1 })}
            disabled={data.bayNumber === 1}
          >
            1号舱位
          </Button>
          <Button
            onClick={() => act('bay', { bay: 2 })}
            disabled={data.bayNumber === 2}
          >
            2号舱位
          </Button>
          <Button
            onClick={() => act('bay', { bay: 3 })}
            disabled={data.bayNumber === 3}
          >
            3号舱位
          </Button>
          <Button
            onClick={() => act('bay', { bay: 4 })}
            disabled={data.bayNumber === 4}
          >
            4号舱位
          </Button>
          <Button
            onClick={() => act('bay', { bay: 5 })}
            disabled={data.bayNumber === 5}
          >
            5号舱位
          </Button>
        </Section>
        <Section title="传送至">
          <Button onClick={() => act('teleportCentcom')}>{data.bay}</Button>
          <Button onClick={() => act('teleportBack')} disabled={!data.oldArea}>
            {data.oldArea ? data.oldArea : 'where you were'}
          </Button>
        </Section>
        <Section title="发射克隆体">
          <Button onClick={() => act('launchClone')}>发射克隆体</Button>
        </Section>
        <Section title="一次性全部发射">
          <Button onClick={() => act('launchOrdered')}>有序</Button>
          <Button onClick={() => act('launchRandom')}>随机</Button>
        </Section>
        <Section title="爆炸">
          <Button onClick={() => act('explosionCustom')}>自定义大小</Button>
          <Button onClick={() => act('explosionBus')}>管理员巴士</Button>
        </Section>
        <Section title="伤害">
          <Button onClick={() => act('damageCustom')}>自定义伤害</Button>
          <Button onClick={() => act('damageGib')}>碎尸</Button>
        </Section>
        <Section title="伤害效果">
          <Button onClick={() => act('effectStun')}>眩晕</Button>
          <Button onClick={() => act('effectLimb')}>断肢</Button>
          <Button onClick={() => act('effectOrgans')}>摘除器官</Button>
        </Section>
        <Section title="移动效果">
          <Button onClick={() => act('effectBluespace')}>蓝空间</Button>
          <Button onClick={() => act('effectStealth')}>潜行</Button>
          <Button onClick={() => act('effectQuiet')}>静默着陆</Button>
          <Button onClick={() => act('effectReverse')}>反向模式</Button>
          <Button onClick={() => act('effectMissile')}>导弹模式</Button>
          <Button onClick={() => act('effectCircle')}>任意下降角度</Button>
          <Button onClick={() => act('effectBurst')}>机枪模式</Button>
          <Button onClick={() => act('effectTarget')}>指定目标</Button>
        </Section>
        <Section title="自定义">
          <Button onClick={() => act('effectName')}>自定义名称</Button>
          <Button onClick={() => act('effectAnnounce')}>警报幽灵</Button>
        </Section>
        <Section title="音效">
          <Button onClick={() => act('fallingSound')}>
            自定义下落音效
          </Button>
          <Button onClick={() => act('landingSound')}>
            自定义着陆音效
          </Button>
          <Button onClick={() => act('openingSound')}>
            自定义开启音效
          </Button>
          <Button onClick={() => act('leavingSound')}>
            自定义离开音效
          </Button>
          <Button onClick={() => act('soundVolume')}>管理员音效音量</Button>
        </Section>
        <Section title="延迟计时器">
          <Button onClick={() => act('fallDuration')}>
            自定义下落时长
          </Button>
          <Button onClick={() => act('landingDelay')}>
            自定义着陆时间
          </Button>
          <Button onClick={() => act('openingDelay')}>
            自定义开启时间
          </Button>
          <Button onClick={() => act('departureDelay')}>
            自定义离开时间
          </Button>
        </Section>
        <Section title="样式">
          <Button onClick={() => act('styleStandard')}>标准</Button>
          <Button onClick={() => act('styleBluespace')}>高级</Button>
          <Button onClick={() => act('styleSyndie')}>辛迪加</Button>
          <Button onClick={() => act('styleBlue')}>死亡小队</Button>
          <Button onClick={() => act('styleCult')}>邪教</Button>
          <Button onClick={() => act('styleMissile')}>导弹</Button>
          <Button onClick={() => act('styleSMissile')}>
            辛迪加导弹
          </Button>
          <Button onClick={() => act('styleBox')}>补给箱</Button>
          <Button onClick={() => act('styleHONK')}>鸣笛</Button>
          <Button onClick={() => act('styleFruit')}>水果</Button>
          <Button onClick={() => act('styleInvisible')}>隐形</Button>
          <Button onClick={() => act('styleGondola')}>贡多拉</Button>
          <Button onClick={() => act('styleSeeThrough')}>透视</Button>
        </Section>
        <Section title={'Action ' + data.numObjects + ' turfs in ' + data.bay}>
          <Button onClick={() => act('refresh')}>刷新吊舱舱位</Button>
          <Button onClick={() => act('giveLauncher')}>进入发射模式</Button>
          <Button onClick={() => act('clearBay')}>清除选定舱位</Button>
        </Section>
      </Window.Content>
    </Window>
  );
};
