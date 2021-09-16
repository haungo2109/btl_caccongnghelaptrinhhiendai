import { faImages, faPlusCircle } from '@fortawesome/free-solid-svg-icons';
import { useEffect, useRef, useState } from 'react';
import { useHistory } from 'react-router';
import auctionApi from '../../api/auctionApi';
import categoryAuctionApi from '../../api/categoryAuctionApi';
import postApi from '../../api/postAPI';
import Button from '../shared/button';
import DatePickerInput from '../shared/date-picker';
import ImgViewer from '../shared/img-viewer';
import InputText from '../shared/input';
import TagsMaker from '../shared/tags-maker';
import InputTextarea from '../shared/textarea';
import './auction-maker.css'

export default function AuctionMaker() {
    let history = useHistory();
    const fileRef = useRef(null);

    const [text, setText] = useState("");
    const [title, setTitle] = useState('');
    const [price, setPrice] = useState('');
    const [condition, setCondition] = useState('');
    const [date, setDate] = useState(new Date())
    const [listCate, setListCate] = useState([]);
    const [category, setCategory] = useState('');
    const [imgs, setImgs] = useState([]);
    const [previewImgs, setPreviewImgs] = useState([]);

    useEffect(() => {
        categoryAuctionApi.getCategoryAuction().then(data => {
            setListCate(data.results);
        }).catch(err => console.log(err));
    }, [])

    let handleSubmit = () => {
        if(price < 0) {
            window.alert('Giá phải lớn hơn hoặc bằng 0');
            return;
        }

        let formData = new FormData();
        formData.set('content', text);
        formData.set('images', imgs);

        auctionApi.postAuction(formData).then(data => {
            window.alert('Bài đấu giá được tạo thành công');
            history.push('/auctions');
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
            <div className="post-title">
                <InputText place_holder="Tên bài đấu giá" value={title} onChangeValue={(e) => setTitle(e.target.value)} ></InputText>
            </div>
            <div className="post-add-content">
                <InputTextarea type="textarea" value={text} onChangeValue={setText} place_holder="Tạo bài viết mới"  />
            </div>
            <div className="post-price">
                <InputText place_holder="Giá khởi điểm" value={price} type="number" onChangeValue={(e) => setPrice(e.target.value)} ></InputText>
            </div>
            <div className="post-condition">
                <InputText place_holder="Điều kiện" value={condition} onChangeValue={(e) => setCondition(e.target.value)} ></InputText>
            </div>
            <div className="post-end-date">
                <DatePickerInput selected={date} onChange={(date) => setDate(date)} />
            </div>
            <div className="post-category">
                
            </div>
            <div className="post-imgs">
                {imgs.length != 0 && <ImgViewer imgArray={previewImgs} />}
            </div>
            <div className="post-utils">
                <Button name="Thêm ảnh" onClick={() => fileRef.current.click()} icon={faImages} />
                <Button name="Tạo bài đấu giá" onClick={handleSubmit} icon={faPlusCircle} type="type-primary" />
            </div>
        </div>
    )
}