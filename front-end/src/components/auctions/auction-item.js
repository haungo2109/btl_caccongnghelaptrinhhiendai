import { faBell, faCalendarAlt, faComment, faDollarSign, faHeart } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import moment from 'moment'
import { useEffect, useState } from 'react'
import ImgViewer from '../shared/img-viewer'
import PostUtil from '../shared/post-utils'
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

export default function AuctionItem({auction}) {

    let utilItems = [
        {name: 'Báo cáo', action: () => {}}
    ]

    return (
        <div className="post-item-container auction-item-container">
            <div className="utils">
                <PostUtil listItem={utilItems}/>
            </div>
            <div className="title">
                    <h2>{auction.title}</h2>
                </div>
            <div className="avatar">
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
                <div className="likes card" title="Thích">
                    <p>
                        <FontAwesomeIcon icon={faHeart} />
                        {auction.vote} lượt thích
                    </p>
                </div>
                <div className="commends card" title="Bình luận">
                    <p>
                        <FontAwesomeIcon icon={faComment} />
                        Bình luận
                    </p>
                </div>
            </div>
        </div>
    )
}