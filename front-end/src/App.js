import './App.css';
import {
  BrowserRouter as Router,
  Switch,
  Route
} from "react-router-dom";
import Header from './components/header/header';
import Auctions from './components/auctions/auctions';
import MainPage from './components/main-page/main-page';
import { Login } from './components/login-register/login';
import { Register } from './components/login-register/register';
import Posts from './components/posts/posts';

function App() {
  return (
    <div className="main">
      <Router>
        <div>
          <Header />
        </div>
        <div>
          <Switch>
              <Route exact path="/posts" component={Posts} ></Route>
              <Route exact path="/auctions" component={Auctions} ></Route>
              <Route exact path="/login" component={Login} ></Route>
              <Route exact path="/register" component={Register} ></Route>
              <Route exact path="/" component={MainPage}></Route>
          </Switch>
        </div>
      </Router>
    </div>
  );
}

export default App;
