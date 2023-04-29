import React, { useState, useEffect } from 'react';
import { Box, NativeBaseProvider, Text } from 'native-base';
import * as Progress from 'react-native-progress';

const TestA = () => {
  const [progress, setProgress] = useState(0);

  useEffect(() => {
    // Cập nhật giá trị progress mỗi 500ms
    const interval = setInterval(() => {
      setProgress((prevProgress) => {
        if (prevProgress >= 1) {
          clearInterval(interval);
          return 1;
        }
        return prevProgress + 0.01;
      });
    }, 50);
    return () => clearInterval(interval);
  }, []);

  return (
    <NativeBaseProvider>
      <Box>
        <Text>This is TestA</Text>
        <Progress.Bar progress={progress} width={null} color={'purple'} />
      </Box>
    </NativeBaseProvider>
  );
};

export default TestA;
