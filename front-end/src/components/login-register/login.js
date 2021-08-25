import React, { useState } from 'react';
import { Input } from './input';
import './login.css'

export function Login() {

    const [username, setInfo] = useState("");
    const [password, setPassword] = useState("");
    const [disableSubmit, setDisableSubmit] = useState(true);

    const handleSubmit = (event) => {
        event.preventDefault();
    }

    return(
        <div className="form" onSubmit={handleSubmit}>
            <h2>Đăng nhập</h2>
            <form>
                <div>
                    <Input name="Tài khoản" value={username} type="text" changeData={setInfo} />
                    <Input name="Mật khẩu" value={password} type="password" changeData={setPassword} />
                </div>
                <input className="submit" disabled={disableSubmit} type="submit" value="Submit" />
            </form>
        </div>
    )
}