import axiosClient from "./axiosClient"

const api = {
    post: {
        getListByPage: () => {
            return axiosClient.get(`/post`)
        }
    },
    auction: {
        getListByPage: () => {
            return axiosClient.get(``)
        }
    },
    admin: {

    },
    user: {
        register: (data) => {
            return axiosClient.post('/user/', data, {
                'Content-Type': 'multipart/form-data'
            });
        }, 
        login: (data) => {
            return axiosClient.post('/o/token/', data);
        },
    }

}

export default api;