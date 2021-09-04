import { useEffect, useState } from "react"
import { useStore } from "react-redux";
import { Route, Switch, useHistory, useRouteMatch } from "react-router-dom";
import api from "../../api/apiCalls"
import ProtectedRoute from "../../route/protected-route";
import PostItem from "./post-item";
import PostMaker from "./post-maker";
import './post.css'

export default function Posts() {

    let history = useHistory();
    let {url, path} = useRouteMatch();
    const store = useStore();
    const user = store.getState();
    const [posts, setPosts] = useState([]);
    const [loading, setLoading] = useState(true);
    // const [curentPage, setCurrentPage] = useState(1);

    let createPostEl;

    useEffect(() => {
        setLoading(true);
        api.post.getListByPage().then((data) => {
            // console.log(data.results)
            setLoading(false);
            setPosts(data.results)
        })
    }, [])

    let navigate = (path) => {
        history.push(`${url}${path}`)
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
                    </div>
                </Route>
            </Switch>
        </div>
    )
}