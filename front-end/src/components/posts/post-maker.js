import { faImages, faPlusCircle, faTags } from '@fortawesome/free-solid-svg-icons';
import { useState } from 'react';
import Button from '../shared/button';
import InputTextarea from '../shared/textarea';
import './post-maker.css'

export default function PostMaker() {

    const [text, setText] = useState("");
    const [tags, setTags] = useState([]);
    const [imgs, setImgs] = useState([]);

    let handleSubmit = () => {
        
    }
    let handleTags = () => {
        console.log('focus')
    }
    let handleImportPicture = () => {

    }

    return (
        <div className="post-item-container" >
            <div className="post-add-content">
                <InputTextarea type="textarea" value={text} onChangeValue={setText} place_holder="Tạo bài viết mới"  />
            </div>
            <div className="post-utils">
                {/* <Button name="Tags" onClick={handleTags} icon={faTags} /> */}
                <Button name="Thêm ảnh" onClick={handleImportPicture} icon={faImages} />
                <Button name="Tạo bài viết" onClick={handleSubmit} icon={faPlusCircle} type="type-primary" />
            </div>
        </div>
    )
}