import axiosClient, { ID, SECRET } from './axiosClient';

const config = {
	headers: {
		'Content-Type': 'multipart/form-data',
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
	logout: () => {
		const url = '/o/revoke-token/';
		return axiosClient.post(
			url,
			{
				token: localStorage.getItem('Authorization'),
				client_id: process.env.REACT_APP_CLIENT_ID,
				client_secret: process.env.REACT_APP_CLIENT_SECRET,
			},
			{
				headers: {
					'Content-Type': 'application/x-www-form-urlencoded',
				},
			}
		);
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
