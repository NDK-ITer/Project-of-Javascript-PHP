import axios from 'axios';
import Cookies from 'js-cookie';
import { toast } from "react-toastify";

const instance = axios.create({
    baseURL: `http://localhost:7000/api`,
    timeout: 5000,
    withCredentials: false
});

instance.interceptors.request.use(function (config) {
    const jwt  = Cookies.get('jwt');
    if (jwt) {
        config.headers[`Authorization`] = `Bearer ${jwt}`
    }
    return config;
}, function (error) {
    // Do something with request error
    return Promise.reject(error);
});

instance.interceptors.response.use(function (res) {
    let result = res.data
    if(result.state !== 1){
        toast.error(result.mess)
    }
    return result;
}, function (error) {
    
});

export default instance;