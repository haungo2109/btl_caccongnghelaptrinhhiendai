import { useEffect, useState } from "react"
import api from "../../api/apiCalls"
import PostItem from "./post-item";
import './post.css'

export default function Posts() {

    const [posts, setPosts] = useState([]);
    const [loading, setLoading] = useState(true);
    const [curentPage, setCurrentPage] = useState(1);

    useEffect(() => {
        api.post.getListByPage().then((data) => {
            console.log(data.results)
            setPosts(data.results)
        })
    }, [])

    return(
        <div className="posts-container">
            {posts.map((p) => {
                return <PostItem key={p.id} content={p.content} createdAt={p.create_at} hashtags={p.hashtag} user={p.user} vote={p.vote} id={p.id}/>
            })}
        </div>
    )
}