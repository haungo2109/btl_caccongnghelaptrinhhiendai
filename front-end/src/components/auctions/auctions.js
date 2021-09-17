import { useEffect, useState } from 'react'
import { useStore } from 'react-redux';
import { Route, Switch, useHistory, useRouteMatch } from 'react-router';
import auctionApi from '../../api/auctionApi'
import { useQuery } from '../../App';
import ProtectedRoute from '../../route/protected-route';
import Pagination from '../shared/pagination';
import AuctionItem from './auction-item';
import AuctionMaker from './auction-maker';
import './auction.css'

let postPerPage = 5;

export default function Auctions() {

    const [auctions, setAuctions] = useState([]);
    const [init, setInit] = useState(false);
    const [page, setPage] = useState(1);
    const [totalPage, setTotalPage] = useState(1);
    const [loading, setLoading] = useState(true);
    let query = useQuery();
    let store = useStore();
    let user = store.getState();
    let {path, url} = useRouteMatch();
    let history = useHistory();
    let createAuctionEl;

    useEffect( () => {
        
    }, [])

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

    let handleGetListByPage = (p) => {
        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });
        setLoading(true);
        auctionApi.getAuctionsByPage(p).then(data => {
            // console.log(data.results)
            setAuctions(data.results);
            setLoading(false);
            if(data.count) {
                setTotalPage(Math.round(data.count / postPerPage));
            }
        })
    }
    let handleClickPagination = (pageNum) => {
        setPage(pageNum);
        // console.log(pageNum)
        history.push(`/auctions?page=${pageNum}`);
    }

    return (
        <div className="posts-body-container">
            <Switch> 
                <ProtectedRoute path={`${path}/create`}>
                    <AuctionMaker />
                </ProtectedRoute>
                <Route exact path={path}>
                    {createAuctionEl}
                    {auctions && auctions.map(a => <AuctionItem key={a.id} auction={a} />)}
                    {auctions && 
                            <Pagination 
                                currentPage={page} 
                                count={totalPage} 
                                onClick={handleClickPagination} 
                            />}
                </Route>
            </Switch>
        </div>
    )
}