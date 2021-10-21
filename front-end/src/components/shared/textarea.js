import { useEffect, useRef, useState } from 'react'
import './textarea.css'
import './shared.css'

export default function InputTextarea({type, value, onChangeValue, label, place_holder}) {

    const textRef = useRef(null);
    const [currentValue, setCurrentValue] = useState("");

    useEffect(() => {
        textRef.current.style.height = "inherit";
        const scrollHeight = textRef.current.scrollHeight;
        textRef.current.style.height = `${scrollHeight}px`;
    }, [currentValue])

    return(
        <div className="textarea shared-input">
            {label && <label>{label}</label>}
            <textarea ref={textRef} value={value} placeholder={place_holder} type={type} onChange={(e) => {onChangeValue(e.target.value); setCurrentValue(e.target.value)}} />
        </div>
    )
}