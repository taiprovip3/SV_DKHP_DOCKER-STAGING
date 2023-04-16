import { View, Text } from 'react-native';
import React from 'react';

export const AuthContext = React.createContext();

export default function AuthProvider({ children }){ //children là các component con được bọc

    const [currentUser, setCurrentUser] = React.useState(null);
    const [token, setToken] = React.useState("");

    React.useEffect(() => {
        console.log("Token=", token);
    },[token]);

  return (
    <AuthContext.Provider value={{ currentUser, setCurrentUser, token, setToken }}>
        {children}
    </AuthContext.Provider>
  )
};