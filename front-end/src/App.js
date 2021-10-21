import './App.css';
import {
  BrowserRouter as Router,
  Switch,
  Route,
  useLocation
} from "react-router-dom";
import Header from './components/header/header';
import Auctions from './components/auctions/auctions';
import MainPage from './components/main-page/main-page';
import { Login } from './components/login-register/login';
import { Register } from './components/login-register/register';
import Posts from './components/posts/posts';
import ProtectedRoute from './route/protected-route';
import UserPage from './components/user/user';
import userApi from './api/userApi';
import { useDispatch, useStore } from 'react-redux';

export function useQuery() {
  return new URLSearchParams(useLocation().search);
}

function App() {
  const store = useStore();
  const user = store.getState();
  const dispatch = useDispatch()

  //pursist state
  if(localStorage.getItem('Authorization') && Object.keys(user).length === 0) {
    userApi.getCurrentUserInfo().then(data => {
      dispatch({
        type: 'login',
        payload: data
      })
    }).catch(err => {
      console.log('Hết hạn phiên làm việc')
    })
  }

  // note, nếu sub route error, coi chừng chữ exact

  return (
    <div className="main">
      <Router>
        <div>
          <Header />
        </div>
        <div>
          <Switch>
              <Route path="/posts" component={Posts} ></Route>
              <Route path="/auctions" component={Auctions} ></Route>
              <Route exact path="/login" component={Login} ></Route>
              <Route exact path="/register" component={Register} ></Route>
              <ProtectedRoute path="/user"><UserPage /></ProtectedRoute>
              <Route exact path="/" component={MainPage}></Route>
          </Switch>
        </div>
      </Router>
    </div>
  );
}

export default App;
