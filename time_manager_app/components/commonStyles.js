import {StyleSheet} from 'react-native';

const commonStyles = StyleSheet.create({
    box: {
        backgroundColor: "white",
        width: "80%",
        maxWidth: 600,
        borderRadius: 15,
        alignItems: 'center',
        justifyContent: 'center',
        padding: "3%",
        marginBottom: "2%"
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
        marginTop: 10,
    },
    buttonText: {
        color: 'white',
        fontSize: 16,
        fontWeight: 'bold',
    },
});

export default commonStyles;
