import {StatusBar} from 'expo-status-bar';
import {Pressable, StyleSheet, Text, View} from 'react-native';
import {useContext, useState} from "react";
import TM_RequiredInput from "../components/TM_RequiredInput";
import TM_Modal from "../components/TM_Modal";
import {Context} from "../components/TM_ContextProvider";

export default function Register() {
    const {goToPages} = useContext(Context)
    const {baseUri} = useContext(Context)

    const [modalVisible, setModalVisible] = useState(false)
    const [modalTextError, setModalTextError] = useState("")

    const [firstname, setFirstname] = useState('')
    const [lastname, setLastname] = useState('')
    const [mail, setMail] = useState('')
    const [pwd, setPwd] = useState('')

    const [firstnameIsValid, setFirstnameIsValid] = useState(false)
    const [lastnameIsValid, setLastnameIsValid] = useState(false)
    const [mailIsValid, setMailIsValid] = useState(false)
    const [pwdIsValid, setPwdIsValid] = useState(false)

    const register = async () => {
        if (!validate()) return

        const body = {
            user: {
                firstname: firstname,
                lastname: lastname,
                email: mail,
                password: pwd
            }
        }
        try {
            const response = await fetch(baseUri + "/users", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(body)
            })
            if (response.status !== 201) {
                setModalTextError("cette address email est déjà utilisé")
                setModalVisible(true)
            }
            goToPages.goToLogin()
        } catch (error) {
            setModalTextError("une erreur est survenue lors de la connection au serveur.\n\n veuillez réessayer plus tard")
            setModalVisible(true)
        }

    }

    const validate = () => {
        if (!firstnameIsValid) return false
        if (!lastnameIsValid) return false
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
                <Text style={styles.title}>Register</Text>
                <TM_RequiredInput
                    value={firstname}
                    onChangeText={setFirstname}
                    setIsValide={setFirstnameIsValid}
                    title={"firstname"}
                />
                <TM_RequiredInput
                    value={lastname}
                    onChangeText={setLastname}
                    setIsValide={setLastnameIsValid}
                    title={"lastname"}
                />
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
                        onPress={register}
                    >
                        <Text style={styles.buttonText}> {"register"}</Text>
                    </Pressable>

                    <Pressable
                        style={styles.button}
                        onPress={() => goToPages.goToLogin()}
                    >
                        <Text style={styles.buttonText}> {"Go to Login"}</Text>
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
        borderRadius: 15,
        alignItems: 'center',
        justifyContent: 'center',
        padding: "3%"
    },
    title: {
        fontSize: 20,
        fontWeight: "bold",
        marginBottom: "6%",
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
        marginTop: 10
    },
    buttonText: {
        color: 'white',
        fontSize: 16,
        fontWeight: 'bold',
    },
});
