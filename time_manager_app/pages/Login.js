import {StatusBar} from 'expo-status-bar';
import {Pressable, StyleSheet, Text, View} from 'react-native';
import {useContext, useState} from "react";
import TM_RequiredInput from "../components/TM_RequiredInput";
import TM_Modal from "../components/TM_Modal";
import {Context} from "../components/TM_ContextProvider";

export default function Login() {
    const context = useContext(Context)

    const [modalVisible, setModalVisible] = useState(false)
    const [modalTextError, setModalTextError] = useState("")

    const [mail, setMail] = useState('')
    const [pwd, setPwd] = useState('')

    const [mailIsValid, setMailIsValid] = useState(false)
    const [pwdIsValid, setPwdIsValid] = useState(false)


    const login = async () => {
        if (!validate()) return

        const body = {
            email: mail,
            password: pwd
        }
        try {
            const response = await fetch(context.baseUri + "/login", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(body)
            })
            if (response.status !== 200) {
                setModalTextError("Erreur d'identifiants.\n\nConnexion impossible")
                setModalVisible(true)
                return
            }

            const data = await response.json()
            context.setToken(data.token)

            const idUser = data.user_id
            const userResponse = await fetch(context.baseUri + "/users/" + idUser)
            context.setUser((await userResponse.json()).data)
        } catch (error) {
            setModalTextError("une erreur est survenue lors de la connection au serveur.\n\n veuillez réessayer plus tard")
            setModalVisible(true)
        }

    }

    const validate = () => {
        if (!mailIsValid) return false
        if (!pwdIsValid) return false

        return true
    }

    return (
        <View style={styles.container}>
            <TM_Modal
                text={modalTextError}
                modalVisible={modalVisible}
                setModalVisible={setModalVisible}
            />
            <View style={styles.form}>
                <Text style={styles.title}>Log In</Text>
                <TM_RequiredInput
                    value={mail}
                    onChangeText={setMail}
                    setIsValide={setMailIsValid}
                    title={"mail"}
                    isMail
                />
                <TM_RequiredInput
                    value={pwd}
                    onChangeText={setPwd}
                    setIsValide={setPwdIsValid}
                    title={"password"}
                    isPwd
                />

                <View style={styles.buttonContainer}>
                    <Pressable
                        style={styles.button}
                        onPress={login}
                    >
                        <Text
                            style={styles.buttonText}
                        > {"Log In"}</Text>
                    </Pressable>
                    <Pressable
                        style={styles.button}
                        onPress={() => context.goToPages.goToRegister()}
                    >
                        <Text style={styles.buttonText}> {"Go to register"}</Text>
                    </Pressable>
                </View>
            </View>

            <StatusBar style="auto"/>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'blue',
        alignItems: 'center',
        justifyContent: 'center',
    },
    form: {
        backgroundColor: "white",
        width: "80%",
        maxWidth: 600,
        alignItems: 'center',
        justifyContent: 'center',
        padding: "3%"
    },
    title: {
        fontSize: 20,
        fontWeight: "bold",
        marginBottom: "6%",
    },
    input: {
        width: '90%',
        height: 40,
        borderWidth: 1,
        borderColor: '#ccc',
        borderRadius: 5,
        marginBottom: "5%",
        paddingHorizontal: 10,
    },
    buttonContainer: {
        display: "flex",
        flexDirection: "row",
        justifyContent: "space-evenly",
        width: "100%"
    },
    button: {
        backgroundColor: 'blue',
        paddingHorizontal: 20,
        paddingVertical: 10,
        borderRadius: 5,
        marginTop: 10,
    },
    buttonText: {
        color: 'white',
        fontSize: 16,
        fontWeight: 'bold',
    },
});
