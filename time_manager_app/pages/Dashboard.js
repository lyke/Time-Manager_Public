import {StyleSheet, Text, View} from "react-native";
import {useContext} from "react";
import {Context} from "../components/TM_ContextProvider";
import TM_clock from "../components/TM_clock";
import TM_container from "../components/TM_container";
import TM_hourCount from "../components/TM_hourCount";

export default function Dashboard() {

    return (
        <TM_container style={styles.containerOverride}>
            <TM_clock/>
            <TM_hourCount/>
        </TM_container>
    )
}

const styles = StyleSheet.create({
    containerOverride: {
        justifyContent: "spa"
    },
});
