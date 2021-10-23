import moment from 'moment'
import './page-list-item.css'

export function ListItem({item, onClick, route}) {
    return (
        <div className="list-item" onClick={() => onClick(item.id, route)}>
            <div className="content">
                <p>{item.content}</p>
            </div>
            <div className="btm">
                <p>
                    <span>Ngày: </span>
                    { moment(item.createdAt).format("DD/MM/YYYY") }
                </p>
            </div>
        </div>
    )
}

export default function PageListItems({list, handleClick, route}) {
    return(
        <div className="list-container">
            {list && list.map(l => <ListItem route={route} item={l} key={l.id} onClick={handleClick} ></ListItem>)}
        </div>
    )
}