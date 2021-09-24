import { faEdit, faImages, faPlusCircle } from '@fortawesome/free-solid-svg-icons';
import { useEffect, useRef, useState } from 'react';
import { useStore } from 'react-redux';
import { useHistory } from 'react-router';
import postApi from '../../api/postAPI';
import { useQuery } from '../../App';
import Button from '../shared/button';
import ImgViewer from '../shared/img-viewer';
import TagsMaker from '../shared/tags-maker';
import InputTextarea from '../shared/textarea';
import './post-maker.css'

export default function PostMaker() {

    let history = useHistory();
    let query = useQuery();
    let store = useStore();
    let user = store.getState();
    const fileRef = useRef(null);

    useEffect(() => {
        if(query.get('id')) {
            setIsEdit(true);
            setPostId(query.get('id'));

            postApi.getPost(query.get('id')).then(data => {
                if(user && data.user.id == user.id) {
                    handleTags(data.hashtag);
                    setText(data.content);
                    setPreviewImgs(data.post_images);
                } else {
                    history.goBack();
                }
            })
        }
    }, [])

    const [text, setText] = useState("");
    const [isEdit, setIsEdit] = useState(false);
    const [postId, setPostId] = useState('');
    const [tags, setTags] = useState([]);
    const [imgs, setImgs] = useState([]);
    const [previewImgs, setPreviewImgs] = useState([]);

    let handleSubmit = () => {
        let formData = new FormData();
        formData.set('hashtag', tags);
        formData.set('content', text);
        for (let index = 0; index < imgs.length; index++) {
            formData.append('images', imgs[index]);            
        }

        postApi.postPost(formData).then(data => {
            window.alert('Bài viết được tạo thành công');
            history.goBack();
        }).catch(err => {
            console.log(err);
            window.alert('Bài viết tạo thất bại, vui lòng thử lại sau');
        })

    }

    let handleEdit = () => {
        let formData = new FormData();
        formData.set('hashtag', tags);
        formData.set('content', text);
        for (let index = 0; index < imgs.length; index++) {
            formData.append('images', imgs[index]);            
        }

        postApi.patchPost(postId,formData).then(data => {
            window.alert('Bài viết được sửa thành công');
            history.goBack();
        }).catch(err => {
            console.log(err);
            window.alert('Bài viết sửa thất bại, vui lòng thử lại sau');
        })
    }

    let handleTags = (tagArray) => {
        let tempTags = [];
        tagArray.forEach(t => tempTags.push(t.name));
        setTags(tempTags);
    }

    let handleImportPicture = (e) => {
        const imageArray = Array.from(e.target.files);
        setImgs(imageArray);
        const tempImgs = imageArray.map(e => URL.createObjectURL(e));

        setPreviewImgs(tempImgs)
    }

    let handleDeleteTag = (tag) => {
        setTags(tags.filter(x => x != tag));
    }

    return (
        <div className="post-item-container" >
            <input className="display-none" ref={fileRef} type="file" accept="image/*" multiple={true} onChange={handleImportPicture} />
            <div className="post-add-content">
                <InputTextarea type="textarea" value={text} onChangeValue={setText} place_holder="Tạo bài viết mới"  />
            </div>
            <div className="post-tags">
                <TagsMaker tags={tags} onChangeTags={setTags} onDeleteTag={handleDeleteTag} />
            </div>
            <div className="post-imgs">
                {imgs.length !== 0 && <ImgViewer imgArray={previewImgs} />}
                {imgs.length == 0 && isEdit && <ImgViewer imgArray={previewImgs} />}
            </div>
            <div className="post-utils">
                {/* <Button name="Tags" onClick={handleTags} icon={faTags} /> */}
                <Button name="Thêm ảnh" onClick={() => fileRef.current.click()} icon={faImages} />
                {!isEdit && <Button name="Tạo bài viết" onClick={handleSubmit} icon={faPlusCircle} type="type-primary" />}
                {isEdit && <Button name="Chỉnh sửa bài viết" onClick={handleEdit} icon={faEdit} type="type-primary" />}
            </div>
        </div>
    )
}