// In App.js in a new project

import * as React from 'react';
import {createBottomTabNavigator} from "@react-navigation/bottom-tabs";
import Login from "./Login";
import Register from "./Register";
import Dashboard from "./Dashboard";
import TM_MyTeams from "./TM_MyTeams";
import TM_LogOut from "../components/TM_LogOut";
import {Ionicons} from "@expo/vector-icons";
import {useContext} from "react";
import {Context} from "../components/TM_ContextProvider";

const Tab = createBottomTabNavigator()

export default function Main() {
    const {user} = useContext(Context)

    return (
        <Tab.Navigator
            screenOptions={getScreenOptions}
        >
            <Tab.Screen name="Login" component={Login} options={{ headerShown: false, tabBarStyle: {display: "none"}, tabBarItemStyle: {display: "none"} }}/>
            <Tab.Screen name="Register" component={Register} options={{ headerShown: false, tabBarStyle: {display:"none"}, tabBarItemStyle: {display: "none"} }}/>
            <Tab.Screen name="Dashboard" component={Dashboard} options={{headerShown: false}}/>
            {user && user.role === "user" ? <></> : <Tab.Screen name="My Teams" component={TM_MyTeams} options={{headerShown: false}}/> }
            <Tab.Screen name="Account" component={TM_LogOut} options={{headerShown: false}}/>
        </Tab.Navigator>
    );
}

const getScreenOptions = ({ route }) => ({
    tabBarLabelPosition: "below-icon",
    tabBarIcon: ({ focused, color, size }) => {
        let iconName = "";

        switch (route.name) {
            case "Dashboard": {
                iconName = "home";
                break;
            }
            case "My Teams": {
                iconName = "people-outline";
                break;
            }
            case "Account": {
                iconName = "person-circle-outline";
                break;
            }
            default: {
                break;
            }
        }
        return <Ionicons name={iconName} size={size} color={color} />;
    }
})
