import { useStore } from "react-redux";
import { useHistory } from 'react-router';
import Pagination from '../shared/pagination';
import AuctionItem from './auction-item';
import './auction-list.css'

export default function AuctionList({auctions, handleLike, handleDelete, handlePagination, page, totalPage, url}) {
    
    let store = useStore();
    let user = store.getState();
    let history = useHistory();
    let createAuctionEl;

    if(user && user?.username) {
        createAuctionEl = (
            <div className="posts-container">
                <div className="post-item-container" onClick={() => navigate('/create')}>
                    <input className="temp-input" placeholder="Tạo bài đấu giá mới" />
                </div>
            </div>
        )
    }

    let navigate = (path) => {
        history.push(`${url}${path}`)
    }
    
    return(
        <>
            {createAuctionEl}
            {auctions && auctions.map(a => <AuctionItem key={a.id} auction={a} handleLike={handleLike} handleDelete={handleDelete} />)}
            {auctions && 
                    <Pagination 
                        currentPage={page} 
                        count={totalPage} 
                        onClick={handlePagination} 
                    />}
        </>
    )
}