import './post-item.css'

export default function PostItem({content, createdAt, vote, user, hashtags}) {

    return (
        <div className="post-item-container">
            <div className="avatar">
                <p>{user.full_name}</p>
                <div className="date">
                    <p>{createdAt}</p>
                </div>
            </div>
            <div>
                {hashtags.map((h) => {
                    <a href="!#" >#{h}</a>
                })}
            </div>
            <div className="content">
                <p>{content}</p>
            </div>
            <div className="tool-bar">
                <div className="likes">
                    <p>{vote}</p>
                </div>
                <div className="commends">
                    <p></p>
                </div>
            </div>
        </div>
    )
}