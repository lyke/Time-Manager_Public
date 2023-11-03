import {createContext, useState} from "react";
import {useNavigation} from "@react-navigation/native";

export const Context = createContext()
export const TM_ContextProvider = ({children}) => {
    const [baseUri, setBaseUri] = useState("http://localhost:4000/api")
    const [token, setToken] = useState(null)

    const navigation = useNavigation();

    function logout() {
        setToken(null)
        setUser(null)
        goToLogin()
    }

    function goToLogin() {
        navigation.navigate('Login')
    }

    return (
        <Context.Provider value={{baseUri, token, setToken, goToLogin, logout}}>
            {children}
        </Context.Provider>
    )
}
