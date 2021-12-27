import './auction-comment.css'
import { faDollarSign } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

export default function AuctionComment({onComment, commentText, placeHolder = "Nhập vào nội dung", onClick, onKeyDown, onCommentPrice, price, placeHolder_price = "Giá đấu giá ($)"}) {
    return( 
        <div className="comment-input-container auction-comment">
            <div>
                <label>{placeHolder_price}</label>
                <input type="number" onChange={onCommentPrice} value={price} placeholder={placeHolder_price} onKeyDown={onKeyDown} />
            </div>
            <div>
                <label>{placeHolder}</label>
                <input type="text" onChange={onComment} value={commentText} placeholder={placeHolder} onKeyDown={onKeyDown} />
            </div>
            <div className="comment-btn" onClick={onClick}>
                <p>Xác nhận đấu giá</p>
                <FontAwesomeIcon icon={faDollarSign} ></FontAwesomeIcon>
            </div>
        </div>
    )
}