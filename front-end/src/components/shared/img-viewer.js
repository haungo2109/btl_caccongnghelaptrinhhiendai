import { useState } from 'react/cjs/react.development'
import './img-viewer.css'

export default function ImgViewer({imgArray, preview = true}) {

    const [mainImg, setMainImg] = useState(imgArray[0]);

    return(
        <div className="imgViewer-container">
            <div className="first-preview">
                {preview && <img src={mainImg} alt="Hình chính" />}
            </div>
            <div className="imgViewer-array">
			    {imgArray && imgArray.map((c) => <img onClick={() => setMainImg(c)} key={c} src={c} alt="Hình" />)}
            </div>
        </div>
    )
}