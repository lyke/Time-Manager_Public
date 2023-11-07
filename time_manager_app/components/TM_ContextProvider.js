import {createContext, useState} from "react";
import {useNavigation} from "@react-navigation/native";

export const Context = createContext()
export const TM_ContextProvider = ({children}) => {
    const baseUri = "https://time-manager-epitech.gigalixirapp.com/api"
    const [token, setNewToken] = useState("")
    const [user, setUser] = useState(null)
    let lastClockIn = null

    const navigation = useNavigation();

    function setToken(token) {
        setNewToken("Bearer "+token)
    }

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

    async function getLastClockIn(){
        if (lastClockIn === null){
            const response = await fetch(baseUri+"/users/"+user.id+"/today_clocks", {
                headers: { Authorization: token }
            })
            const todayClocks = ( await response.json() ).data
            if (todayClocks.length === 1 && todayClocks[0].status === true){
                lastClockIn = todayClocks[0]
            }
        }
        return lastClockIn
    }

    function goTo(page){ navigation.navigate(page)}

    return (
        <Context.Provider value={{baseUri, token, setToken, user, setUser, goToPages, logout, getLastClockIn}}>
            {children}
        </Context.Provider>
    )
}
