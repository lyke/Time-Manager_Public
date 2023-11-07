import {StyleSheet, Text, View} from "react-native";
import {useContext} from "react";
import {Context} from "../components/TM_ContextProvider";
import TM_clock from "../components/TM_clock";

export default function Dashboard() {
    const {user} = useContext(Context)

    return (
        <View style={styles.container}>
            <TM_clock/>
        </View>
    )
}

const styles = StyleSheet.create({
    container: {
        width: '100%',
        height: '100%',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'space-evenly',
    },
});
