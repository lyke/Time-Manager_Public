import {Animated, StyleSheet, View} from "react-native";
import React, {useContext, useEffect, useState} from "react";
import {Context} from "./TM_ContextProvider";
import commonStyles from "./commonStyles";

export default function TM_dailyHourCount() {
    const {msTimeSinceLastClockIn} = useContext(Context)
    const [percentageOfTheDay, setPercentageOfTheDay] = useState("0%")

    useEffect(() => {
        calcuPercentage()
    }, [msTimeSinceLastClockIn])

    function calcuPercentage(){
        const msInHours = msTimeSinceLastClockIn / 3600000
        const percentage = (msInHours * 100) / 7
        setPercentageOfTheDay(percentage + "%")
    }

    return (
        <View style={[commonStyles.box, styles.boxOverride]}>
            <View style={styles.progressBar}>
                <Animated.View
                    style={[StyleSheet.absoluteFill, {backgroundColor: "#8BED4F", width: percentageOfTheDay}]}/>
            </View>
        </View>
    )
}

const styles = StyleSheet.create({
    boxOverride: {
        width: '90%',
    },
    progressBar: {
        height: 20,
        flexDirection: "row",
        width: '100%',
        backgroundColor: 'white',
        borderColor: '#000',
        borderWidth: 2,
        borderRadius: 5
    }
});
