import {Pressable, Text, View} from "react-native";
import {useContext} from "react";
import {Context} from "./TM_ContextProvider";
import commonStyles from "./commonStyles";
import TM_container from "./TM_container";

export default function TM_LogOut() {
    const context = useContext(Context)

    return (
        <TM_container>
            <View style={commonStyles.box}>
                <Pressable
                    style={commonStyles.button}
                    onPress={context.logout}
                >
                    <Text style={commonStyles.buttonText}>
                        Logout
                    </Text>
                </Pressable>
            </View>
        </TM_container>
    )
}
