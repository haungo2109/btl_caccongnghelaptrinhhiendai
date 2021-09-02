import axiosClient from './axiosClient';

export const ID = 'TPLrxQE8mF9slRzevZSNbNCLQXDSSbJrnIprMCNM';
export const SECRET =
	'QRHKVKgNnYo8GmwvxUfFtJRAtvtoLTD4mDoNtWzxulgFhrY8rssWssFglvAvZxZpm2vHHBY2nIJDHETm3SOONxD0ADRKL0ald5Ip8hCoUeOAxQn8KipFFjkU64LlzlCQ';

const config = {
	headers: {
		'Content-Type': 'application/x-www-form-urlencoded',
	},
};

const userApi = {
	/**
	 * use to get token
	 * @param {{username:"", password: ""}} data is an object
	 * @returns Promise
	 */
	login: (data) => {
		const url = '/o/token/';
		return axiosClient.post(url, data, config);
	},
	register: (data) => {
		const url = '/user/';
		return axiosClient.post(url, data, config);
	},
	getUserInfo: (id) => {
		const url = `/user/${id}`
		return axiosClient.get(url);
	},
	getCurrentUserInfo: () => {
		const url = `/user/current-user/`
		return axiosClient.get(url);
	},
};
export default userApi;
