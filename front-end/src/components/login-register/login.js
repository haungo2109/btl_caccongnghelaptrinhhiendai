import React, { useState } from 'react';
import { useDispatch, useStore } from 'react-redux';
import { useHistory } from 'react-router-dom';
import { ID, SECRET } from '../../api/axiosClient';
import userApi from '../../api/userApi';
import { Input } from './input';
import './login.css'

export function Login() {
    const dispatch = useDispatch();

    let history = useHistory();
    const [username, setInfo] = useState("");
    const [password, setPassword] = useState("");
    let ErrorMsg = "";

    const handleSubmit = (event) => {
        event.preventDefault();

        const formData = new FormData();
        formData.append('username', username);
        formData.append('password', password);
        formData.append('grant_type', "password");
        formData.append('client_secret', process.env.REACT_APP_CLIENT_SECRET);
        formData.append('client_id', process.env.REACT_APP_CLIENT_ID);

        userApi.login(formData).then(data => {
            userApi.getCurrentUserInfo().then(data => {
                dispatch({
                    type: 'login',
                    payload: data
                })
                history.push('/')
            })
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