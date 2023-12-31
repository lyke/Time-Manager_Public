import {StyleSheet, Text, View} from "react-native";
import {useContext, useState} from "react";
import {Context} from "./TM_ContextProvider";
import commonStyles from "./commonStyles";

export default function TM_totalHourCount() {
    const context = useContext(Context)
    const [totalCount, setTotalCount] = useState(0)

    useState( async () => {
        const url = context.baseUri+"/users/time_credit/"+context.user.id
        const response = await fetch(url, {
            headers:{ Authorization: context.token }
        })
        const data = await response.json()
        setTotalCount(data.time_credit_in_minutes / 60)
    }, [])

    function getTotalCountText(){
        if (totalCount > 0){
            return "vous avez des heures à récupérer : "
        }
        if (totalCount <0 ){
            return "vous n'avez pas fait toutes vos heures : "
        }
        return "vous êtes parfaitement à jour sur vos heures ! "
    }

    return (
        <View style={[commonStyles.box, styles.boxOverride]}>
            <View style={styles.textTotalCount}>
                <Text> {getTotalCountText()} </Text>
                { totalCount === 0 ? null : <Text style={{ color: totalCount >= 0 ? "green" : "red" }}> {totalCount.toFixed(1)+" "}h </Text>}
            </View>
        </View>
    )
}

const styles = StyleSheet.create({
    boxOverride: {
        width: '90%',
    },
    textTotalCount: {
        display: "flex",
        flexDirection: "row"
    }
});
