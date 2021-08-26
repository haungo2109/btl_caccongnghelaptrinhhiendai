import axiosClient from "./axiosClient"

const api = {
    post: {
        getListByPage: () => {
            return axiosClient.get(``)
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

    }

}

export default api;