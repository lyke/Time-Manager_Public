import {createContext, useState} from "react";
import {useNavigation} from "@react-navigation/native";

export const Context = createContext()
export const TM_ContextProvider = ({children}) => {
    const baseUri = "https://time-manager-epitech.gigalixirapp.com/api"
    const [token, setNewToken] = useState("")
    const [user, setUser] = useState(null)

    const navigation = useNavigation();

    function setToken(token) {
        setNewToken("Bearer " + token)
    }

    function logout() {
        setToken(null)
        setUser(null)
        goToPages.goToLogin()
    }

    const goToPages = {
        goToLogin: () => {
            goTo('Login')
        },
        goToRegister: () => {
            goTo('Register')
        },
        goToDashBoard: () => {
            goTo('Dashboard')
        }
    }

    async function getLastClock() {
        let lastClock = null
        const response = await fetch(baseUri + "/users/" + user.id + "/today_clocks", {
            headers: {Authorization: token}
        })
        const todayClocks = (await response.json()).data
        if (todayClocks.length > 0) {
            todayClocks.sort( (clockA, clockB) => {
                const dateA = new Date(clockA.time)
                const dateB = new Date(clockB.time)
                return dateB - dateA
            })
            lastClock = todayClocks[0]
        }

        return lastClock
    }

    function goTo(page) {
        navigation.navigate(page)
    }

    return (
        <Context.Provider value={{baseUri, token, setToken, user, setUser, goToPages, logout, getLastClock}}>
            {children}
        </Context.Provider>
    )
}
