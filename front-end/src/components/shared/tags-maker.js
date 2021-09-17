import { useRef } from 'react';
import { useState } from 'react/cjs/react.development'
import Button from './button';
import './tags-maker.css'

export default function TagsMaker({tags, onChangeTags}) {

    const [tag, setTag] = useState('');
    const inputRef = useRef(null);

    let addTag = () => {
        if(tag !== '' && !tags.includes(tag.trim())) {
            onChangeTags([...tags, tag.trim()]);
        }
        setTag('');
    }

    return (
        <div className="tags-maker-container">
            <div className="tag-input">
                <input ref={inputRef} type="text" value={tag} onChange={(e) => setTag(e.target.value)} />
                <Button onClick={addTag} name="Thêm tag" />
            </div>
            <div className="tags-list"> 
                {tags && tags.map(t => <p key={t} className="tag-item">#{t}</p>) }
            </div>
        </div>
    )
}