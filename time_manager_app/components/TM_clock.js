import {Pressable, StyleSheet, Text, TextInput, View} from "react-native";
import {useContext, useEffect, useState} from "react";
import {Context} from "./TM_ContextProvider";
import commonStyles from "./commonStyles";

export default function TM_clock() {
    const context = useContext(Context)

    const [timer, setTimer] = useState("Clock in")
    const [clockoutText, setClockoutText] = useState("")

    //called only once when the component is mounted
    useEffect( () => {launchTimerIfAlreadyClockIn()}, [] )

    async function launchTimerIfAlreadyClockIn() {
        const lastClockIn = await context.getLastClockIn()
        if (lastClockIn !== null) {
            const elapsedTimeInSecond = 0
            launchTimer(elapsedTimeInSecond)
        }
    }

    let timerInterval
    function launchTimer(elapsedTimeInSeconds) {
            timerInterval = setInterval(() => {
                setTimer(elapsedTimeInSeconds)
                elapsedTimeInSeconds += 1
            }, 1000)
            setClockoutText("Clock out")
        }

    const stopTimer = () => {
        setClockoutText("Clocked out")
        clearInterval(timerInterval)
    }



    return (
        <View style={commonStyles.box} >
            <View style={styles.clock}>
                <Text style={[commonStyles.buttonText, styles.buttonTexteOverride]}> {timer} </Text>
                <Text style={commonStyles.buttonText}> { clockoutText } </Text>
            </View>
        </View>
    )
}

const styles = StyleSheet.create({
    container: {
        width: '100%',
    },
    clock: {
        width: 150,
        height: 150,
        borderRadius: 65,
        backgroundColor: '#ccc',
        marginTop: '4%',
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
    },
    buttonTexteOverride: {
        fontSize: 22
    },
});
