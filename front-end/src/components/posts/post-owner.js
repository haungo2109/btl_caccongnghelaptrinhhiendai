import { useEffect, useState } from "react"
import { useStore } from "react-redux";
import { useHistory, useRouteMatch } from "react-router-dom";
import postApi from "../../api/postAPI";
import { useQuery } from "../../App";
import PostList from "./post-list";
import './post-owner.css'

let postPerPage = 5;

export default function PostOwner({ handleLike, handleClickTag}) {

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
        postApi.getPostOwner(p).then((data) => {
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
        history.push(`/posts/owner?page=${pageNum}`);
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
        <PostList posts={posts} handleLike={handleLike} 
                        handleClickPagination={handleClickPagination} handleDeletePost={handleDeletePost} 
                        page={page} totalPage={totalPage} handleClickTag={handleClickTag}
                        url={url} />
        // <a>{posts}</a>
    )
}