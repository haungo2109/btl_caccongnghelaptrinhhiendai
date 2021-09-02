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

    const store = useStore();
    const user = store.getState();

    if(Object.keys(user).length != 0) {
        links.push({'name': user.last_name, 'link': 'user'});
    } else {
        links.push({'name': 'Đăng nhập', 'link': 'login'});
        links.push({'name': 'Đăng ký', 'link': 'register'});
    }

    const linkItems = links.map((l) => 
        <HeaderItem key={l.name.toString()} link={l.link} name={l.name}/>
    )

    return (
        <div className="navbar">
            {linkItems}
        </div>
    );
}
