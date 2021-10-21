export const userReducer = (state = {}, action) => {
    switch(action.type) {
        case 'login': 
            localStorage.setItem('user', JSON.stringify(action.payload));
            return action.payload;
        case 'logout': 
            localStorage.clear();
            return {}
        default: 
            return state
    }
}