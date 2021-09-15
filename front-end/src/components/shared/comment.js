import { faPaperPlane } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import './comment.css';

export default function Comment({onComment, commentText}) {
    return( 
        <div className="comment-input-container">
            <input type="text" onChange={onComment} value={commentText} />
            <p>
                <FontAwesomeIcon icon={faPaperPlane} ></FontAwesomeIcon>
            </p>
        </div>
    )
}