import { AnimatedNumber, Box } from 'tgui-core/components';

export const BeakerContents = (props) => {
  const { beakerLoaded, beakerContents } = props;
  return (
    <Box>
      {(!beakerLoaded && <Box color="label">未装载烧杯.</Box>) ||
        (beakerContents.length === 0 && (
          <Box color="label">烧杯是空的.</Box>
        ))}
      {beakerContents.map((chemical) => (
        <Box key={chemical.name} color="label">
          <AnimatedNumber initial={0} value={chemical.volume} />
          {' units of ' + chemical.name}
        </Box>
      ))}
    </Box>
  );
};
