import './post-comments-list.css'

export function PostCommentLine({line}) {
    return (
        <div className="comment-item-container">
            <div className="avatar">
                <div className="avatar-img">
                    <img src={line.user.avatar} alt="img" />
                </div>
            </div>
            <div className="comment-text">
                <p>{line.user.full_name}</p>
                <p>{line.content}</p>
            </div>
        </div>
    )
}

export default function PostCommentsList({listComment}) {
    return(
        <div className="comments-list-container">
            {listComment && listComment.length === 0 && <div className="no-comment"><p>Chưa có bình luận nào</p></div>}
            {listComment && listComment.length !== 0 && listComment.map(co => <PostCommentLine key={co.id} line={co} />)}
        </div>
    )
}