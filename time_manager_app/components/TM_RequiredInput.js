import {StyleSheet, Text, TextInput, View} from "react-native";
import {useState} from "react";

export default function TM_RequiredInput({value, onChangeText, title, setIsValide, isMail = false, isPwd = false}) {
    const [error, setError] = useState()

    const buildInput = (value, onChangeText, title) => {
        return (
            <TextInput
                placeholderTextColor={"#ccc"}
                style={styles.input}
                onChangeText={value => {
                    onChangeText(value)
                    checkError(value)
                }}
                value={value}
                placeholder={title}
            />
        )
    }

    const buildPwdInput = (value, onChangeText, title) => {
        return (
            <TextInput
                placeholderTextColor={"#ccc"}
                style={styles.input}
                onChangeText={value => {
                    onChangeText(value)
                    checkError(value)
                }}
                value={value}
                placeholder={title}
                textContentType={"password"}
                secureTextEntry
            />
        )
    }

    const buildMailInput = (value, onChangeText, title) => {
        return (
            <TextInput
                placeholderTextColor={"#ccc"}
                style={styles.input}
                onChangeText={value => {
                    onChangeText(value)
                    checkError(value)
                }} value={value}
                placeholder={title}
                autoComplete={"email"}
                inputMode={"email"}
            />
        )
    }
    const buildError = errorMessage => {
        return (<Text style={styles.error}> {errorMessage} </Text>)
    }

    const checkError = value => {
        if (value === null || value.trim() === "") {
            setError(buildError(title + " is required"))
            setIsValide(false)
            return
        }
        if (isMail && !/^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$/g.test(value)) {
            setError(buildError("this field should be a valid email"))
            setIsValide(false)
            return
        }
        setError(null)
        setIsValide(true)
    }


    const buildedInput = isMail ? buildMailInput(value, onChangeText, title)
        : isPwd ? buildPwdInput(value, onChangeText, title)
        : buildInput(value, onChangeText, title)

    return (
        <View style={styles.container}>
            <Text style={styles.title}> {title} </Text>
            {buildedInput}
            {error}
        </View>
    )
}

const styles = StyleSheet.create({
    container: {
        width: '90%',
        marginBottom: "5%",
    },
    title: {
        fontSize: 16,
        fontWeight: 'bold',
        paddingLeft: 5,
        marginBottom: '1%',
    },
    input: {
        borderWidth: 1,
        borderColor: '#ccc',
        borderRadius: 5,
        paddingHorizontal: 10,
        paddingVertical: "3%"
    },
    error: {
        color: 'red',
        textAlign: 'right',
        fontSize: 10,
    }
});
