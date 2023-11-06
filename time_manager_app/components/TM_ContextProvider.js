import {createContext, useState} from "react";
import {useNavigation} from "@react-navigation/native";

export const Context = createContext()
export const TM_ContextProvider = ({children}) => {
    const baseUri = "https://time-manager-epitech.gigalixirapp.com/api"
    const [token, setToken] = useState(null)
    const [user, setUser] = useState(null)

    const navigation = useNavigation();

    function logout() {
        setToken(null)
        setUser(null)
        goToPages.goToLogin()
    }

    const goToPages = {
        goToLogin: () => { goTo('Login') },
        goToRegister: () => { goTo('Register') },
        goToDashBoard: () => { goTo('Dashboard') }
    }

    function goTo(page){ navigation.navigate(page)}

    return (
        <Context.Provider value={{baseUri, token, setToken, user, setUser, goToPages, logout}}>
            {children}
        </Context.Provider>
    )
}
