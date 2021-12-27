import './auction-comments-list.css'
import { useStore } from 'react-redux'
import { useEffect } from 'react';

export  function AuctionCommentLine({line, isFirst, showPrice = false, displayButton = false, handleSelectWinner = null}) {

    // array là mảng chứa các phần tử: none, succ, fail, in process
    let checkIfNotInArray = (array) => {
        return 
    }

    return (
        <div className="comment-item-container">
            <div className="avatar">
                <div className="avatar-img">
                    <img src={line.user.avatar} alt="img" title={`Người dùng: ${line.user.full_name}`} />
                </div>
            </div>
            <div className="comment-text">
                <div className="price">
                    <p></p>
                    <p><span>Giá đấu giá: </span>{showPrice? line.price + '$': '---'}</p>
                    <div>
                        {displayButton && line.status_transaction === 'none' && <button title={'Chọn người dùng này thắng đấu giá'}  onClick={() => handleSelectWinner(line)} >Thắng đấu giá</button>}
                        {displayButton && line.status_transaction === 'in process' && <button className="fail" title={'Giao dịch thất bại, sẽ được chọn người thắng cuộc khác'} onClick={() => handleSelectWinner(line, 'fail')} >Giao dịch thất bại</button>}
                        {displayButton && line.status_transaction === 'in process' && <button className="success" title={'Giao dịch thành công'} onClick={() => handleSelectWinner(line, 'success')} >Giao dịch thành công</button>}
                        {displayButton && line.status_transaction === 'fail' && <p className="fail-transaction">Giao dịch thất bại</p>}
                    </div>
                </div>
                <p>{line.content}</p>
            </div>
        </div>
    )
}

export default function  AuctionCommentList({listComment, auction, handleSelectWinner}) {

    let store = useStore();
    let user = store.getState();

    let checkIfOwner = () => {
        if(auction.user.id === user.id) {
            return true;
        }
        return false;
    }

    return(
        <div className="comments-list-container">
            {listComment && listComment.length === 0 && <div className="no-comment"><p>Chưa có bình luận nào</p></div>}
            {listComment && listComment.length !== 0 && user && !checkIfOwner() && listComment.map(co => <AuctionCommentLine key={co.id} line={co} showPrice={user.id == co.user.id} />)}
            {listComment && listComment.length !== 0 && user && checkIfOwner() && listComment.map(co => <AuctionCommentLine key={co.id} line={co} showPrice={true} displayButton={auction.status_auction === 'being auctioned' || co.status_transaction !== 'none'} handleSelectWinner={handleSelectWinner} />)}
        </div>
    )
}