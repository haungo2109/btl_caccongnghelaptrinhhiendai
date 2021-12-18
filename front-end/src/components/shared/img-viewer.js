import { useEffect } from 'react';
import { useState } from 'react/cjs/react.development';
import './img-viewer.css';

export default function ImgViewer({ imgArray, preview = true }) {
	const [mainImg, setMainImg] = useState(imgArray[0]);

	useEffect(() => {
		setMainImg(imgArray[0]);
	}, [imgArray]);

	return (
		<div className="imgViewer-container">
			<div className="first-preview">
				{preview && <img src={mainImg} alt="Hình chính" />}
			</div>
			{imgArray.length > 1 ? (
				<div className="imgViewer-array">
					{imgArray &&
						imgArray.map((c) => (
							<img
								onClick={() => setMainImg(c)}
								key={c}
								src={c}
								alt="Hình"
							/>
						))}
				</div>
			) : null}
		</div>
	);
}
