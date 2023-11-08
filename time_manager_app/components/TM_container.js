import {ImageBackground, Pressable, StyleSheet, Text, TextInput, View} from "react-native";
import {useContext, useEffect, useState} from "react";
import {Context} from "./TM_ContextProvider";
import commonStyles from "./commonStyles";

export default function TM_container(props ) {
    return (
        <ImageBackground source={ require("../assets/gradiant.png") } style={styles.container}>
            {props.children}
        </ImageBackground>
    )
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
    },
});
