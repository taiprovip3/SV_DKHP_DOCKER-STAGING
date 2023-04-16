import React from 'react';
import { NativeBaseProvider, Box, ScrollView, Image, HStack, Text, IconButton, Center, Button, Icon, Pressable } from 'native-base';
import { AntDesign } from '@expo/vector-icons';
import { FontAwesome } from '@expo/vector-icons';
import { MyData } from './Context';
import Toast from 'react-native-toast-message';

export default function Productpage({ navigation }) {

  const { fruits, carts } = React.useContext(MyData);
  const [quantity, setQuantity] = React.useState(1);

  const handleAddToCart = (o) => {
    if(quantity <= 0) {
        Toast.show({
            type: 'error',
            text1: 'Quantity selected must > 0',
            text2: 'Please try again!'
        });
        return;
    }
    Toast.show({
        type: 'success',
        text1: 'Added product to your carts',
        text2: 'Let check it out...'
    });
    fruits.push(o);
  };

  return (
    <NativeBaseProvider>
    <Box zIndex="1"><Toast position='top' bottomOffset={20} /></Box>
        <Box flex="1">
            <ScrollView>


            <Box>
                {
                    fruits.map(o => {
                        return <Pressable key={Math.random()} onPress={() => navigation.navigate("Detailpage", {item: o})}>
                            <Box bg="white" p="3" borderBottomColor="gray.400" borderBottomWidth="1">
                                <HStack alignItems="center">
                                    <Box>
                                        <Center>
                                            <Image source={o.image} alt="fruit" size={45} borderRadius={150} />
                                            <HStack justifyContent="center" alignItems="center">
                                                <IconButton icon={<AntDesign name="minussquareo" size={24} color="black" />} onPress={() => setQuantity(prev => prev - 1)}/>
                                                <Text color="success.500" fontWeight="bold">{quantity}kg</Text>
                                                <IconButton icon={<AntDesign name="plussquareo" size={24} color="black" />} onPress={() => setQuantity(prev => prev + 1)} />
                                            </HStack>
                                        </Center>
                                    </Box>
                                    <Box flex="1">
                                        <Text>{o.name}</Text>
                                        <Text color="success.500">${o.price} <Text strikeThrough color="muted.400">$14.2</Text></Text>
                                        <Text>{o.description}</Text>
                                    </Box>
                                    <Box>
                                        <Button bg="success.600"
                                        endIcon={<Icon as={<FontAwesome name="cart-plus" size={24} color="black" />} name="cloud-download-outline" size="sm" />}
                                        onPress={() => handleAddToCart(o)}
                                        />
                                    </Box>
                                </HStack>
                            </Box>
                        </Pressable>
                    })
                }
                {/* 1Item */}
                <Box bg="white" p="3">
                    <HStack alignItems="center">
                        <Box>
                            <Center>
                                <Image source={require("./assets/bananas.png")} alt="fruit" size={45} borderRadius={150} />
                                <HStack justifyContent="center" alignItems="center">
                                    <IconButton icon={<AntDesign name="minussquareo" size={24} color="black" />} onPress={() => setQuantity(prev => prev - 1)}/>
                                    <Text color="success.500" fontWeight="bold">{quantity}kg</Text>
                                    <IconButton icon={<AntDesign name="plussquareo" size={24} color="black" />} onPress={() => setQuantity(prev => prev + 1)} />
                                </HStack>
                            </Center>
                        </Box>
                        <Box flex="1">
                            <Text>Sweet Apple red peal</Text>
                            <Text color="success.500">$12.3 <Text strikeThrough color="muted.400">$14.2</Text></Text>
                            <Text>Good for eating!</Text>
                        </Box>
                        <Box>
                            <Button bg="success.600"
                            endIcon={<Icon as={<FontAwesome name="cart-plus" size={24} color="black" />} name="cloud-download-outline" size="sm" />}
                             />
                        </Box>
                    </HStack>
                </Box>
            </Box>


            </ScrollView>
        </Box>
    </NativeBaseProvider>
  );
}