import {Text} from "react-native";
import {useContext} from "react";
import {Context} from "../components/TM_ContextProvider";

export default function Dashboard() {
    const {user} = useContext(Context)

    return (
        <Text>
            Welcome to the Dashboard {user.firstname} {user.lastname}
        </Text>
    )
}
