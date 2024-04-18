import Root from "../Roots.jsx";

const Login = ({ email, password }) => {
    return Root.post(`login`, {
        email: email,
        password: password
    })
}

const GetAllRole = () => {
    return Root.get(`all-role`)
}

export {
    GetAllRole,
    Login
}