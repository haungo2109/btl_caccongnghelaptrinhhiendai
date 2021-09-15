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
        console.log(postid)
        if(postid) {
            postApi.getPost(postid).then(data => {
                setPost(data);
            }).catch(err => console.log(err));
            getCommentList();
        }
    }, []);

    let getCommentList = () => {
        postApi.getPostComment(postid).then(data => {
            setCommentList(data);
            return true;
        }).catch(err => {
            console.log(err); 
            return false;
        });
    }
    if(user && user?.username) {
        setAllowComment(true);
    }

    return(
        <div>
            {post && <PostItem images={post.post_images}
                    content={post.content}
                    createdAt={post.create_at}
                    hashtags={post.hashtag}
                    user={post.user}
                    vote={post.vote}
                    comments_list={commentList}
                    getListComment={getCommentList}
                    isAllowedToComments={allowComment}
                    id={post.id} />}
        </div>
    )
}