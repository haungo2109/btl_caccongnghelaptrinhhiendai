import React, { useState } from 'react';
import api from '../../api/apiCalls';
import { Input } from './input';
import './login.css'

export function Login() {

    let ErrorMsg = "";

    const [username, setInfo] = useState("");
    const [password, setPassword] = useState("");

    const handleSubmit = (event) => {
        event.preventDefault();
        const formData = new FormData();
        formData.append('grant_type', 'password')
        formData.append('username', username);
        formData.append('password', password);
        formData.append('client_secret', process.env.REACT_APP_CLIENT_SECRET);
        formData.append('client_id', process.env.REACT_APP_CLIENT_ID);

        api.user.login(formData).then(data => {
            console.log(data);
        }).catch(error => window.alert('Sai tài khoản hoặc mật khẩu'))
    }

    return(
        <div className="form-container">
            <div className="out-layer">
                <div className="form" onSubmit={handleSubmit} encType="multipart/form-data">
                    <h2>Đăng nhập</h2>
                    <form>
                        <div>
                            <Input name="Tài khoản" value={username} type="text" changeData={setInfo} />
                            <Input name="Mật khẩu" value={password} type="password" changeData={setPassword} />
                        </div>
                        <input className="submit" disabled={!username || !password} type="submit" value="Đăng nhập" />
                        <span className="error" >{ErrorMsg}</span>
                    </form>
                </div>
            </div>
        </div>
    )
}