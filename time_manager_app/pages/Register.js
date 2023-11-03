import {StatusBar} from 'expo-status-bar';
import {Pressable, StyleSheet, Text, View} from 'react-native';
import {useContext, useEffect, useState} from "react";
import Input from "../components/Input";
import {Context} from "../components/ContextProvider";

export default function Register() {
    const baseUri = "http://localhost:4000/api"

    const [firstname, setFirstname] = useState('')
    const [lastname, setLastname] = useState('')
    const [mail, setMail] = useState('')
    const [pwd, setPwd] = useState('')

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
        const response = await fetch(baseUri + "/users", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(body)
        })
        if (response.status !== 201){
            console.log("erreur mail")
        }
    }

    const validate = () => {
        if (firstname === null || firstname.trim() === "") return false
        if (lastname === null || lastname.trim() === "") return false
        if (mail === null || mail.trim() === "") return false
        if (!/^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$/g.test(mail)) return false
        if (pwd === null || pwd.trim() === "") return false

        return true
    }

    return (
        <View style={styles.container}>
            <View style={styles.form}>
                <Text style={styles.title}>Register</Text>
                <Input
                    value={firstname}
                    onChangeText={setFirstname}
                    title={"firstname"}
                />
                <Input
                    value={lastname}
                    onChangeText={setLastname}
                    title={"lastname"}
                />
                <Input
                    value={mail}
                    onChangeText={setMail}
                    title={"mail"}
                    isMail
                />
                <Input
                    value={pwd}
                    onChangeText={setPwd}
                    title={"password"}
                    isPwd
                />

                <View>
                    <Pressable
                        style={styles.button}
                        onPress={register}
                    >
                        <Text
                            style={styles.buttonText}
                        > {"register"}</Text>
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
