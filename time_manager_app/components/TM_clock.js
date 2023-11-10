import {Pressable, StyleSheet, Text, View} from "react-native";
import {useContext, useEffect, useState} from "react";
import {Context} from "./TM_ContextProvider";
import commonStyles from "./commonStyles";

export default function TM_clock() {
    const context = useContext(Context)

    const [timer, setTimer] = useState("Clock in")
    const [clockoutText, setClockoutText] = useState("")
    const [clockedIn, setClockedIn] = useState(false)
    const [hasAlreadyClockedOut, setHasAlreadyClockedOut] = useState(false)
    const [timerInterval, setTimerInterval] = useState(null)

    //called only once when the component is mounted
    useEffect(() => {
        launchTimerIfAlreadyClockIn()
    }, [])

    async function launchTimerIfAlreadyClockIn() {
        const lastClock = await context.getLastClock()
        if (lastClock === null) return

        const arrivaleTime = new Date(lastClock.time)
        const elapsedTimeInMiliSec = (Date.now() - arrivaleTime.getTime())
        if (lastClock.status === false){
            setHasAlreadyClockedOut(true)
            setClockoutText("Already clocked out today")
            setTimer(formatMilisecInHMS(elapsedTimeInMiliSec))
            context.setMsTimeSinceLastClockIn(elapsedTimeInMiliSec)
        } else {
            setClockedIn(true)
            launchTimer(elapsedTimeInMiliSec)
        }
    }

    // this interval add one second every second
    function launchTimer(elapsedTimeInMiliSeconds) {
        setTimer(formatMilisecInHMS(elapsedTimeInMiliSeconds))
        setClockoutText("Clock out")

        setTimerInterval(setInterval(() => {
            context.setMsTimeSinceLastClockIn(elapsedTimeInMiliSeconds)
            setTimer(formatMilisecInHMS(elapsedTimeInMiliSeconds))
                elapsedTimeInMiliSeconds += 1000
            }, 1000)
        )
    }

    const stopTimer = () => {
        setClockoutText("Clocked out")
        clearInterval(timerInterval)
    }

    function createClockNow() {
        const body = {
            clock: {
                time: getUtcDate(new Date(Date.now())),
                fk_user: context.user.id
            }
        }

        fetch(context.baseUri + "/clocks", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                Authorization: context.token
            },
            body: JSON.stringify(body)
        }).catch(e => {/*ignore*/
        })
    }

    function clockIn() {
        setClockedIn(true)
        launchTimer(0)
        createClockNow()
    }

    function clockOut() {
        stopTimer()
        setClockedIn(false)
        createClockNow()
    }

    return (
        <View style={[commonStyles.box, styles.boxOverride]}>
            <Pressable
                style={styles.clock}
                onPress={ hasAlreadyClockedOut ? null : clockedIn ? clockOut : clockIn}
            >
                <Text style={[commonStyles.buttonText, styles.buttonTexteOverride]}> {timer} </Text>
                {clockoutText === "" ? null : <Text style={[commonStyles.buttonText, styles.textCenter]}> {clockoutText} </Text>}
            </Pressable>
        </View>
    )
}

function formatNumber(number) {
    return number < 10 ? "0" + number : number
}

function formatMilisecInHMS(TimeInMiliSeconds) {
    const dateForDisplaying = new Date(TimeInMiliSeconds)
    dateForDisplaying.setHours(dateForDisplaying.getHours() - 1)
    const hours = formatNumber(dateForDisplaying.getHours())
    const minutes = formatNumber(dateForDisplaying.getMinutes())
    const seconds = formatNumber(dateForDisplaying.getSeconds())
    return hours + " : " + minutes + " : " + seconds
}

function getUtcDate(date) {
    date.setHours(date.getHours() + 1)
    return date
}

const styles = StyleSheet.create({
    boxOverride: {
        width: '90%',
    },
    clock: {
        width: 170,
        height: 170,
        borderRadius: 65,
        backgroundColor: '#ccc',
        marginTop: '4%',
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
    },
    buttonTexteOverride: {
        fontSize: 22,
        marginBottom: "4%"
    },
    textCenter: {
        textAlign: "center",
    }
});
