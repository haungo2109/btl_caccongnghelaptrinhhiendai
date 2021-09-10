import { useEffect, useState } from 'react'
import { Route, Switch, useHistory, useRouteMatch } from 'react-router';
import auctionApi from '../../api/auctionApi'
import AuctionItem from './auction-item';
import './auction.css'

export default function Auctions() {

    const [auctions, setAuctions] = useState([]);
    let {url, path} = useRouteMatch();
    let history = useHistory();

    useEffect( () => {
        auctionApi.getAuctions().then(data => {
            console.log(data.results)
            setAuctions(data.results);
        })
    }, [])

    return (
        <div className="posts-body-container">
            <Switch> 
                <Route exact path={path}>
                    {auctions && auctions.map(a => <AuctionItem key={a.id} auction={a} />)}
                </Route>
            </Switch>
        </div>
    )
}