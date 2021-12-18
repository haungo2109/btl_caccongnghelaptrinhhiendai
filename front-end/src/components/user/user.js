import { useDispatch, useStore } from "react-redux"
import { useHistory } from "react-router";
import './user.css'

let infos = [
    {id: 'first_name', name: 'Họ'}, 
    {id: 'last_name', name: 'Tên'}, 
    {id: 'username', name: 'Tên tài khoản'}, 
    {id: 'email', name: 'Email'}
];

export default function UserPage() { 

    const store = useStore();
    const user = store.getState();
    const history = useHistory();
    const dispatch = useDispatch();

    let move = (path) => {
        history.push(path);
    }
    let logout = () => {
        if(window.confirm('Đăng xuất ra khỏi hệ thống ?') == true) {
            dispatch({
                type: 'logout'
            });
            history.push('/')
        }
    }

    return(
        <div className="user-container">
            <div className="outlayer"> 
                <div className="img-container">
                    {user.avatar? <img src={user.avatar} alt="Hình đại diện" />: <img src="https://i.pinimg.com/originals/55/6c/38/556c381559c59fd2231498de3014e7c2.png" alt="Hình đại diện" />}
                </div>
                <div className="body-container">
                    {infos.map(info => {
                        return <div key={info.id} className="info-bar">
                                <label>
                                    {info.name}
                                </label>
                                <p>{user[info.id]}</p>
                            </div>
                    })}
                    <div className="buttons">
                        <button onClick={() => move('/posts/owner')} >Bài viết của cá nhân</button>
                        <button onClick={() => move('/auctions/owner')}>Bài đấu giá của cá nhân</button>
                        <button onClick={() => logout()}>Đăng xuất</button>
                    </div>
                </div>
            </div>
        </div>
    )
}