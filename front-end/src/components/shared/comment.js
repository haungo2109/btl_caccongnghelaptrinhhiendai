import { faPaperPlane } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import './comment.css';

export default function Comment({onComment, commentText, placeHolder = "Nhập vào bình luận của bạn", onClick}) {
    return( 
        <div className="comment-input-container">
            <input type="text" onChange={onComment} value={commentText} placeholder={placeHolder} />
            <div className="comment-btn" onClick={onClick}>
                <p>Gửi</p>
                <FontAwesomeIcon icon={faPaperPlane} ></FontAwesomeIcon>
            </div>
        </div>
    )
}