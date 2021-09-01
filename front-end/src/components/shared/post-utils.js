import { faEllipsisV } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { Link } from "react-router-dom"
import { useState } from "react/cjs/react.development"
import './post-utils.css'

function PostUtilItem(props) {

    let element;

    if(props.link) {
        element = 
            <p>
                <Link to={props.link} >{props.name}</Link>
            </p>
    } else {
        element = <p onClick={props.action} >{props.name}</p>
    }

    return(
        <div className="util-item">
            {element}
        </div>
    )
}

export default function PostUtil({listItem}) {

    const [open, setOpen] = useState(false);
    let element;

    if(open) {
        element = 
            <div className="post-util-list">
                {listItem && listItem.map(i => {
                    if(i.link)
                        return <PostUtilItem key={i.name} link={i.link} name={i.name} />
                    else 
                        return <PostUtilItem key={i.name} action={i.action} name={i.name} />
                })}
            </div>
    } 

    return(
        <div className="util-container">
            <div className="post-util" onClick={() => setOpen(o => !o)}>
                <FontAwesomeIcon icon={faEllipsisV} ></FontAwesomeIcon>
            </div>
            {element}
        </div>
    )
}