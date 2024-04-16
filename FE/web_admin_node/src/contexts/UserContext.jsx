import { useState, createContext } from "react";

const UserContext = createContext([])

const UserProvider = ({ children }) => {
    const [user, setUser] = useState()

    const UpdateUser = (userData) => {
        setUser(userData)
    }

    return (
        <UserContext.Provider value={{
            user,
            UpdateUser
        }}>
            {children}
        </UserContext.Provider>
    )
}

export {
    UserContext,
    UserProvider,
}