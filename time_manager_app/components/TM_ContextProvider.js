import {createContext, useState} from "react";

export const Context = createContext()
export const TM_ContextProvider = ({ children }) => {
    const [baseUri, setBaseUri] = useState("http://localhost:4000/api")

    return (
        <Context.Provider value={{ baseUri }}>
            {children}
        </Context.Provider>
    )
}
