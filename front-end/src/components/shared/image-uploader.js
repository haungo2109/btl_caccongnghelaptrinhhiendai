import { useEffect, useRef, useState } from "react"
import './image-uploader.css'

export default function ImageUploader({label, onImageSelect}) {
    const inputRef = useRef(null);
    const [selectImage, setSelectImage] = useState()
    const [preview, setPreview] = useState()

    useEffect(() => {
        if(!selectImage) {
            setPreview(undefined);
            return;
        }
        const objUrl = URL.createObjectURL(selectImage)
        setPreview(objUrl)

        //free memory if component unmounted
        return () => URL.revokeObjectURL(objUrl);
    }, [selectImage])

    const handleChange = (data) => {
        if(!data.target.files || data.target.files.length === 0) {
            setSelectImage(undefined)
            return;
        }

        onImageSelect(data.target.files[0])
        setSelectImage(data.target.files[0])
    }

    return(
        <div className="image-uploader">
            <label>
                {label}
            </label>
            <div>
                { selectImage && <img src={preview} alt="img" /> }
                <input ref={inputRef}  type="file" onChange={handleChange} name="name"  accept="image/*" />
            </div>
        </div>
    )
}