import { useEffect } from 'react';
import { useStore } from 'react-redux';
import { useParams } from 'react-router';
import { useState } from 'react/cjs/react.development';
import auctionApi from '../../api/auctionApi';
import AuctionItem from './auction-item';
import './auction-single.css'

export default function AuctionSingle() {

    let store = useStore();
    let user = store.getState();
    let { auctionid } = useParams();
    const [auction, setAuction] = useState(null);
    const [allowComment, setAllowComment] = useState(false);
    const [commentList, setCommentList] = useState('');

    useEffect(() => {
        // console.log(postid)
        if(auctionid) {
            auctionApi.getAuction(auctionid).then(data => {
                setAuction(data);
            }).catch(err => console.log(err));
            getCommentList();
        }
        if(user && user?.username) {
            setAllowComment(true);
        }
    }, [user, auctionid]);

    // khi comment xoong -> reload list coomment -> reset comment
    let getCommentList = () => {
        auctionApi.getAuctionComment(auctionid).then(data => {
            setCommentList(data);
            return true;
        }).catch(err => {
            console.log(err); 
            window.alert('Bình luận thất bại, vui lòng thử lại sau')
            return false;
        });
    }
    

    return(
        <div>
            {auction && <AuctionItem key={auction.id} auction={auction} isAllowedToComments={allowComment} comments_list={commentList} getListComment={getCommentList} />}
        </div>
    )
}