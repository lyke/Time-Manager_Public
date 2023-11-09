import {Pressable, StyleSheet, Text, View} from "react-native";
import {useContext} from "react";
import {Context} from "./TM_ContextProvider";
import commonStyles from "./commonStyles";
import TM_container from "./TM_container";
import TM_userCard from "./TM_userCard";

export default function TM_LogOut() {
    const context = useContext(Context)

    return (
        <TM_container>
            <TM_userCard
                user={context.user}
            />
            <View style={[commonStyles.box, styles.boxOverride]}>
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

const styles = StyleSheet.create({
    boxOverride: {
        width: "90%",
    }
})
