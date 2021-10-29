import './auction-comments-list.css'
import { useStore } from 'react-redux'
import { useEffect } from 'react';

export  function AuctionCommentLine({line, isFirst, showPrice = false, isOwner = false, handleSelectWinner = null}) {
    return (
        <div className="comment-item-container">
            <div className="avatar">
                <div className="avatar-img">
                    <img src={line.user.avatar} alt="img" title={`Người dùng: ${line.user.full_name}`} />
                </div>
            </div>
            <div className="comment-text">
                <div className="price">
                    <p><span>Giá đấu giá: </span>{showPrice? line.price + '$': '---'}</p>
                    {isOwner && <button onClick={() => handleSelectWinner(line.user)} >Thắng đấu giá</button>}
                </div>
                <p>{line.content}</p>
            </div>
        </div>
    )
}

export default function  AuctionCommentList({listComment, auctionOwnerId, handleSelectWinner}) {

    let store = useStore();
    let user = store.getState();

    let checkIfOwner = () => {
        if(auctionOwnerId === user.id) {
            return true;
        }
        return false;
    }

    return(
        <div className="comments-list-container">
            {listComment && listComment.length === 0 && <div className="no-comment"><p>Chưa có bình luận nào</p></div>}
            {listComment && listComment.length !== 0 && user && !checkIfOwner() && listComment.map(co => <AuctionCommentLine key={co.id} line={co} showPrice={user.id == co.user.id} />)}
            {listComment && listComment.length !== 0 && user && checkIfOwner() && listComment.map(co => <AuctionCommentLine key={co.id} line={co} showPrice={true} isOwner={true} handleSelectWinner={handleSelectWinner} />)}
        </div>
    )
}