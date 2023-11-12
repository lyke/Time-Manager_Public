import {ScrollView, StyleSheet, Text} from "react-native";
import TM_container from "./TM_container";
import TM_userCard from "./TM_userCard";
import commonStyles from "./commonStyles";
import {useContext, useEffect, useState} from "react";
import {Context} from "./TM_ContextProvider";

export default function TM_Team({id, name}) {
    const context = useContext(Context)
    const [users, setUsers] = useState([])

    useEffect(() => {
        async function getUsers() {
            const response = await fetch(context.baseUri + "/teams/" + id, {
                headers: {Authorization: context.token}
            })
            const data = (await response.json()).data
            setUsers(data.user)
        }

        getUsers()
    }, [context.token])

    return (
        !users || users.length === 0 ?
            <TM_container>
                <Text style={[commonStyles.box, commonStyles.title]}>
                    This team has no users yet
                </Text>
            </TM_container>
            :
            <TM_container>
                <Text style={[commonStyles.box, styles.boxOverride, commonStyles.title]}> Team : {name} </Text>
                <ScrollView style={styles.scrollView}>
                    {
                        users.map((user, index) => (
                            <TM_userCard
                                key={index}
                                user={user}
                            />
                        ))
                    }
                </ScrollView>
            </TM_container>
    )
}

const styles = StyleSheet.create({
    boxOverride: {
        width: "auto",
        marginTop: "3%"
    },
    scrollView: {
        width: "100%",
        height: "100%",
        paddingVertical: "5%",
    }
})
