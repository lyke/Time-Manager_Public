import TM_Team from "../components/TM_Team";
import {createMaterialTopTabNavigator} from "@react-navigation/material-top-tabs";

const Tab = createMaterialTopTabNavigator()

export default function TM_MyTeams() {

    return (
            <Tab.Navigator>
                <Tab.Screen name="Home" component={() => <TM_Team id={"ba7158b0-650c-43a5-94e4-6120c968d9d5"} name={"open It"} /> } />
                <Tab.Screen name="Settings" component={() => <TM_Team id={"495efb47-3e24-4231-8fee-1d213bd9b589"} name={"Epitech"} />} />
            </Tab.Navigator>
    )
}
