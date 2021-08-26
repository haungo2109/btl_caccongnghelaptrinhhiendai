import axios from "axios";
import queryString from "query-string";

let baseURL = "http://localhost:2000/api";
// let baseURL = "http://192.168.2.161:2000/api";

const axiosClient = axios.create({
    baseURL,
    headers: {
        "Content-Type": "application/json",
    },
    paramsSerializer: (params) => queryString.stringify(params),
});

//nhét token vào request
axiosClient.interceptors.request.use(async (config) => {
    config.headers["Authentication"] = localStorage.getItem("Authentication");
    return config;
});

//nhét token vào respone
axiosClient.interceptors.response.use(
    (res) => {
        if (res?.data?.token)
            localStorage.setItem("Authentication", res?.data?.token);
        if (res?.data) {
            return res.data;
        }
        return res;
    },
    (error) => {
        console.error("API call failed. " + error);
        return Promise.reject(error.message)
    }
);  

export default axiosClient;