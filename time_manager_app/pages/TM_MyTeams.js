import TM_Team from "../components/TM_Team";
import {createMaterialTopTabNavigator} from "@react-navigation/material-top-tabs";
import {useContext, useState} from "react";
import {Context} from "../components/TM_ContextProvider";
import TM_container from "../components/TM_container";
import {Text} from "react-native";
import commonStyles from "../components/commonStyles";

const Tab = createMaterialTopTabNavigator()

export default function TM_MyTeams() {
    const context = useContext(Context)

    const [teams, setTeams] = useState([])

    useState( async () => {
        const getAllTeams = async () => {
            const url = context.baseUri + "/teams"
            const response = await fetch(url, {
                headers: {Authorization: context.token}
            })
            const data = await response.json()
            setTeams(data.data)
        }

        setTeams(context.user.teams)
        if (context.user.role === "super_manager"){
            getAllTeams()
        }
    }, [context.user])

    return (
        teams.length === 0 ?
            <TM_container>
                <Text style={[commonStyles.box, commonStyles.title]}>
                    You are not currently in a team !
                </Text>
            </TM_container>
            :
        <Tab.Navigator>
            {teams.map((team, index) => (
                <Tab.Screen
                    key={index}
                    name={team.name}
                    component={() => <TM_Team id={team.id} name={team.name} />}
                />
            ))}
        </Tab.Navigator>
    )
}
