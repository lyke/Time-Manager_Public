import {Animated, ImageBackground, StyleSheet, View} from "react-native";
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
                <Animated.View style={[StyleSheet.absoluteFill, {width: percentageOfTheDay, maxWidth: "100%"}]}>
                    <ImageBackground source={ require("../assets/gradiant.png") } style={StyleSheet.absoluteFill}>
                    </ImageBackground>
                </Animated.View>
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
