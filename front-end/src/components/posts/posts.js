import { useEffect, useState } from "react"
import { useStore } from "react-redux";
import { Route, Switch, useHistory, useRouteMatch } from "react-router-dom";
import postApi from "../../api/postAPI";
import { useQuery } from "../../App";
import ProtectedRoute from "../../route/protected-route";
import Pagination from "../shared/pagination";
import PostItem from "./post-item";
import PostMaker from "./post-maker";
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

    let createPostEl;

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
    }, [page])

    let navigate = (path) => {
        history.push(`${url}${path}`)
    }

    let handleGetListByPage = (p) => {
        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });
        setLoading(true);
        postApi.getPostsByPage(p).then((data) => {
            // console.log(data.results)
            setLoading(false);
            setPosts(data.results)
            if(data.count) {
                setTotalPage(Math.round(data.count / postPerPage));
            }
        })
    }
    let handleClickPagination = (pageNum) => {
        setPage(pageNum);
        // console.log(pageNum)
        history.push(`/posts?page=${pageNum}`);
    }

    if(user && user?.username) {
        createPostEl = (
            <div className="posts-container">
                <div className="post-item-container" onClick={() => navigate('/create')}>
                    <input className="temp-input" placeholder="Tạo bài viết mới" />
                </div>
            </div>
        )
    }

    return(
        <div className="posts-body-container">
            <Switch>
                <ProtectedRoute  path={`${path}/create`}>
                    <PostMaker />
                </ProtectedRoute>
                <Route path={`${path}/:postid`}>
                    <PostSingle />
                </Route>
                <Route exact path={path}>
                    {createPostEl}
                    <div className="posts-container">
                        {posts.map((p) => {
                            return (
								<PostItem
									key={p.id}
									images={p.post_images}
									content={p.content}
									createdAt={p.create_at}
									hashtags={p.hashtag}
									user={p.user}
									vote={p.vote}
									id={p.id}
								/>
							);
                        })}
                        {posts && 
                            <Pagination 
                                currentPage={page} 
                                count={totalPage} 
                                onClick={handleClickPagination} 
                            />}
                    </div>
                </Route>
            </Switch>
        </div>
    )
}