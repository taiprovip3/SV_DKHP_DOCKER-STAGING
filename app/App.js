import { NavigationContainer } from '@react-navigation/native'
import { createNativeStackNavigator } from '@react-navigation/native-stack'

import Homepage from './Components/Screens/Homepage';
import AuthenticationPage from './Components/Screens/AuthenticationPage';
import AuthProvider from './Components/Providers/AuthProvider';
import Timetable from './Components/Screens/Timetable';
import UserInfo from './Components/Screens/UserInfo';
import DkhpPage from './Components/Screens/DkhpPage';
import PaymentPage from './Components/Screens/PaymentPage';
import DebtPage from './Components/Screens/DebtPage';
import { LogBox } from 'react-native';
import RechargePage from './Components/Screens/RechargePage';
import TopupPage from './Components/Screens/TopupPage';

LogBox.ignoreLogs(['Animated: `useNativeDriver`']);

// Linking.makeUrl('/assets/hideBackButton.css').then((url) => {
//   const link = document.createElement('link');
//   link.rel = 'stylesheet';
//   link.type = 'text/css';
//   link.href = url;
//   document.head.appendChild(link);
// });

const Stack = createNativeStackNavigator();

const App = () => {
    return (
      <AuthProvider>
          <NavigationContainer>
              <Stack.Navigator>
                    <Stack.Screen
                        name='AuthenticationPage'
                        component={AuthenticationPage}
                        options={{ 
                            title: 'Xác thực', 
                            headerStyle: {
                                backgroundColor: '#dcddde',
                            },
                            headerTintColor: 'black',
                            headerTitleStyle: {
                                fontWeight: 'bold',
                            }
                        }}
                    />
                   <Stack.Screen
                        name='UserInfo'
                        component={UserInfo}
                        options={{ 
                            title: 'Thông tin', 
                            headerStyle: {
                                backgroundColor: '#dcddde',
                            },
                            headerTintColor: 'black',
                            headerTitleStyle: {
                                fontWeight: 'bold',
                            }
                        }}
                    />
                  <Stack.Screen
                        name='Homepage'
                        component={Homepage}
                        options={{ 
                            title: 'ErukaLearn', 
                            headerStyle: {
                                backgroundColor: '#dcddde',
                            },
                            headerTintColor: 'black',
                            headerTitleStyle: {
                                fontWeight: 'bold',
                            }
                        }}
                  />
                    <Stack.Screen
                            name='Timetable'
                            component={Timetable}
                            options={{ 
                                title: 'ErukaLearn', 
                                headerStyle: {
                                    backgroundColor: '#dcddde',
                                },
                                headerTintColor: 'black',
                                headerTitleStyle: {
                                    fontWeight: 'bold',
                                }
                            }}
                    />
                    <Stack.Screen
                        name='DkhpPage'
                        component={DkhpPage}
                        options={{ 
                            title: 'ErukaLearn', 
                            headerStyle: {
                                backgroundColor: '#dcddde',
                            },
                            headerTintColor: 'black',
                            headerTitleStyle: {
                                fontWeight: 'bold',
                            }
                        }}
                    />
                    <Stack.Screen
                        name='PaymentPage'
                        component={PaymentPage}
                        options={{ 
                            title: 'ErukaLearn', 
                            headerStyle: {
                                backgroundColor: '#dcddde',
                            },
                            headerTintColor: 'black',
                            headerTitleStyle: {
                                fontWeight: 'bold',
                            }
                        }}
                    />
                    <Stack.Screen
                        name='DebtPage'
                        component={DebtPage}
                        options={{ 
                            title: 'Công nợ Sinh viên', 
                            headerStyle: {
                                backgroundColor: '#dcddde',
                            },
                            headerTintColor: 'black',
                            headerTitleStyle: {
                                fontWeight: 'bold',
                            }
                        }}
                    />
                    <Stack.Screen
                        name='RechargePage'
                        component={RechargePage}
                        options={{ 
                            title: 'Nạp tiền Vào ví', 
                            headerStyle: {
                                backgroundColor: '#dcddde',
                            },
                            headerTintColor: 'black',
                            headerTitleStyle: {
                                fontWeight: 'bold',
                            }
                        }}
                    />
                    <Stack.Screen
                        name='TopupPage'
                        component={TopupPage}
                        options={{ 
                            title: 'Thanh toán Giao dịch', 
                            headerStyle: {
                                backgroundColor: '#dcddde',
                            },
                            headerTintColor: 'black',
                            headerTitleStyle: {
                                fontWeight: 'bold',
                            }
                        }}
                    />
              </Stack.Navigator>
          </NavigationContainer>
        </AuthProvider>
    )
}

export default App;