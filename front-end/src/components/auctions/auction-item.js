import { faBell, faCalendarAlt, faComment, faDollarSign, faHeart } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import moment from 'moment'
import { useEffect, useState } from 'react'
import { useStore } from 'react-redux'
import { useHistory } from 'react-router'
import auctionApi from '../../api/auctionApi'
import ImgViewer from '../shared/img-viewer'
import PostUtil from '../shared/post-utils'
import AuctionComment from './auction-comment'
import AuctionCommentList from './auction-comments-list'
import './auction-item.css'

function SmallConditionItem({className, text, title, icon}) {
    return (
        <div className="small-cond-item">
            <div>
                <FontAwesomeIcon className={className? className: ''} icon={icon} />
            </div>
            <span>{title}</span>
            <span>{text}</span>
        </div>
    )
}

export default function AuctionItem({auction, comments_list, isAllowedToComments = false, getListComment, handleLike, handleDelete}) {

    let history = useHistory();
    let store = useStore();
    let user = store.getState();
    const [comment, setComment] = useState('');
    const [price, setPrice] = useState(0);

    let handleEdit = () => {
        history.push({pathname: '/auctions/create', search: `?id=${auction.id}`})
    }

    let utilItems = [];

    if(user && user.id == auction.user.id) {
        utilItems.push({name: 'Chỉnh sửa bài', action: () => handleEdit()});
        utilItems.push({name: 'Xóa bài bài', action: () => handleDelete(auction.id)});
    } else {
        utilItems.push({name: 'Báo cáo', action: () => {}});
    }

    let move = (route) => {
        !comments_list && history.push(route);
    }
    let sendComment = () => {
        if(comment.length === 0 || price <= 0 ){
            window.alert('Vui lòng nhập đầy đủ thông tin');
            return;
        }
        let form = new FormData();
        form.set('content', comment);
        form.set('price', price)
        auctionApi.createAuctionComment(auction.id, form).then(data => {
            window.alert("Đấu giá thành công");
            getListComment()
            setComment('');
            setPrice(0);
        }).catch(err => {
            console.log(err); 
            return false;
        });
    }
    let handleOnKeyDown = (e) => {
        if(e.key === 'Enter') {
            sendComment();
        }
    }
    let checkIfLiked = () => {
        if(auction.like.includes(user.id)) {
            return "liked"
        }
    }
    let handleClickLike = () => {
        if(auction.like.includes(user.id)) {
            handleLike(auction.id, true);
        } else  {
            handleLike(auction.id, false);
        }
    }

    return (
        <div className="post-item-container auction-item-container">
            <div className="utils">
                <PostUtil listItem={utilItems}/>
            </div>
            <div className="title">
                    <h2>{auction.title}</h2>
                </div>
            <div className="avatar auction-avatar">
                <div className="avatar-body">
                    <p>Bởi {auction.user.full_name}</p>
                    <div className="date">
                        <p>{ moment(auction.createdAt).format("DD/MM/YYYY - h:mm a") }</p>
                    </div>
                </div>
            </div>
            <div className="price">
                <div>
                    <SmallConditionItem title="Trạng thái: " text={auction.status_auction} icon={faBell} className="dark-grey" />
                    <SmallConditionItem title="Thời gian: " text={moment(auction.deadline).format("DD/MM/YYYY")} icon={faCalendarAlt} />
                </div>
                <div>
                    <SmallConditionItem title="Giá chấp nhận: " text={auction.accept_price} icon={faDollarSign} className="green"/>
                    <SmallConditionItem title="Giá bắt đầu: " text={auction.base_price} icon={faDollarSign} className="green"/>
                </div>
            </div>
            <div className="content">
                <p>{auction.content}</p>
            </div>
            <div className="wrapper-image">
                {auction.auction_images.length != 0 && <ImgViewer imgArray={auction.auction_images} />}
            </div>
            <div className="tool-bar">
                <div className="likes card" title="Thích" onClick={() => handleClickLike()}>
                    <p className={checkIfLiked()}>
                        <FontAwesomeIcon icon={faHeart} />
                        {auction.like.length} lượt thích
                    </p>
                </div>
                <div className="commends card" title="Bình luận" onClick={() => move(`/auctions/${auction.id}`)}>
                    <p>
                        <FontAwesomeIcon icon={faComment} />
                        Bình luận
                    </p>
                </div>
            </div>
            {isAllowedToComments && <div>
                <AuctionComment onComment={(e) => setComment(e.target.value)} commentText={comment} onClick={sendComment} onKeyDown={handleOnKeyDown} price={price} onCommentPrice={(e) => setPrice(e.target.value)} />
            </div>}
            {comments_list && <div>
                <AuctionCommentList listComment={comments_list} />
            </div>}
        </div>
    )
}