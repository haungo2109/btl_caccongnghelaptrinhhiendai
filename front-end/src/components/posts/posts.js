import { useEffect, useState } from "react"
import api from "../../api/apiCalls"

export default function Posts() {

    const [posts, setPosts] = useState([]);
    const [curentPage, setCurrentPage] = useState(1);

    useEffect(() => {
        api.post.getListByPage().then((data) => {
            // setPosts(data.result)
            console.log(data);
        })
    }, [])

    
    return(
        <div>
            <p>posts</p>
        </div>
    )
}