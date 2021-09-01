import React, { useState } from 'react';
import { useHistory } from 'react-router-dom';
import userApi, { ID, SECRET } from '../../api/userApi';
import { Input } from './input';
import './login.css'

export function Login() {
    let history = useHistory();
    const [username, setInfo] = useState("");
    const [password, setPassword] = useState("");
    let ErrorMsg = "";

    const handleSubmit = (event) => {
        event.preventDefault();

        const formData = new URLSearchParams();
        formData.append('username', username);
        formData.append('password', password);
        formData.append('grant_type', "password");
        formData.append('client_secret', SECRET);
        formData.append('client_id', ID);

        userApi.login(formData).then(data => {
            history.push('/')
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