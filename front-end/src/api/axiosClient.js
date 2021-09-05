import axios from "axios";
import queryString from "query-string";

let baseURL = "http://localhost:8000/";
export const ID = 'TPLrxQE8mF9slRzevZSNbNCLQXDSSbJrnIprMCNM';
export const SECRET =
	'QRHKVKgNnYo8GmwvxUfFtJRAtvtoLTD4mDoNtWzxulgFhrY8rssWssFglvAvZxZpm2vHHBY2nIJDHETm3SOONxD0ADRKL0ald5Ip8hCoUeOAxQn8KipFFjkU64LlzlCQ';


const axiosClient = axios.create({
	baseURL,
	headers: {
		'Content-Type': 'application/json',
        'Accept': "*/*"
	},
	paramsSerializer: (params) => queryString.stringify(params),
});

//nhét token vào request
axiosClient.interceptors.request.use(async (config) => {
    const Authentication = localStorage.getItem('Authorization');
    
    if (Authentication)
        config.headers["Authorization"] = localStorage.getItem("Authorization");
    
    return config;
});

//nhét token vào respone
axiosClient.interceptors.response.use(
    (res) => {
        if (res?.data?.access_token)
            localStorage.setItem(
				'Authorization',
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