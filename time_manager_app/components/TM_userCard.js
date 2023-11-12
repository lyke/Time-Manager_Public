import {StyleSheet, Text, View} from "react-native";
import {useContext, useEffect, useState} from "react";
import {Context} from "./TM_ContextProvider";
import commonStyles from "./commonStyles";

export default function TM_userCard({user}) {
    const context = useContext(Context)

    const [timeCredit, setTimeCredit] = useState(0)

    useEffect(() => {
        const getTimeCredit = async () => {
            const url = context.baseUri + "/users/time_credit/" + user.id;
            const response = await fetch(url, {
                headers: { Authorization: context.token }
            });
            const data = await response.json();
            const timeCreditInHour = data.time_credit_in_minutes / 60
            setTimeCredit(timeCreditInHour);
        };

        getTimeCredit();
    }, [context.token])

    return (
        user ?
        <View style={[commonStyles.box, styles.boxOverride]}>
            <View style={styles.container}>
                <View>
                    <Text style={[commonStyles.title, styles.textCentered]}> {user.firstname+" "+user.lastname} </Text>
                    <Text style={styles.textCentered}> role : {" "+user.role} </Text>
                </View>
                <View style={styles.rightPart}>
                    <Text> Time credit </Text>
                    {timeCredit >= 0 ?
                        <Text style={{color: "green"}}> + {timeCredit.toFixed(1)} h</Text>
                        : <Text style={{color: "red"}}> {timeCredit.toFixed(1)} h</Text>
                    }
                </View>
            </View>
        </View>
            :
            <></>
    )
}

const styles = StyleSheet.create({
    boxOverride: {
        width: '90%',
        alignSelf: "center",
        marginBottom: "5%",
    },
    container: {
        display: "flex",
        flexDirection: "row",
        width: "100%",
        justifyContent: "space-evenly",
        paddingVertical: "3%",
    },
    rightPart: {
        paddingLeft: "2%",
        justifyContent: "center",
        alignItems: "center",
    },
    textCentered:{
        textAlign: "center",
    },
})
