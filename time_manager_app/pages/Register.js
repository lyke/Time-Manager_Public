import {StatusBar} from 'expo-status-bar';
import {Pressable, StyleSheet, Text, View} from 'react-native';
import {useContext, useState} from "react";
import TM_RequiredInput from "../components/TM_RequiredInput";
import TM_Modal from "../components/TM_Modal";
import {Context} from "../components/TM_ContextProvider";
import commonStyles from "../components/commonStyles";
import TM_container from "../components/TM_container";

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
        <TM_container>
            <TM_Modal
                text={modalTextError}
                modalVisible={modalVisible}
                setModalVisible={setModalVisible}
            />
            <View style={commonStyles.box}>
                <Text style={commonStyles.title}>Register</Text>
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

                <View style={commonStyles.buttonContainer}>
                    <Pressable
                        style={commonStyles.button}
                        onPress={register}
                    >
                        <Text style={commonStyles.buttonText}> {"register"}</Text>
                    </Pressable>

                    <Pressable
                        style={commonStyles.button}
                        onPress={() => goToPages.goToLogin()}
                    >
                        <Text style={commonStyles.buttonText}> {"Go to Login"}</Text>
                    </Pressable>
                </View>
            </View>

            <StatusBar style="auto"/>
        </TM_container>
    );
}
