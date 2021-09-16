import { useEffect, useState } from 'react'
import { useStore } from 'react-redux';
import { Route, Switch, useHistory, useRouteMatch } from 'react-router';
import auctionApi from '../../api/auctionApi'
import ProtectedRoute from '../../route/protected-route';
import AuctionItem from './auction-item';
import AuctionMaker from './auction-maker';
import './auction.css'

export default function Auctions() {

    const [auctions, setAuctions] = useState([]);
    let store = useStore();
    let user = store.getState();
    let {path, url} = useRouteMatch();
    let history = useHistory();
    let createAuctionEl;

    useEffect( () => {
        auctionApi.getAuctions().then(data => {
            // console.log(data.results)
            setAuctions(data.results);
        })
    }, [])

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

    return (
        <div className="posts-body-container">
            <Switch> 
                <ProtectedRoute path={`${path}/create`}>
                    <AuctionMaker />
                </ProtectedRoute>
                <Route exact path={path}>
                    {createAuctionEl}
                    {auctions && auctions.map(a => <AuctionItem key={a.id} auction={a} />)}
                </Route>
            </Switch>
        </div>
    )
}