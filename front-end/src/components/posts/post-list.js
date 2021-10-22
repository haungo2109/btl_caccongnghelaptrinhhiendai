import { useEffect } from "react";
import { useStore } from "react-redux";
import { useHistory } from "react-router";
import { useState } from "react/cjs/react.development";
import reportApi from "../../api/reportApi";
import Pagination from "../shared/pagination";
import PostItem from "./post-item";

export default function PostList({posts, handleLike, handleDeletePost, handleClickPagination, page, totalPage, url }) {

    const history = useHistory();
    const store = useStore();
    const user = store.getState();
    let createPostEl;
    const [listType, setListType] = useState([])

    useEffect(() => {
        reportApi.getReportType().then(data => {
            setListType(data.results);
        }).catch(err => console.log(err));
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

    return (
        <>
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
                            like={p.like}
                            vote={p.vote}
                            id={p.id}
                            handleLike={handleLike}
                            handleDelete={handleDeletePost}
                            listReportType={listType}
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
        </>
    )
}