import { faEdit, faImages, faPlusCircle } from '@fortawesome/free-solid-svg-icons';
import moment from 'moment';
import { useEffect, useRef, useState } from 'react';
import { useStore } from 'react-redux';
import { useHistory } from 'react-router';
import auctionApi from '../../api/auctionApi';
import categoryAuctionApi from '../../api/categoryAuctionApi';
import postApi from '../../api/postAPI';
import { useQuery } from '../../App';
import Button from '../shared/button';
import DatePickerInput from '../shared/date-picker';
import ImgViewer from '../shared/img-viewer';
import InputText from '../shared/input';
import SelectInput from '../shared/selectsList';
import TagsMaker from '../shared/tags-maker';
import InputTextarea from '../shared/textarea';
import './auction-maker.css'

export default function AuctionMaker() {
    let history = useHistory();
    const fileRef = useRef(null);
    let query = useQuery();
    let store = useStore();
    let user = store.getState();

    const [isEdit, setIsEdit] = useState(false);
    const [auctionId, setAuctionId] = useState('');
    const [text, setText] = useState("");
    const [title, setTitle] = useState('');
    const [price, setPrice] = useState(0);
    const [condition, setCondition] = useState('');
    const [date, setDate] = useState(new Date())
    const [listCate, setListCate] = useState([]);
    const [listPayment, setListPayment] = useState([]);
    const [category, setCategory] = useState(1);
    const [imgs, setImgs] = useState([]);
    const [previewImgs, setPreviewImgs] = useState([]);
    const [payment, setPayment] = useState(2);

    useEffect(() => {
        categoryAuctionApi.getCategoryAuction().then(data => {
            setListCate(data.results);
        }).catch(err => console.log(err));
        auctionApi.getPaymentMethod().then(data => {
            setListPayment(data.results);
        }).catch(err => console.log(err));

        if(query.get('id')) {
            setIsEdit(true);
            setAuctionId(query.get('id'));

            auctionApi.getAuction(query.get('id')).then(data => {
                if(user && data.user.id == user.id) {
                    setText(data.content);
                    setTitle(data.title);
                    setPrice(data.base_price);
                    setCondition(data.condition)
                    setDate(moment(data.deadline).toDate());
                    setCategory(data.category);
                    setPreviewImgs(data.auction_images);
                    setPayment(data.payment_method);
                } else {
                    history.goBack();
                }
            })
        }
    }, [])

    let handleSubmit = () => {
        if(price < 0) {
            window.alert('Giá phải lớn hơn hoặc bằng 0');
            return;
        }
        if(!category || !price || !title || !condition || !category || !text || !date) {
            window.alert('Vui lòng nhập đầy đủ các nội dung có dấu *');
            return;
        }

        let formData = new FormData();
        formData.set('title', title);
        formData.set('content', text);
        formData.set('base_price', price);
        formData.set('condition', condition);
        formData.set('deadline', moment(date).format('YYYY-MM-DD'));
        formData.set('payment_method', payment);
        if(imgs.length !== 0) {
            // formData.set('images', imgs);
            for (let index = 0; index < imgs.length; index++) {
                formData.append('images', imgs[index]);            
            }
        }
        formData.set('category', category);

        auctionApi.postAuction(formData).then(data => {
            window.alert('Bài đấu giá được tạo thành công');
            history.push('/auctions');
        }).catch(err => console.log(err));
    }

    let handleEdit = () => {
        if(price < 0) {
            window.alert('Giá phải lớn hơn hoặc bằng 0');
            return;
        }
        if(!category || !price || !title || !condition || !category || !text || !date) {
            window.alert('Vui lòng nhập đầy đủ các nội dung có dấu *');
            return;
        }

        let formData = new FormData();
        formData.set('title', title);
        formData.set('content', text);
        formData.set('base_price', price);
        formData.set('condition', condition);
        formData.set('deadline', moment(date).format('YYYY-MM-DD'));
        formData.set('payment_method', payment);
        if(imgs.length !== 0) {
            // formData.set('images', imgs);
            for (let index = 0; index < imgs.length; index++) {
                formData.append('images', imgs[index]);            
            }
        }
        formData.set('category', category);

        auctionApi.patchAuction(auctionId, formData).then(data => {
            window.alert('Bài đấu giá được tạo thành công');
            history.push('/auctions/'+data.id);
        }).catch(err => console.log(err));
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
                <InputText place_holder="Tên bài đấu giá" label="Tên bài đấu giá *" value={title} onChangeValue={(e) => setTitle(e.target.value)} ></InputText>
            </div>
            <div className="post-add-content">
                <InputTextarea type="textarea" label="Nội dung bài viết *" value={text} onChangeValue={setText} place_holder="Nội dung bài đấu giá"  />
            </div>
            <div className="post-price">
                <InputText place_holder="Giá khởi điểm" label="Giá khởi điểm ($) *" value={price} type="number" onChangeValue={(e) => setPrice(e.target.value)} ></InputText>
            </div>
            <div className="post-condition">
                <InputText place_holder="Điều kiện" label="Điều kiện *" value={condition} onChangeValue={(e) => setCondition(e.target.value)} ></InputText>
            </div>
            <div className="post-end-date">
                <DatePickerInput selected={date} label="Hạn chót đấu giá *" onChange={(date) => setDate(date)} />
            </div>
            <div className="post-category">
                <SelectInput label="Loại đấu giá *" options={listCate} onSelect={(e) => setCategory(e.id)} selectedOption={category} />
            </div>
            <div className="post-payment">
                <SelectInput label="Loại thanh toán *" options={listPayment} onSelect={(e) => setPayment(e.id)} selectedOption={payment} />
            </div>
            <div className="post-imgs">
                {imgs.length != 0 && <ImgViewer imgArray={previewImgs} />}
                {imgs.length != 0 && isEdit && <ImgViewer imgArray={previewImgs} />}
            </div>
            <div className="post-utils">
                <Button name="Thêm ảnh" onClick={() => fileRef.current.click()} icon={faImages} />
                { !isEdit && <Button name="Tạo bài đấu giá" onClick={handleSubmit} icon={faPlusCircle} type="type-primary" />}
                { isEdit && <Button name="Chỉnh sửa bài đấu giá" onClick={handleEdit} icon={faEdit} type="type-primary" />}
            </div>
        </div>
    )
}