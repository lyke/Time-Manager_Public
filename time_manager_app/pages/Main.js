// In App.js in a new project

import * as React from 'react';
import {NavigationContainer} from '@react-navigation/native';
import {createBottomTabNavigator} from "@react-navigation/bottom-tabs";
import Login from "./Login";
import Register from "./Register";
import Dashboard from "./Dashboard";
import MyTeams from "./MyTeams";
import {useContext} from "react";
import {Context} from "../components/TM_ContextProvider";

const Tab = createBottomTabNavigator()

export default function Main() {
    const {token} = useContext(Context)

    return token === "" ? buildLoggedOutTabs() : buildLoggedInTabs()
}

function buildLoggedInTabs() {
    return (
        <Tab.Navigator>
            <Tab.Screen name="Dashboard" component={Dashboard} options={{headerShown: false}}/>
            <Tab.Screen name="My Teams" component={MyTeams} options={{headerShown: false}}/>
        </Tab.Navigator>
    )
}

function buildLoggedOutTabs() {
    return (
        <Tab.Navigator>
            <Tab.Screen name="Login" component={Login} options={{headerShown: false}}/>
            <Tab.Screen name="Register" component={Register} options={{headerShown: false}}/>
        </Tab.Navigator>
    )
}
