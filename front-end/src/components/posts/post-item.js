import { faComment, faHeart } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import moment from 'moment'
import { useStore } from 'react-redux'
import { useHistory } from 'react-router'
import { useState } from 'react/cjs/react.development'
import postApi from '../../api/postAPI'
import reportApi from '../../api/reportApi'
import ImgViewer from '../shared/img-viewer'
import PostUtil from '../shared/post-utils'
import ReportDialog from '../shared/report-dialog'
import PostComment from './post-comment'
import PostCommentsList from './post-comments-list'
import './post-item.css'



export default function PostItem({content, createdAt, vote, user, hashtags, id, images, comments_list, isAllowedToComments = false, getListComment, like, handleLike, handleDelete, listReportType, handleClickTag}) {

    const store = useStore();
    const userStore = store.getState();
    const history = useHistory();
    const [comment, setComment] = useState('');
    const [dialogState, setDialogState] = useState(false);
    const [openUtils, setOpenUtils] = useState(false);

    let utilItems = []; 
    if(userStore && userStore.id === user.id) {
        utilItems.push({name: 'Chỉnh sửa bài', action: () => handleEdit()});
        utilItems.push({name: 'Xóa bài', action: () => handleDelete(id)});
    } else { 
        utilItems.push({name: 'Báo cáo', action: () => setDialogState(true)});
    }
    //utils
    let move = (route) => {
        !comments_list && history.push(route);
    }
    let handleEdit = () => {
        history.push({pathname: "/posts/create", search: `?id=${id}`})
    }
    let handleOpenUtils = (value) => {
        setOpenUtils(value);
    }
    //comments
    let sendComment = () => {
        let form = new FormData();
        form.set('content', comment);
        postApi.createPostComment(id, form).then(data => {
            getListComment()
            setComment('');
        }).catch(err => {
            console.log(err); 
            return false;
        });
    }
    let handleOnKeyDown = (e) => {
        if(e.key === 'Enter') {
            sendComment();
        }
    }
    //handle click on tool bars
    let checkIfLiked = () => {
        if(like.includes(userStore.id)) {
            return "liked"
        }
    }
    let handleClickLike = () => {
        if(like.includes(userStore.id)) {
            handleLike(id, true);
        } else  {
            handleLike(id, false);
        }
    }
    //handle dialogs
    let handleCloseReportDialog = (value) => {
        if(value.action == 'confirm') {
            reportApi.postReportPost({type: value.type, content: value.content, post: id}).then(data => {
                window.alert('Báo cáo thành công');
            }).catch(err => window.alert("Báo cáo thất bại, vui lòng thử lại sau"))
        } 
        setDialogState(false);
        setOpenUtils(false);
    }

    return (
        <div className="post-item-container">
            <div className="utils">
                <PostUtil listItem={utilItems} handleClick={handleOpenUtils} isOpen={openUtils} />
                <ReportDialog state={dialogState} handleClose={handleCloseReportDialog} listType={listReportType} ></ReportDialog>
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
                {hashtags && hashtags.map((h) => 
                    <a onClick={() => handleClickTag(h)} key={h.id} >#{h.name}</a>
                )}
            </div>
            <div className="content">
                <p>{content}</p>
            </div>
            <div className="wrapper-image">
                {images.length != 0 && <ImgViewer imgArray={images} />}
            </div>
            <div className="tool-bar">
                <div className="likes card" title="Thích" onClick={() => handleClickLike()}>
                    <p className={checkIfLiked()}>
                        <FontAwesomeIcon icon={faHeart} />
                        {like.length} lượt thích
                    </p>
                </div>
                <div className="commends card" title="Bình luận" onClick={() => move(`/posts/${id}`)}>
                    <p >
                        <FontAwesomeIcon icon={faComment} />
                        Bình luận
                    </p>
                </div>
            </div>
            {isAllowedToComments && <div>
                <PostComment onComment={(e) => setComment(e.target.value)} commentText={comment} onClick={sendComment} onKeyDown={handleOnKeyDown} />
            </div>}
            {comments_list && <div>
                <PostCommentsList listComment={comments_list} />
            </div>}
        </div>
    )
}