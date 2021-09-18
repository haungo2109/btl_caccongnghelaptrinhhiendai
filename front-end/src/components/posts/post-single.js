import { useEffect, useState } from 'react'
import { useStore } from 'react-redux';
import { useParams } from 'react-router';
import postApi from '../../api/postAPI';
import PostItem from './post-item';
import './post-single.css'

export default function PostSingle() {

    let store = useStore();
    let user = store.getState();
    let { postid } = useParams();
    const [post, setPost] = useState(null);
    const [allowComment, setAllowComment] = useState(false);
    const [commentList, setCommentList] = useState('');

    useEffect(() => {
        // console.log(postid)
        if(postid) {
            getData()
            getCommentList();
        }
        if(user && user?.username) {
            setAllowComment(true);
        }
    }, [user, postid]);

    // khi comment xoong -> reload list coomment -> reset comment
    let getCommentList = () => {
        postApi.getPostComment(postid).then(data => {
            setCommentList(data);
            return true;
        }).catch(err => {
            console.log(err); 
            window.alert('Bình luận thất bại, vui lòng thử lại sau')
            return false;
        });
    }
    let getData = () => {
        postApi.getPost(postid).then(data => {
            setPost(data); 
        }).catch(err => console.log(err));
    }
    let handleLike = (id, flagLiked) => {
        if(flagLiked) {
            postApi.decreatePostVote(id).then(data => {
                getData();
            }).catch(err => {console.log(err); window.alert("Hệ thống đã lỗi, vui lòng thử lại sau")});
        } else {
            postApi.increatePostVote(id).then(data => {
                getData();
            }).catch(err => {console.log(err); window.alert("Hệ thống đã lỗi, vui lòng thử lại sau")});
        }
    }
    

    return(
        <div>
            {post && <PostItem images={post.post_images}
                    content={post.content}
                    createdAt={post.create_at}
                    hashtags={post.hashtag}
                    user={post.user}
                    vote={post.vote}
                    like={post.like}
                    comments_list={commentList}
                    getListComment={getCommentList}
                    isAllowedToComments={allowComment}
                    handleLike={handleLike}
                    id={post.id} />}
        </div>
    )
}