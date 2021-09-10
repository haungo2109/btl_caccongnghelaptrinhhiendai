import { faImages, faPlusCircle, faTags } from '@fortawesome/free-solid-svg-icons';
import { useRef, useState } from 'react';
import { useHistory } from 'react-router';
import postApi from '../../api/postAPI';
import Button from '../shared/button';
import ImgViewer from '../shared/img-viewer';
import TagsMaker from '../shared/tags-maker';
import InputTextarea from '../shared/textarea';
import './post-maker.css'

export default function PostMaker() {

    let history = useHistory();
    const fileRef = useRef(null);

    const [text, setText] = useState("");
    const [tags, setTags] = useState([]);
    const [imgs, setImgs] = useState([]);
    const [previewImgs, setPreviewImgs] = useState([]);

    let handleSubmit = () => {
        let formData = new FormData();
        formData.set('hashtag', tags);
        formData.set('content', text);
        formData.set('images', imgs);

        postApi.postPost(formData).then(data => {
            window.open('Bài viết được tạo thành công');
            history.push('/post');
        })

    }
    let handleTags = () => {
        console.log('focus')
    }
    let handleImportPicture = (e) => {
        const imageArray = Array.from(e.target.files);
        setImgs(imageArray);
        const tempImgs = imageArray.map(e => URL.createObjectURL(e));

        setPreviewImgs(tempImgs)
    }

    return (
        <div className="post-item-container" >
            <input className="display-none" ref={fileRef} type="file" accept="image/*" multiple={true} onChange={handleImportPicture} />
            <div className="post-add-content">
                <InputTextarea type="textarea" value={text} onChangeValue={setText} place_holder="Tạo bài viết mới"  />
            </div>
            <div className="post-tags">
                <TagsMaker tags={tags} onChangeTags={setTags} />
            </div>
            <div className="post-imgs">
                {imgs.length != 0 && <ImgViewer imgArray={previewImgs} />}
            </div>
            <div className="post-utils">
                {/* <Button name="Tags" onClick={handleTags} icon={faTags} /> */}
                <Button name="Thêm ảnh" onClick={() => fileRef.current.click()} icon={faImages} />
                <Button name="Tạo bài viết" onClick={handleSubmit} icon={faPlusCircle} type="type-primary" />
            </div>
        </div>
    )
}