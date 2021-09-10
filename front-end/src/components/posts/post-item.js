import { faComment, faHeart } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import moment from 'moment'
import { useStore } from 'react-redux'
import ImgViewer from '../shared/img-viewer'
import PostUtil from '../shared/post-utils'
import './post-item.css'



export default function PostItem({content, createdAt, vote, user, hashtags, id, images}) {

    const store = useStore();
    const userStore = store.getState();

    let deleteItem = () => {
        console.log('delete')
    }
    let report = () => {
        console.log('report')
    }

    let utilItems = [
        {name: 'Báo cáo', action: report}
    ]

    if(userStore.id == id) {
        utilItems.push({name: 'Chỉnh sửa bài viết', link: `/post/${id}`});
        utilItems.push({name: 'Xóa bài viết', action: deleteItem});
    }

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
            <div className="wrapper-image">
                <ImgViewer imgArray={images} />
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