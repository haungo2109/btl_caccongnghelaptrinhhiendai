import { useEffect } from 'react';
import { useStore } from 'react-redux';
import { useHistory, useParams } from 'react-router';
import { useState } from 'react/cjs/react.development';
import auctionApi from '../../api/auctionApi';
import AuctionItem from './auction-item';
import './auction-single.css'

export default function AuctionSingle() {

    let store = useStore();
    let user = store.getState();
    let history = useHistory();
    let { auctionid } = useParams();
    const [auction, setAuction] = useState(null);
    const [allowComment, setAllowComment] = useState(false);
    const [commentList, setCommentList] = useState('');

    useEffect(() => {
        // console.log(postid)
        if(auctionid) {
            getData();
        } else {
            history.goBack();
        }
        
    }, [auctionid]);

    useEffect(() => {
        if(user && user?.username) {
            getCommentList();
            if(auction && user.id !== auction.user.id) {
                setAllowComment(true);
            }
        }
    }, [user, auction])

    let getData = () => {
        auctionApi.getAuction(auctionid).then(data => {
            setAuction(data);
        }).catch(err => console.log(err));
    }
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
    let handleLike = (id, flagLiked) => {
        if(flagLiked) {
            auctionApi.decreateAuctionVote(id).then(data => {
                getData();
            }).catch(err => {console.log(err); window.alert("Hệ thống đã lỗi, vui lòng thử lại sau")});
        } else {
            auctionApi.increateAuctionVote(id).then(data => {
                getData();
            }).catch(err => {console.log(err); window.alert("Hệ thống đã lỗi, vui lòng thử lại sau")});
        }
    }

    return(
        <div>
            {auction && 
                <AuctionItem key={auction.id} 
                    auction={auction} 
                    isAllowedToComments={allowComment} 
                    comments_list={commentList} 
                    getListComment={getCommentList} 
                    handleLike={handleLike} 
                />}
        </div>
    )
}