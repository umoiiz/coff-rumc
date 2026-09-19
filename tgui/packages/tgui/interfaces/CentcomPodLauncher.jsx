import { Button, LabeledList, NoticeBox, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

// This is more or less a direct port from old tgui, with some slight
// text cleanup. But yes, it actually worked like this.
export const CentcomPodLauncher = (props) => {
  const { act, data } = useBackend();
  return (
    <Window title="Config/Launch Supplypod" width={700} height={700}>
      <Window.Content>
        <NoticeBox>
          要使用此功能,只需在五个
          中央司令部补给舱舱位之一中生成您想要的原子.舱位中的物品随后将被发射到
          您的补给舱内,一次一个地块!您可以选择使用
          以下按钮来配置补给舱的行为.
        </NoticeBox>
        <Section title="中央司令部补给舱自定义">
          <LabeledList>
            <LabeledList.Item label="补给舱位">
              <Button
                content="舱位 #1"
                selected={data.bayNumber === 1}
                onClick={() => act('bay1')}
              />
              <Button
                content="舱位 #2"
                selected={data.bayNumber === 2}
                onClick={() => act('bay2')}
              />
              <Button
                content="舱位 #3"
                selected={data.bayNumber === 3}
                onClick={() => act('bay3')}
              />
              <Button
                content="舱位 #4"
                selected={data.bayNumber === 4}
                onClick={() => act('bay4')}
              />
              <Button
                content="紧急响应小组舱位"
                selected={data.bayNumber === 5}
                tooltip={`
                  This bay is located on the western edge of CentCom. Its the
                  glass room directly west of where ERT spawn, and south of the
                  CentCom ferry. Useful for launching ERT/Deathsquads/etc. onto
                  the station via drop pods.
                `}
                onClick={() => act('bay5')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="传送至">
              <Button
                content={data.bay}
                onClick={() => act('teleportCentcom')}
              />
              <Button
                content={data.oldArea ? data.oldArea : 'Where you were'}
                disabled={!data.oldArea}
                onClick={() => act('teleportBack')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="克隆模式">
              <Button
                content="发射克隆体"
                selected={data.launchClone}
                tooltip={`
                  Choosing this will create a duplicate of the item to be
                  launched in Centcom, allowing you to send one type of item
                  multiple times. Either way, the atoms are forceMoved into
                  the supplypod after it lands (but before it opens).
                `}
                onClick={() => act('launchClone')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="发射方式">
              <Button
                content="有序"
                selected={data.launchChoice === 1}
                tooltip={`
                  Instead of launching everything in the bay at once, this
                  will "scan" things (one turf-full at a time) in order, left
                  to right and top to bottom. undoing will reset the "scanner"
                  to the top-leftmost position.
                `}
                onClick={() => act('launchOrdered')}
              />
              <Button
                content="随机"
                selected={data.launchChoice === 2}
                tooltip={`
                  Instead of launching everything in the bay at once, this
                  will launch one random turf of items at a time.
                `}
                onClick={() => act('launchRandom')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="爆炸">
              <Button
                content="自定义大小"
                selected={data.explosionChoice === 1}
                tooltip={`
                  This will cause an explosion of whatever size you like
                  (including flame range) to occur as soon as the supplypod
                  lands. Dont worry, supply-pods are explosion-proof!
                `}
                onClick={() => act('explosionCustom')}
              />
              <Button
                content="管理员巴士"
                selected={data.explosionChoice === 2}
                tooltip={`
                  This will cause a maxcap explosion (dependent on server
                  config) to occur as soon as the supplypod lands. Dont worry,
                  supply-pods are explosion-proof!
                `}
                onClick={() => act('explosionBus')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="伤害">
              <Button
                content="自定义伤害"
                selected={data.damageChoice === 1}
                tooltip={`
                  Anyone caught under the pod when it lands will be dealt
                  this amount of brute damage. Sucks to be them!
                `}
                onClick={() => act('damageCustom')}
              />
              <Button
                content="碎尸"
                selected={data.damageChoice === 2}
                tooltip={`
                  This will attempt to gib any mob caught under the pod when
                  it lands, as well as dealing a nice 5000 brute damage. Ya
                  know, just to be sure!
                `}
                onClick={() => act('damageGib')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="效果">
              <Button
                content="眩晕"
                selected={data.effectStun}
                tooltip={`
                  Anyone who is on the turf when the supplypod is launched
                  will be stunned until the supplypod lands. They cant get
                  away that easy!
                `}
                onClick={() => act('effectStun')}
              />
              <Button
                content="断肢"
                selected={data.effectLimb}
                tooltip={`
                  This will cause anyone caught under the pod to lose a limb,
                  excluding their head.
                `}
                onClick={() => act('effectLimb')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="移动">
              <Button
                content="蓝空间"
                selected={data.effectBluespace}
                tooltip={`
                  Gives the supplypod an advanced Bluespace Recyling Device.
                  After opening, the supplypod will be warped directly to the
                  surface of a nearby NT-designated trash planet (/r/ss13).
                `}
                onClick={() => act('effectBluespace')}
              />
              <Button
                content="隐形"
                selected={data.effectStealth}
                tooltip={`
                  This hides the red target icon from appearing when you
                  launch the supplypod. Combos well with the "Invisible"
                  style. Sneak attack, go!
                `}
                onClick={() => act('effectStealth')}
              />
              <Button
                content="安静"
                selected={data.effectQuiet}
                tooltip={`
                  This will keep the supplypod from making any sounds, except
                  for those specifically set by admins in the Sound section.
                `}
                onClick={() => act('effectQuiet')}
              />
              <Button
                content="反向模式"
                selected={data.effectReverse}
                tooltip={`
                  This pod will not send any items. Instead, after landing,
                  the supplypod will close (similar to a normal closet closing),
                  and then launch back to the right centcom bay to drop off any
                  new contents.
                `}
                onClick={() => act('effectReverse')}
              />
              <Button
                content="导弹模式"
                selected={data.effectMissile}
                tooltip={`
                  This pod will not send any items. Instead, it will immediately
                  delete after landing (Similar visually to setting openDelay
                  & departDelay to 0, but this looks nicer). Useful if you just
                  wanna fuck some shit up. Combos well with the Missile style.
                `}
                onClick={() => act('effectMissile')}
              />
              <Button
                content="任意下降角度"
                selected={data.effectCircle}
                tooltip={`
                  This will make the supplypod come in from any angle. Im not
                  sure why this feature exists, but here it is.
                `}
                onClick={() => act('effectCircle')}
              />
              <Button
                content="机枪模式"
                selected={data.effectBurst}
                tooltip={`
                  This will make each click launch 5 supplypods inaccuratly
                  around the target turf (a 3x3 area). Combos well with the
                  Missile Mode if you dont want shit lying everywhere after.
                `}
                onClick={() => act('effectBurst')}
              />
              <Button
                content="特定目标"
                selected={data.effectTarget}
                tooltip={`
                  This will make the supplypod target a specific atom, instead
                  of the mouses position. Smiting does this automatically!
                `}
                onClick={() => act('effectTarget')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="名称/描述">
              <Button
                content="自定义名称/描述"
                selected={data.effectName}
                tooltip="允许你添加自定义名称和描述."
                onClick={() => act('effectName')}
              />
              <Button
                content="警报幽灵"
                selected={data.effectAnnounce}
                tooltip={`
                  Alerts ghosts when a pod is launched. Useful if some dumb
                  shit is aboutta come outta the pod.
                `}
                onClick={() => act('effectAnnounce')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="声音">
              <Button
                content="自定义下落音效"
                selected={data.fallingSound}
                tooltip={`
                  Choose a sound to play as the pod falls. Note that for this
                  to work right you should know the exact length of the sound,
                  in seconds.
                `}
                onClick={() => act('fallSound')}
              />
              <Button
                content="自定义着陆音效"
                selected={data.landingSound}
                tooltip="选择空投舱着陆时播放的音效."
                onClick={() => act('landingSound')}
              />
              <Button
                content="自定义开启音效"
                selected={data.openingSound}
                tooltip="选择空投舱开启时播放的音效."
                onClick={() => act('openingSound')}
              />
              <Button
                content="自定义离开音效"
                selected={data.leavingSound}
                tooltip={`
                  Choose a sound to play when the pod departs (whether that be
                  delection in the case of a bluespace pod, or leaving for
                  centcom for a reversing pod).
                `}
                onClick={() => act('leavingSound')}
              />
              <Button
                content="管理员音量"
                selected={data.soundVolume}
                tooltip={`
                  Choose the volume for the sound to play at. Default values
                  are between 1 and 100, but hey, do whatever. Im a tooltip,
                  not a cop.
                `}
                onClick={() => act('soundVolume')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="计时器">
              <Button
                content="自定义下落时长"
                selected={data.fallDuration !== 4}
                tooltip={`
                  Set how long the animation for the pod falling lasts. Create
                  dramatic, slow falling pods!
                `}
                onClick={() => act('fallDuration')}
              />
              <Button
                content="自定义着陆时间"
                selected={data.landingDelay !== 20}
                tooltip={`
                  Choose the amount of time it takes for the supplypod to hit
                  the station. By default this value is 0.5 seconds.
                `}
                onClick={() => act('landingDelay')}
              />
              <Button
                content="自定义开启时间"
                selected={data.openingDelay !== 30}
                tooltip={`
                  Choose the amount of time it takes for the supplypod to open
                  after landing. Useful for giving whatevers inside the pod a
                  nice dramatic entrance! By default this value is 3 seconds.
                `}
                onClick={() => act('openingDelay')}
              />
              <Button
                content="自定义离开时间"
                selected={data.departureDelay !== 30}
                tooltip={`
                  Choose the amount of time it takes for the supplypod to leave
                  after landing. By default this value is 3 seconds.
                `}
                onClick={() => act('departureDelay')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="样式">
              {data.styles.map((style) => (
                <Button
                  key={style.id}
                  content={style[1]}
                  selected={data.styleChoice === style[3]}
                  tooltip={style[2]}
                  onClick={() => act('setstyle', { style: style[0] })}
                />
              ))}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section>
          <LabeledList>
            <LabeledList.Item
              label={data.numObjects + ' turfs in ' + data.bay}
              buttons={
                <>
                  <Button
                    content="撤销空投舱"
                    tooltip={`
                      Manually undoes the possible things to launch in the
                      pod bay.
                    `}
                    onClick={() => act('undo')}
                  />
                  <Button
                    content="进入发射模式"
                    selected={data.giveLauncher}
                    tooltip="星际战士战典称此机动为: 钢铁之雨"
                    onClick={() => act('giveLauncher')}
                  />
                  <Button
                    content="清除选定的空投舱"
                    color="bad"
                    tooltip={`
                      This will delete all objs and mobs from the selected bay.
                    `}
                    tooltipPosition="left"
                    onClick={() => act('clearBay')}
                  />
                </>
              }
            />
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
