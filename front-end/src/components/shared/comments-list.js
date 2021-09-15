import './comments-list.css'

export function CommentLine({line}) {
    return (
        <div className="comment-item-container">
            <div className="avatar">
                <div className="avatar-img">
                    <img src={line.user.avatar} />
                </div>
            </div>
            <div className="comment-text">
                <p>{line.content}</p>
            </div>
        </div>
    )
}

export default function CommentsList({listComment}) {
    return(
        <div className="comments-list-container">
            {listComment && listComment.length == 0 && <div className="no-comment"><p>Chưa có bình luận nào</p></div>}
            {listComment && listComment.length != 0 && listComment.map(co => <CommentLine key={co.id} line={co} />)}
        </div>
    )
}