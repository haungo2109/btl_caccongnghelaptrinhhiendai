import { useStore } from "react-redux";
import { Redirect, Route } from "react-router-dom";

export default function ProtectedRoute({children, ...rest}) {

    const store = useStore();
    let user = store.getState();

    return(
        <Route {...rest} render={(props) => (
            user && user?.username ? (children) : <Redirect to='/login' />
        )} /> 
    )
}