import {StyleSheet, Text, View} from "react-native";
import {useContext, useState} from "react";
import {Context} from "./TM_ContextProvider";
import commonStyles from "./commonStyles";

export default function TM_user({user}) {
    const context = useContext(Context)

    const [timeCredit, setTimeCredit] = useState(0)

    useState(async () => {
        const fetchData = async () => {
            const url = context.baseUri + "/users/time_credit/" + user.id;
            const response = await fetch(url, {
                headers: { Authorization: context.token }
            });
            const data = await response.json();
            setTimeCredit(data.time_credit_in_minutes);
        };

        fetchData();
    }, [user, context.token])

    return (
        <View style={[commonStyles.box, styles.boxOverride]}>
            <View style={styles.container}>
                <View>
                    <Text> {user.firstname+" "+user.lastname} </Text>
                    <Text> role : {" "+user.role} </Text>
                </View>
                <View style={styles.rightPart}>
                    <Text> Time credit </Text>
                    {timeCredit >= 0 ?
                        <Text style={{color: "green"}}> + {timeCredit} h</Text>
                        : <Text style={{color: "red"}}> {timeCredit} h</Text>
                    }
                </View>
            </View>
        </View>
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
        padding: "2%",
    },
    rightPart: {
        borderLeftColor: "#ccc"
    }
});
