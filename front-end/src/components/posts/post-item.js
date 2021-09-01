import { faComment, faHeart } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import moment from 'moment'
import PostUtil from '../shared/post-utils'
import './post-item.css'



export default function PostItem({content, createdAt, vote, user, hashtags, id}) {

    let deleteItem = () => {
        console.log('delete')
    }

    const utilItems = [
        {name: 'Chỉnh sửa bài viết', link: `/post/${id}`},
        {name: 'Xóa bài viết', action: deleteItem}
    ]

    return (
        <div className="post-item-container">
            <div className="utils">
                <PostUtil listItem={utilItems}/>
            </div>
            <div className="avatar">
                <div className="avatar-img">
                    <img src={user.avatar} />
                </div>
                <div className="avatar-body">
                    <p>{user.full_name}</p>
                    <div className="date">
                        <p>{ moment(createdAt).format("DD/MM/YYYY - h:mm a") }</p>
                    </div>
                </div>
            </div>
            <div className="hashtag">
                {hashtags.map((h) => {
                    <a href="!#" >#{h}</a>
                })}
            </div>
            <div className="content">
                <p>{content}</p>
            </div>
            <div className="tool-bar">
                <div className="likes card" title="Thích">
                    <p>
                        <FontAwesomeIcon icon={faHeart} />
                        {vote} lượt thích
                    </p>
                </div>
                <div className="commends card" title="Bình luận">
                    <p>
                        <FontAwesomeIcon icon={faComment} />
                        Bình luận
                    </p>
                </div>
            </div>
        </div>
    )
}