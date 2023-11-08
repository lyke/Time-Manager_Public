import * as React from 'react';

import {TM_ContextProvider} from "./components/TM_ContextProvider";
import Main from "./pages/Main";
import {NavigationContainer} from "@react-navigation/native";

function App() {
    return (
        <NavigationContainer>
            <TM_ContextProvider>
                <Main/>
            </TM_ContextProvider>
        </NavigationContainer>
    );
}

export default App;
