import TM_Team from "../components/TM_Team";
import {createMaterialTopTabNavigator} from "@react-navigation/material-top-tabs";
import {useContext} from "react";
import {Context} from "../components/TM_ContextProvider";
import TM_container from "../components/TM_container";
import {Text} from "react-native";
import commonStyles from "../components/commonStyles";

const Tab = createMaterialTopTabNavigator()

export default function TM_MyTeams() {
    const {userTeams} = useContext(Context)

    return (
        ! userTeams || userTeams.length === 0 ?
            <TM_container>
                <Text style={[commonStyles.box, commonStyles.title]}>
                    You are not currently in a team !
                </Text>
            </TM_container>
            :
        <Tab.Navigator>
            {userTeams.map((team, index) => (
                <Tab.Screen
                    key={index}
                    name={team.name}
                    children={() => <TM_Team id={team.id} name={team.name} />}
                />
            ))}
        </Tab.Navigator>
    )
}
