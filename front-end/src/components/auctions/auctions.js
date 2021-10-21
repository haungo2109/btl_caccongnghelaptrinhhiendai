import { useEffect, useState } from 'react'
import { useStore } from 'react-redux';
import { Route, Switch, useHistory, useRouteMatch } from 'react-router';
import auctionApi from '../../api/auctionApi'
import { useQuery } from '../../App';
import ProtectedRoute from '../../route/protected-route';
import Pagination from '../shared/pagination';
import AuctionItem from './auction-item';
import AuctionList from './auction-list';
import AuctionMaker from './auction-maker';
import AuctionOwner from './auction-owner';
import AuctionSingle from './auction-single';
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

    let navigate = (path) => {
        history.push(`${url}${path}`)
    }

    let handleGetListByPage = (p, scroll = true) => {
        if(scroll) {
            window.scrollTo({
                top: 0,
                behavior: "smooth"
            });
        }
        
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
    let handleLike = (id, flagLiked) => {
        if(flagLiked) {
            auctionApi.decreateAuctionVote(id).then(data => {
                handleGetListByPage(page, false);
            }).catch(err => {console.log(err); window.alert("Hệ thống đã lỗi, vui lòng thử lại sau")});
        } else {
            auctionApi.increateAuctionVote(id).then(data => {
                handleGetListByPage(page, false);
            }).catch(err => {console.log(err); window.alert("Hệ thống đã lỗi, vui lòng thử lại sau")});
        }
    }

    let handleDeleteAuctions = (id) => {
        if(window.confirm("Xóa bài viết này ?")) {
            auctionApi.deleteAuction(id).then(data => {
                handleGetListByPage(page);
                window.alert('Xóa thành công');
            }).catch(err => {console.log(err); window.alert("Hệ thống đã lỗi, vui lòng thử lại sau")});
        }
    }

    return (
        <div className="posts-body-container">
            <Switch> 
                <ProtectedRoute path={`${path}/create`}>
                    <AuctionMaker />
                </ProtectedRoute>
                <ProtectedRoute path={`${path}/owner`} >
                    <AuctionOwner handleDelete={handleDeleteAuctions} handleLike={handleLike} />
                </ProtectedRoute>
                <Route path={`${path}/:auctionid`}>
                    <AuctionSingle />
                </Route>
                <Route exact path={path}>
                    <AuctionList auctions={auctions} handlePagination={handleClickPagination} handleLike={handleLike} handleDelete={handleDeleteAuctions}
                        url={url} page={page} totalPage={totalPage} >
                    </AuctionList>
                </Route>
            </Switch>
        </div>
    )
}