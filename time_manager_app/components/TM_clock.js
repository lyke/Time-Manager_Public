import {Pressable, StyleSheet, Text, TextInput, View} from "react-native";
import {useContext, useEffect, useState} from "react";
import {Context} from "./TM_ContextProvider";
import commonStyles from "./commonStyles";

export default function TM_clock() {
    const context = useContext(Context)

    const [timer, setTimer] = useState("Clock in")
    const [clockoutText, setClockoutText] = useState("")
    const [clockedIn, setClockedIn] = useState(false)

    //called only once when the component is mounted
    useEffect( () => {launchTimerIfAlreadyClockIn()}, [] )

    async function launchTimerIfAlreadyClockIn() {
        const lastClockIn = await context.getLastClockIn()
        if (lastClockIn !== null) {
            setClockedIn( true)
            const arrivaleTime = new Date(lastClockIn.time)
            arrivaleTime.setHours( arrivaleTime.getHours() + 1 )
            const elapsedTimeInMiliSec = ( Date.now() - arrivaleTime.getTime() )
            launchTimer(elapsedTimeInMiliSec)
        }
    }

    let timerInterval
    // this interval add one second every second
    function launchTimer(elapsedTimeInMiliSeconds) {
        setTimer(formatMilisecInHMS(elapsedTimeInMiliSeconds))
        setClockoutText("Clock out")

        timerInterval = setInterval(() => {
                setTimer(formatMilisecInHMS(elapsedTimeInMiliSeconds))
                elapsedTimeInMiliSeconds += 1000
            }, 1000)
        }

    const stopTimer = () => {
        setClockoutText("Clocked out")
        clearInterval(timerInterval)
    }

    function createClockNow(){
        const body = {
            clock: {
                time: new Date(Date.now()).toISOString(),
                fk_user: context.user.id
            }
        }

        fetch(context.baseUri+"/clocks", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                Authorization: context.token
            },
            body: JSON.stringify(body)
        })
    }

    function clockIn() {
        setClockedIn(true)
        createClockNow()
    }

    function clockOut(){
        stopTimer()
        setClockedIn(false)
        createClockNow()
        launchTimer(0)
    }

    return (
        <View style={[commonStyles.box, styles.boxOverride]} >
            <Pressable
                style={styles.clock}
                onPress={ clockedIn ? clockOut : clockIn}
            >
                <Text style={[commonStyles.buttonText, styles.buttonTexteOverride]}> {timer} </Text>
                <Text style={commonStyles.buttonText}> { clockoutText } </Text>
            </Pressable>
        </View>
    )
}

function formatNumber(number){
    return number < 10 ? "0" + number : number
}

function formatMilisecInHMS(TimeInMiliSeconds){
    const dateForDisplaying = new Date(TimeInMiliSeconds)
    const hours = formatNumber(dateForDisplaying.getHours())
    const minutes = formatNumber(dateForDisplaying.getMinutes())
    const seconds = formatNumber(dateForDisplaying.getSeconds())
    return hours +" : " + minutes + " : " + seconds
}

const styles = StyleSheet.create({
    container: {
        width: '100%',
    },
    boxOverride: {
        width: '90%',
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
