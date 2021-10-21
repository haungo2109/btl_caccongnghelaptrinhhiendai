import './auction-comments-list.css'

export  function AuctionCommentLine({line, isFirst}) {
    return (
        <div className="comment-item-container">
            <div className="avatar">
                <div className="avatar-img">
                    <img src={line.user.avatar} alt="img" />
                </div>
            </div>
            <div className="comment-text">
                <div className="price">
                    <p><span>Giá đấu giá: </span>{line.price} $</p>
                </div>
                <p>{line.content}</p>
            </div>
        </div>
    )
}

export default function  AuctionCommentList({listComment}) {
    return(
        <div className="comments-list-container">
            {listComment && listComment.length === 0 && <div className="no-comment"><p>Chưa có bình luận nào</p></div>}
            {listComment && listComment.length !== 0 && listComment.map(co => <AuctionCommentLine key={co.id} line={co} />)}
        </div>
    )
}