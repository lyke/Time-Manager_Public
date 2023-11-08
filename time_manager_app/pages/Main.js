// In App.js in a new project

import * as React from 'react';
import {createBottomTabNavigator} from "@react-navigation/bottom-tabs";
import Login from "./Login";
import Register from "./Register";
import Dashboard from "./Dashboard";
import MyTeams from "./MyTeams";

const Tab = createBottomTabNavigator()

export default function Main() {
    return (
        <Tab.Navigator>
            {}
            <Tab.Screen name="Login" component={Login} options={{headerShown: false}}/>
            <Tab.Screen name="Register" component={Register} options={{headerShown: false}}/>
            <Tab.Screen name="Dashboard" component={Dashboard} options={{headerShown: false}}/>
            <Tab.Screen name="My Teams" component={MyTeams} options={{headerShown: false}}/>
        </Tab.Navigator>

    );
}
