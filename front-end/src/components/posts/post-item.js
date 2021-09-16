import { faComment, faHeart } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import moment from 'moment'
import { useStore } from 'react-redux'
import { useHistory } from 'react-router'
import { useState } from 'react/cjs/react.development'
import postApi from '../../api/postAPI'
import Comment from '../shared/comment'
import CommentsList from '../shared/comments-list'
import ImgViewer from '../shared/img-viewer'
import PostUtil from '../shared/post-utils'
import './post-item.css'



export default function PostItem({content, createdAt, vote, user, hashtags, id, images, comments_list, isAllowedToComments = false, getListComment}) {

    const store = useStore();
    const userStore = store.getState();
    const history = useHistory();
    const [comment, setComment] = useState('');

    let deleteItem = () => {
        console.log('delete')
    }
    let report = () => {
        console.log('report')
    }

    let utilItems = [
        {name: 'Báo cáo', action: report}
    ]
    let move = (route) => {
        !comments_list && history.push(route);
    }

    if(userStore.id == id) {
        utilItems.push({name: 'Chỉnh sửa bài viết', link: `/post/${id}`});
        utilItems.push({name: 'Xóa bài viết', action: deleteItem});
    }
    let sendComment = () => {
        let form = new FormData();
        form.set('content', comment);
        postApi.createPostComment(id, form).then(data => {
            getListComment()
            setComment('');
            // tao tự tạo ra vòng lặp...
        }).catch(err => {
            console.log(err); 
            return false;
        });
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
                    <p onClick={() => move(`/posts/${id}`)}>
                        <FontAwesomeIcon icon={faComment} />
                        Bình luận
                    </p>
                </div>
            </div>
            {isAllowedToComments && <div>
                <Comment onComment={(e) => setComment(e.target.value)} commentText={comment} onClick={sendComment} ></Comment>
            </div>}
            {comments_list && <div>
                <CommentsList listComment={comments_list} />
            </div>}
        </div>
    )
}