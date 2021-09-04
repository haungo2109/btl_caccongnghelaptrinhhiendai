import { useStore } from "react-redux"
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
                </div>
            </div>
        </div>
    )
}