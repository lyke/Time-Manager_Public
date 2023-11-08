import Team from "../components/Team";
import {createMaterialTopTabNavigator} from "@react-navigation/material-top-tabs";

const Tab = createMaterialTopTabNavigator()

export default function MyTeams() {

    return (
            <Tab.Navigator>
                <Tab.Screen name="Home" component={Team} />
                <Tab.Screen name="Settings" component={Team} />
            </Tab.Navigator>
    )
}
