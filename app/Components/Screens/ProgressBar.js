import { Badge } from 'native-base';

export default function ProgressBar({ progress }) {
  const badgeStyle = {
    backgroundColor: '#007aff',
    height: 10,
    width: `${progress}%`
  };

  return <Badge style={badgeStyle} />;
}