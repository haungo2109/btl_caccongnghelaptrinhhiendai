import { useStore } from "react-redux";
import { Redirect, Route } from "react-router-dom";

export default function ProtectedRoute({component: Component, ...rest}) {

    const store = useStore();
    let user = store.getState();

    return(
        <Route {...rest} render={(props) => (
            Object.keys(user).length !== 0? <Component {...props}  /> : <Redirect to='/login' />
        )} /> 
    )
}