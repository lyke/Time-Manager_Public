import TM_Team from "../components/TM_Team";
import {createMaterialTopTabNavigator} from "@react-navigation/material-top-tabs";

const Tab = createMaterialTopTabNavigator()

export default function TM_MyTeams() {

    return (
            <Tab.Navigator>
                <Tab.Screen name="Home" component={TM_Team} />
                <Tab.Screen name="Settings" component={TM_Team} />
            </Tab.Navigator>
    )
}
