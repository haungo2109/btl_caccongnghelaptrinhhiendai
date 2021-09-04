import axiosClient from "./axiosClient"

const api = {
    post: {
        getListByPage: () => {
            return axiosClient.get(`/post/`)
        },
        addNewPost: (data) => {
            return axiosClient.post(`/post/`, data)
        }
    },
    auction: {
        getListByPage: () => {
            return axiosClient.get(``)
        }
    },
}

export default api;