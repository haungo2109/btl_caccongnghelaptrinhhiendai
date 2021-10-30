import { useEffect, useState } from "react"
import { useStore } from "react-redux";
import { Route, Switch, useHistory, useRouteMatch } from "react-router-dom";
import postApi from "../../api/postAPI";
import { useQuery } from "../../App";
import ProtectedRoute from "../../route/protected-route";
import Pagination from "../shared/pagination";
import PostItem from "./post-item";
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
    const [loading, setLoading] = useState(true);
    const [init, setInit] = useState(false);
    // const [curentPage, setCurrentPage] = useState(1);

    useEffect(() => {
        if(query.get('page')) {
            setPage(query.get('page'))
        } else {
            handleGetListByPage(page);
        }
        setInit(true);
    }, [])

    useEffect(() => {
        if(init) {
            handleGetListByPage(page);
        }
    }, [page, init])

    let handleGetListByPage = (p, rollToTop = true) => {
        if(rollToTop) {
            window.scrollTo({
                top: 0,
                behavior: "smooth"
            });
        }
        setLoading(true);
        postApi.getPostsByPage(p).then((data) => {
            // console.log(data.results)
            setLoading(false);
            setPosts(data.results)
            if(data.count) {
                setTotalPage(Math.ceil(data.count / postPerPage));
            }
        })
    }
    let handleClickPagination = (pageNum) => {
        setPage(pageNum);
        // console.log(pageNum)
        history.push(`/posts?page=${pageNum}`);
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
                    <PostOwner handleDelete={handleDeletePost} handleLike={handleLike} />
                </ProtectedRoute>
                <Route path={`${path}/:postid`}>
                    <PostSingle />
                </Route>
                <Route exact path={path}>
                    <PostList posts={posts} handleLike={handleLike} 
                        handleClickPagination={handleClickPagination} handleDeletePost={handleDeletePost} 
                        page={page} totalPage={totalPage}
                        url={url} />
                </Route>
            </Switch>
        </div>
    )
}