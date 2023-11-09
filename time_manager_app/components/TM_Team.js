import {ScrollView, StyleSheet, Text} from "react-native";
import TM_container from "./TM_container";
import TM_userCard from "./TM_userCard";
import commonStyles from "./commonStyles";

export default function TM_Team({id, name}) {

    return (
        <TM_container>
            <Text style={[commonStyles.box, styles.boxOverride, commonStyles.title]}> Team : {name} </Text>
            <ScrollView style={styles.scrollView}>
                <TM_userCard
                    user={{
                        id: "c9a3bbfe-3721-4adf-8f8a-cc88443bf880",
                        role: "super_manager",
                        password: "bob",
                        teams: [],
                        email: "bob.smith@gmail.com",
                        firstname: "bob",
                        lastname: "smith"
                    }}
                />
                <TM_userCard
                    user={{
                        id: "c9a3bbfe-3721-4adf-8f8a-cc88443bf880",
                        role: "super_manager",
                        password: "bob",
                        teams: [],
                        email: "bob.smith@gmail.com",
                        firstname: "bob",
                        lastname: "smith"
                    }}
                />
                <TM_userCard
                    user={{
                        id: "c9a3bbfe-3721-4adf-8f8a-cc88443bf880",
                        role: "super_manager",
                        password: "bob",
                        teams: [],
                        email: "bob.smith@gmail.com",
                        firstname: "bob",
                        lastname: "smith"
                    }}
                />
                <TM_userCard
                    user={{
                        id: "c9a3bbfe-3721-4adf-8f8a-cc88443bf880",
                        role: "super_manager",
                        password: "bob",
                        teams: [],
                        email: "bob.smith@gmail.com",
                        firstname: "bob",
                        lastname: "smith"
                    }}
                />
                <TM_userCard
                    user={{
                        id: "c9a3bbfe-3721-4adf-8f8a-cc88443bf880",
                        role: "super_manager",
                        password: "bob",
                        teams: [],
                        email: "bob.smith@gmail.com",
                        firstname: "bob",
                        lastname: "smith"
                    }}
                />
                <TM_userCard
                    user={{
                        id: "c9a3bbfe-3721-4adf-8f8a-cc88443bf880",
                        role: "super_manager",
                        password: "bob",
                        teams: [],
                        email: "bob.smith@gmail.com",
                        firstname: "bob",
                        lastname: "smith"
                    }}
                />
                <TM_userCard
                    user={{
                        id: "c9a3bbfe-3721-4adf-8f8a-cc88443bf880",
                        role: "super_manager",
                        password: "bob",
                        teams: [],
                        email: "bob.smith@gmail.com",
                        firstname: "bob",
                        lastname: "smith"
                    }}
                />

                <TM_userCard
                    user={{
                        id: "c9a3bbfe-3721-4adf-8f8a-cc88443bf880",
                        role: "super_manager",
                        password: "bob",
                        teams: [],
                        email: "bob.smith@gmail.com",
                        firstname: "bob",
                        lastname: "smith"
                    }}
                />
                <TM_userCard
                    user={{
                        id: "c9a3bbfe-3721-4adf-8f8a-cc88443bf880",
                        role: "super_manager",
                        password: "bob",
                        teams: [],
                        email: "bob.smith@gmail.com",
                        firstname: "bob",
                        lastname: "smith"
                    }}
                />
                <TM_userCard
                    user={{
                        id: "c9a3bbfe-3721-4adf-8f8a-cc88443bf880",
                        role: "super_manager",
                        password: "bob",
                        teams: [],
                        email: "bob.smith@gmail.com",
                        firstname: "bob",
                        lastname: "smith"
                    }}
                />
                <TM_userCard
                    user={{
                        id: "c9a3bbfe-3721-4adf-8f8a-cc88443bf880",
                        role: "super_manager",
                        password: "bob",
                        teams: [],
                        email: "bob.smith@gmail.com",
                        firstname: "bob",
                        lastname: "smith"
                    }}
                />
                <TM_userCard
                    user={{
                        id: "c9a3bbfe-3721-4adf-8f8a-cc88443bf880",
                        role: "super_manager",
                        password: "bob",
                        teams: [],
                        email: "bob.smith@gmail.com",
                        firstname: "bob",
                        lastname: "smith"
                    }}
                />
                <TM_userCard
                    user={{
                        id: "c9a3bbfe-3721-4adf-8f8a-cc88443bf880",
                        role: "super_manager",
                        password: "bob",
                        teams: [],
                        email: "bob.smith@gmail.com",
                        firstname: "bob",
                        lastname: "smith"
                    }}
                />
            </ScrollView>
        </TM_container>
    )
}

const styles = StyleSheet.create({
    boxOverride :{
        width: "auto",
        marginTop: "3%"
    },
    scrollView: {
        width: "100%",
        height: "100%",
        paddingVertical: "5%",
    }
})
