import { faPaperPlane } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import './post-comment.css';

export default function PostComment({onComment, commentText, placeHolder = "Nhập vào bình luận của bạn", onClick, onKeyDown}) {
    return( 
        <div className="comment-input-container">
            <input type="text" onChange={onComment} value={commentText} placeholder={placeHolder} onKeyDown={onKeyDown} />
            <div className="comment-btn" onClick={onClick}>
                <p>Gửi</p>
                <FontAwesomeIcon icon={faPaperPlane} ></FontAwesomeIcon>
            </div>
        </div>
    )
}