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
    // like
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
    // handle button for auction
    let handleSelectWinnerForAuction = (comment, type = null) => {
        switch(comment.status_transaction) {
            case 'none': 
            if(window.confirm('Xác nhận chọn người dùng này là người thắng cuộc của đấu giá này ?')) {
                auctionApi.changeStateAuctionComment(auction.id,comment.id,"in_process").then(data => {
                    getData();
                    window.alert('Chọn thành công, trạng thái chuyển sang "Đang trong quá trình giao dịch"');
                }).catch(err => {console.log(err); window.alert("Hệ thống đã lỗi, vui lòng thử lại sau")});
            }
            break;

            case 'in process': 
            if(type === 'success') {
                if(window.confirm('Xác nhận giao dịch thành công với người dùng này?')) {
                    auctionApi.changeStateAuctionComment(auction.id,comment.id, 'success').then(data => {
                        getData();
                        window.alert('Xác nhận giao dịch thành công, trạng thái chuyển sang "Giao dịch thất bại". Vui lòng chọn người thắng cuộc khác');
                    }).catch(err => {console.log(err); window.alert("Hệ thống đã lỗi, vui lòng thử lại sau")});
                }
            }
            if(type === 'fail') {
                if(window.confirm('Xác nhận giao dịch thất bại với người dùng này?')) {
                    auctionApi.changeStateAuctionComment(auction.id,comment.id, 'fail').then(data => {
                        getData();
                        window.alert('Xác nhận giao dịch thất bại, trạng thái chuyển sang "Giao dịch thành công"');
                    }).catch(err => {console.log(err); window.alert("Hệ thống đã lỗi, vui lòng thử lại sau")});
                }
            }
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
                    handleSelectWinnerForAuction={handleSelectWinnerForAuction}
                />}
        </div>
    )
}