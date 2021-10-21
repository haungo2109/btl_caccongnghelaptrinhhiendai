import { faTimes } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { useRef } from 'react';
import { useState } from 'react/cjs/react.development'
import Button from './button';
import './tags-maker.css'

export default function TagsMaker({tags, onChangeTags, onDeleteTag}) {

    const [tag, setTag] = useState('');
    const inputRef = useRef(null);

    let addTag = () => {
        if(tag !== '' && !tags.includes(tag.trim())) {
            onChangeTags([...tags, tag.trim()]);
        }
        setTag('');
    }
    let handleEnter = (e) => {
        if(e.key === 'Enter'){
            addTag();
        }
    }

    return (
        <div className="tags-maker-container">
            <div className="tag-input">
                <input ref={inputRef} type="text" value={tag} onChange={(e) => setTag(e.target.value)} onKeyPress={handleEnter} />
                <Button onClick={addTag} name="Thêm tag" />
            </div>
            <div className="tags-list"> 
                {tags && tags.map(t => <p key={t} className="tag-item">#{t} <FontAwesomeIcon onClick={() => onDeleteTag(t)} icon={faTimes} title="Xóa tag" ></FontAwesomeIcon></p>) }
            </div>
        </div>
    )
}