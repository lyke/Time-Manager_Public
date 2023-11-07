// In App.js in a new project

import * as React from 'react';
import {NavigationContainer} from '@react-navigation/native';
import {createNativeStackNavigator} from '@react-navigation/native-stack';

import {TM_ContextProvider} from "./components/TM_ContextProvider";
import Register from "./pages/Register";
import Login from "./pages/Login";
import Dashboard from "./pages/Dashboard";

const Stack = createNativeStackNavigator();

function App() {
    return (
        <NavigationContainer>
            <TM_ContextProvider>
                <Stack.Navigator>
                    <Stack.Screen name="Login" component={Login} options={{headerShown: false}}/>
                    <Stack.Screen name="Register" component={Register} options={{headerShown: false}}/>
                    <Stack.Screen name="Dashboard" component={Dashboard} options={{headerShown: false}}/>
                </Stack.Navigator>
            </TM_ContextProvider>
        </NavigationContainer>
    );
}

export default App;
