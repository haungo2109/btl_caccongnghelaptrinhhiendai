import './header.css'
import {Link} from "react-router-dom";
import { useStore } from 'react-redux';

const links = [
    {'name': 'Trang chủ', 'link': ''},
    {'name': 'Bài đăng mới', 'link': 'posts'},
    {'name': 'Đấu giá', 'link': 'auctions'},
]
const notLogin = [
    
]

function HeaderItem(props) {
    return (
        <p>
            <Link to={`/${props.link}`} >{props.name}</Link>
        </p>
    )
}

export default function Header() {

    const ls = [...links]

    const store = useStore();
    const user = store.getState();

    if(Object.keys(user).length != 0) {
        ls.push({'name': user.last_name, 'link': 'user'});
    } else {
        ls.push({'name': 'Đăng nhập', 'link': 'login'});
        ls.push({'name': 'Đăng ký', 'link': 'register'});
    }

    const linkItems = ls.map((l) => 
        <HeaderItem key={l.name.toString()} link={l.link} name={l.name}/>
    )

    return (
        <div className="navbar">
            {linkItems}
        </div>
    );
}
