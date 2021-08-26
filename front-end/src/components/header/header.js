import './header.css'
import {Link} from "react-router-dom";

const links = [
    {'name': 'Trang chủ', 'link': ''},
    {'name': 'Bài đăng mới', 'link': 'posts'},
    {'name': 'Đấu giá', 'link': 'auctions'},
    {'name': 'Đăng nhập', 'link': 'login'},
    {'name': 'Đăng ký', 'link': 'register'},
]

function HeaderItem(props) {
    return (
        <p>
            <Link to={`/${props.link}`} >{props.name}</Link>
        </p>
    )
}

export default function Header() {

    const linkItems = links.map((l) => 
        <HeaderItem key={l.name.toString()} link={l.link} name={l.name}/>
    )

    return (
        <div className="navbar">
            {linkItems}
        </div>
    );
}
