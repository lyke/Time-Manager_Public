import {createContext, useState} from "react";
import {useNavigation} from "@react-navigation/native";

export const Context = createContext()
export const TM_ContextProvider = ({children}) => {
    const baseUri = "https://time-manager-epitech.gigalixirapp.com/api"
    const [token, setToken] = useState("")
    const [user, setUser] = useState(null)
    const [userTeams, setUserTeams] = useState([])

    const navigation = useNavigation();

    function login(token, user) {
        setUser(user)
        setToken("Bearer " + token)

        setUserTeams(user.teams)
        if (user.role === "super_manager"){
            getAllTeams()
        }
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

    const getAllTeams = async () => {
        const url = baseUri + "/teams"
        const response = await fetch(url, {
            headers: {Authorization: token}
        })
        const data = await response.json()
        setUserTeams(data.data)
    }

    return (
        <Context.Provider value={{baseUri, token, login, user, goToPages, logout, getLastClock, userTeams}}>
            {children}
        </Context.Provider>
    )
}
