import { useStore } from "react-redux";
import { useHistory } from 'react-router';
import { useEffect, useState } from "react/cjs/react.development";
import reportApi from "../../api/reportApi";
import Pagination from '../shared/pagination';
import AuctionItem from './auction-item';
import './auction-list.css'

export default function AuctionList({auctions, handleLike, handleDelete, handlePagination, page, totalPage, url}) {
    
    let store = useStore();
    let user = store.getState();
    let history = useHistory();
    let createAuctionEl;
    const [listType, setListType] = useState([])

    useEffect(() => {
        reportApi.getReportType().then(data => {
            setListType(data.results);
        }).catch(err => console.log(err));
    }, [])

    if(user && user?.username) {
        createAuctionEl = (
            <div className="posts-container">
                <div className="post-item-container" onClick={() => navigate('/auctions/create')}>
                    <input className="temp-input" placeholder="Tạo bài đấu giá mới" />
                </div>
            </div>
        )
    }

    let navigate = (path) => {
        history.push(`${path}`)
    }
    
    return(
        <>
            {createAuctionEl}
            {auctions.length != 0 && auctions.map(a => <AuctionItem key={a.id} auction={a} handleLike={handleLike} handleDelete={handleDelete} listReportType={listType} />)}
            {auctions.length == 0 && (
                <div className="post-item-container">
                    <p className="list-empty">Danh sách rỗng</p>
                </div>
                )
            }
            {auctions && 
                    <Pagination 
                        currentPage={page} 
                        count={totalPage} 
                        onClick={handlePagination} 
                    />}
        </>
    )
}