import { useEffect } from 'react';
import { useStore } from 'react-redux';
import { useHistory, useRouteMatch } from 'react-router';
import { useState } from 'react/cjs/react.development';
import auctionApi from '../../api/auctionApi';
import { useQuery } from '../../App';
import AuctionList from './auction-list'
import './auction-owner.css'

let postPerPage = 5;
export default function AuctionOwner({handleLike, handleDelete}) {

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
        auctionApi.getAuctionOwner(p).then(data => {
            // console.log(data.results)
            setAuctions(data.results);
            setLoading(false);
            if(data.count) {
                setTotalPage(Math.ceil(data.count / postPerPage));
            }
        })
    }
    let handleClickPagination = (pageNum) => {
        setPage(pageNum);
        // console.log(pageNum)
        history.push(`/auctions/owner?page=${pageNum}`);
    }

    let handleDeleteAuctions = (id) => {
        if(window.confirm("Xóa bài đấu giá này ?")) {
            auctionApi.deleteAuction(id).then(data => {
                handleGetListByPage(page);
                window.alert('Xóa thành công');
            }).catch(err => {console.log(err); window.alert("Hệ thống đã lỗi, vui lòng thử lại sau")});
        }
    }

    return(
        <AuctionList auctions={auctions} handlePagination={handleClickPagination} handleLike={handleLike} handleDelete={handleDeleteAuctions}
            url={url} page={page} totalPage={totalPage} >
        </AuctionList>
    )
}