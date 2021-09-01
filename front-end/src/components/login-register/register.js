import './register.css'
import React, { useState } from 'react';
import { Input } from './input';
import ImageUploader from '../shared/image-uploader';
import api from '../../api/apiCalls';

export function Register() {

    const emailRe = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

    const [username, setInfo] = useState("");
    const [password, setPassword] = useState("");
    const [confirmPassword, setConfirmPassword] = useState("");
    const [firstName, setFirstName] = useState("");
    const [lastName, setLastName] = useState("");
    const [email, setEmail] = useState("");
    const [avatar, setAvatar] = useState({});

    const handleSubmit = (event) => {
        event.preventDefault();
        if(!emailRe.test(email)) {
            window.alert("Vui lòng nhập Email đúng định dạng");
            return;
        }
        if(password !== confirmPassword) {
            window.alert("Mật khẩu và xác nhận mật khẩu không trùng nhau");
            setConfirmPassword("");
            return;
        }
        const formData = new FormData();
        formData.append('first_name', firstName);
        formData.append('last_name', lastName);
        if(Object.keys(avatar).length !== 0) {
            formData.append('avatar', avatar);
        }
        formData.append('email', email);
        formData.append('username', username);
        formData.append('password', password);

        api.user.register(formData).then(data => {
            console.log(data);
        }).catch(error => console.log("Đăng ký thất bại, vui lòng thử lại sau"))
        
    }

    return(
        <div className="form-container">
            <div className="out-layer">
                <div className="form">
                    <h2>Đăng Ký</h2>
                    <form onSubmit={handleSubmit} encType="multipart/form-data">
                        <div>
                            <ImageUploader label="Hình đại diện" onImageSelect={setAvatar} />
                            <Input name="Họ*" value={firstName} type="text" changeData={setFirstName} />
                            <Input name="Tên*" value={lastName} type="text" changeData={setLastName} />
                            <Input name="Email*" value={email} type="text" changeData={setEmail} />
                            <Input name="Tài khoản*" value={username} type="text" changeData={setInfo} />
                            <Input name="Mật khẩu*" value={password} type="password" changeData={setPassword} />
                            <Input name="Xác nhận mật khẩu*" value={confirmPassword} type="password" changeData={setConfirmPassword} />
                        </div>
                        <input className="submit" disabled={!username || !password || !lastName || !firstName || !email || !confirmPassword} type="submit" value="Đăng ký" />
                    </form>
                </div>
            </div>
        </div>
    )
}