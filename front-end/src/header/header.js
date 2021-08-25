import './header.css'

function HeaderItem(props) {
    return (
        <p key={props.id}>
            <a href={`/${props.link}`} >{props.name}</a>
        </p>
    )
}

export default function Header() {

    const links = [
        {'name': 'Trang chính', 'link': 'main'},
        {'name': 'Đấu giá', 'link': 'auction'},
        {'name': 'Đăng nhập', 'link': 'login'},
        {'name': 'Đăng ký', 'link': 'register'},
    ]

    const linkItems = links.map((l) => 
        <HeaderItem link={l.link} name={l.name} id={l.name.toString()} />
    )

    return (
        <div className="navbar">
            {linkItems}
        </div>
    );
}
