import { useStore } from "react-redux";
import { Redirect, Route } from "react-router-dom";

export default function ProtectedRoute({children, ...rest}) {

    const store = useStore();
    let user = store.getState();

    let checkIfAllowed = () => {
        if(user && user.username || localStorage.getItem('user') !== null) {
            return true;
        }
        return false;
    }

    return(
        <Route {...rest} render={({location}) => (
            checkIfAllowed() ? (children) : <Redirect to={{pathname: '/login', state: {from: location}}} />
        )} /> 
    )
}