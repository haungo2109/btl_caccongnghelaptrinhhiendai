import { faTimes, faTimesCircle } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { useEffect, useState } from "react"
import { useStore } from "react-redux";
import { Route, Switch, useHistory, useRouteMatch } from "react-router-dom";
import postApi from "../../api/postAPI";
import { useQuery } from "../../App";
import ProtectedRoute from "../../route/protected-route";
import PostList from "./post-list";
import PostMaker from "./post-maker";
import PostOwner from "./post-owner";
import PostSingle from "./post-single";
import './post.css'

let postPerPage = 5;

export default function Posts() {

    let history = useHistory();
    let query = useQuery();
    let {url, path} = useRouteMatch();
    const store = useStore();
    const user = store.getState();
    const [posts, setPosts] = useState([]);
    const [page, setPage] = useState(1);
    const [totalPage, setTotalPage] = useState(1);
    const [hashtag, setHashTag] = useState(null);
    const [loading, setLoading] = useState(true);
    const [init, setInit] = useState(false);
    // const [curentPage, setCurrentPage] = useState(1);

    useEffect(() => {
        if(query.get('tag')) {
            setHashTag(query.get('tag'));
        } else {
            setHashTag(null);
        }
        if(query.get('page')) {
            setPage(query.get('page'))
        } else {
            handleGetListByPage(page);
        }
        setInit(true);
    }, [])

    useEffect(() => {
        if(init) {
            handleGetListByPage(page, true, hashtag);
        }
    }, [page, init, hashtag])

    useEffect(() => {
        if(page !== 0 && hashtag !== null) {
            // handleGetListByPage(page, true, hashtag);
        }
    })

    let handleGetListByPage = (p, rollToTop = true, hashtag = null) => {
        if(rollToTop) {
            window.scrollTo({
                top: 0,
                behavior: "smooth"
            });
        }
        setLoading(true);
        if(hashtag) {
            postApi.getPostsByPage(p, hashtag).then((data) => {
                // console.log(data.results)
                setLoading(false);
                setPosts(data.results)
                if(data.count) {
                    setTotalPage(Math.ceil(data.count / postPerPage));
                }
            })
        } else {
            postApi.getPostsByPage(p).then((data) => {
                // console.log(data.results)
                setLoading(false);
                setPosts(data.results)
                if(data.count) {
                    setTotalPage(Math.ceil(data.count / postPerPage));
                }
            })
        }
        
    }
    let handleClickPagination = (pageNum) => {
        setPage(pageNum);
        let searchParams = new URLSearchParams(window.location.search);
        searchParams.set('page', pageNum);
        history.push({search: searchParams.toString(), pathname: '/posts'})
        // history.push(`/posts?page=${pageNum}`);
    }
    let handleClickingTag = (tag) => {
        setPage(1);
        setHashTag(tag.name);
        let searchParams = new URLSearchParams(window.location.search);
        searchParams.set('tag', tag.name);
        searchParams.set('page', 1);
        history.push({search: searchParams.toString(), pathname: '/posts'})
    }
    let handleCancleSearchByHashTag = () => {
        setPage(1);
        setHashTag(null);
        let searchParams = new URLSearchParams(window.location.search);
        searchParams.delete('tag');
        searchParams.set('page', 1);
        history.push({search: searchParams.toString(), pathname: '/posts'})
    }
    let handleLike = (id, flagLiked) => {
        if(flagLiked) {
            postApi.decreatePostVote(id).then(data => {
                handleGetListByPage(page, false);
            }).catch(err => {console.log(err); window.alert("Hệ thống đã lỗi, vui lòng thử lại sau")});
        } else {
            postApi.increatePostVote(id).then(data => {
                handleGetListByPage(page, false);
            }).catch(err => {console.log(err); window.alert("Hệ thống đã lỗi, vui lòng thử lại sau")});
        }
    }
    let handleDeletePost = (id) => {
        if(window.confirm("Xóa bài viết này ?")) {
            postApi.deletePost(id).then(data => {
                handleGetListByPage(page);
                window.alert('Xóa thành công');
            }).catch(err => {console.log(err); window.alert("Hệ thống đã lỗi, vui lòng thử lại sau")});
        }
    }

    return(
        <div className="posts-body-container">
            <Switch>
                <ProtectedRoute  path={`${path}/create`}>
                    <PostMaker />
                </ProtectedRoute>
                <ProtectedRoute  path={`${path}/owner`}>
                    <PostOwner handleLike={handleLike} handleClickTag={handleClickingTag} />
                </ProtectedRoute>
                <Route path={`${path}/:postid`}>
                    <PostSingle handleClickTag={handleClickingTag} />
                </Route>
                <Route exact path={path}>
                    {hashtag && <div className="posts-container">
                        <div className="post-item-container hashtag-container">
                            <p>
                                <span>{hashtag}</span>
                                <FontAwesomeIcon onClick={handleCancleSearchByHashTag} icon={faTimesCircle} ></FontAwesomeIcon>
                            </p>
                        </div>
                    </div>}
                    <PostList posts={posts} handleLike={handleLike} 
                        handleClickPagination={handleClickPagination} handleDeletePost={handleDeletePost} 
                        page={page} totalPage={totalPage} handleClickTag={handleClickingTag}
                        url={url} />
                </Route>
            </Switch>
        </div>
    )
}