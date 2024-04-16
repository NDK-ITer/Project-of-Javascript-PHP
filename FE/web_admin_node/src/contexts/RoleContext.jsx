import { useState, createContext } from "react";

const RoleContext = createContext([])

const RoleProvider = ({ children }) => {
    const [role, setRole] = useState()

    const UpdateRole = (roleData) => {
        setRole(roleData)
    }

    return (
        <RoleContext.Provider value={{
            role,
            UpdateRole
        }}>
            {children}
        </RoleContext.Provider>
    )
}

export {
    RoleContext,
    RoleProvider,
}