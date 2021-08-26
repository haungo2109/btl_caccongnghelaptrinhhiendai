import './register.css'
import React, { useState } from 'react';
import { Input } from './input';
import ImageUploader from '../shared/image-uploader';

export function Register() {
    let ErrorMsg = "";

    const [username, setInfo] = useState("");
    const [password, setPassword] = useState("");
    const [avatar, setAvatar] = useState({});

    const handleSubmit = (event) => {
        if(!username) {
            ErrorMsg = "Vui lòng nhập tài khoản";
            return;
        }
        if(!password) {
            ErrorMsg = "Vui lòng nhập mật khẩu";
            return;
        }
        if(avatar) {
            // console.log(avatar)
        }
        
        
        event.preventDefault();
    }

    return(
        <div className="form-container">
            <div className="form" onSubmit={handleSubmit}>
                <h2>Đăng Ký</h2>
                <form>
                    <div>
                        <ImageUploader label="Hình đại diện" onImageSelect={setAvatar} />
                        <Input name="Tài khoản" value={username} type="text" changeData={setInfo} />
                        <Input name="Mật khẩu" value={password} type="password" changeData={setPassword} />
                    </div>
                    <input className="submit" disabled={!username || !password} type="submit" value="Đăng nhập" />
                    <span className="error" >{ErrorMsg}</span>
                </form>
            </div>
        </div>
    )
}