
import './main-page.css'
import { useHistory } from 'react-router';
import { useEffect } from 'react';
import postApi from '../../api/postAPI';
import { useState } from 'react';
import auctionApi from '../../api/auctionApi';
import PageListItems from './page-list-item';

export default function MainPage() {

    const [listPosts, setListPosts] = useState([]);
    const [listAuctions, setListAuctions] = useState([]);

    const history = useHistory();

    let moveTo = (id, route) => {
        if(id) {
            history.push(`${route}/${id}`)
        } else {
            history.push(`${route}`)
        }
    }

    useEffect(() => {
        postApi.getPostsByPage(1).then(data => {
            setListPosts(data.results);
        }).catch(err => console.log(err));
        auctionApi.getAuctionsByPage(1).then(data => {
            setListAuctions(data.results);
        }).catch(err => console.log(err));
    }, [])

    return (
        <div className="body">
            <div className="main-text-container">
                <div>
                    <div>
                        <h1>Chào mừng đến với mạng xã hội</h1>
                        <p>Nơi bạn có thể thể hiện bản thân và chia sẽ với nhiều người dùng khác</p>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ante massa, congue in viverra id, pretium eu nulla. Quisque hendrerit a nunc in facilisis.</p>
                    </div>
                    <div className="main-text-side-pannel-container">
                        <div>
                            <h3>Đã có tài khoản? </h3>
                            <span  onClick={ () => moveTo(null,"/login")} >Đăng nhập ngay</span>
                        </div>
                        <div>
                            <h3>Chưa có tài khoản? </h3>
                            <span onClick={ () => moveTo(null,"/register")} >Đăng ký tại đây</span>
                        </div>
                    </div>
                </div>
            </div>
            <div className="items-container">
                <div>
                    <h2>Bài đăng nổi bật <span onClick={ () => moveTo(null,"/posts")} >Xem thêm</span> </h2>
                    <PageListItems list={listPosts} route={"/posts"} handleClick={moveTo} />
                </div>
                <div>
                    <h2>Bài đấu giá nổi bật  <span onClick={ () => moveTo(null,"/auctions")} >Xem thêm</span> </h2>
                    <PageListItems list={listAuctions} route={"/auctions"} handleClick={moveTo} />
                </div>
            </div>
            <div className="footer">
                <div className="footer-1">
                    <h3>Liên lạc</h3>
                    <p>Facebook</p>
                    <p>Twitter</p>
                    <p>Youtube</p>
                </div>
                <div className="footer-2">
                    <h3>FAQ</h3>
                    <p>Vì sao tôi nên chọn trang này ?</p>
                    <p>Hỗ trợ kĩ thuật</p>
                </div>
                <div className="footer-3">
                    <h3>Về chúng tôi</h3>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ante massa, congue in viverra id, pretium eu nulla. Quisque hendrerit a nunc in facilisis.</p>
                </div>
            </div>
        </div>
    )
}