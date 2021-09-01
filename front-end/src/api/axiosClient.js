import axios from "axios";
import queryString from "query-string";

let baseURL = "http://localhost:8000/";

const axiosClient = axios.create({
	baseURL,
	headers: {
		'Content-Type': 'application/json',
        'Accept': "*/*"
	},
	// paramsSerializer: (params) => queryString.stringify(params),
});

//nhét token vào request
axiosClient.interceptors.request.use(async (config) => {
    const Authentication = localStorage.getItem('Authentication');
    
    if (Authentication)
        config.headers["Authentication"] = localStorage.getItem("Authentication");
    
    return config;
});

//nhét token vào respone
axiosClient.interceptors.response.use(
    (res) => {
        if (res?.data?.access_token)
            localStorage.setItem(
				'Authentication',
				`Bearer ${res?.data?.access_token}`
			);
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