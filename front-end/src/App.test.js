import { render, screen } from '@testing-library/react';
import App from './App';

test('renders learn react link', () => {
  render(<App />);
  const linkElement = screen.getByText(/learn react/i);
  expect(linkElement).toBeInTheDocument();
});

import {
	faBell,
	faCalendarAlt,
	faComment,
	faDollarSign,
	faHeart,
} from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import moment from 'moment';
import { useEffect, useState } from 'react';
import { useStore } from 'react-redux';
import { useHistory } from 'react-router';
import auctionApi from '../../api/auctionApi';
import momoApi from '../../api/momoApi';
import reportApi from '../../api/reportApi';
import ImgViewer from '../shared/img-viewer';
import PostUtil from '../shared/post-utils';
import ReportDialog from '../shared/report-dialog';
import AuctionComment from './auction-comment';
import AuctionCommentList from './auction-comments-list';
import './auction-item.css';

const nameAuctionStatus = {
	'being auctioned': 'Đang đấu giá',
	'in process': 'Đang giao dịch',
	fail: 'Đã hủy',
	succ: 'Thành công',
};

function SmallConditionItem({ className, text, title, icon }) {
	return (
		<div className="small-cond-item">
			<div>
				<FontAwesomeIcon
					className={className ? className : ''}
					icon={icon}
				/>
			</div>
			<span>{title}</span>
			<span>{text}</span>
		</div>
	);
}

export default function AuctionItem({
	auction,
	comments_list,
	isAllowedToComments = false,
	getListComment,
	handleLike,
	handleDelete,
	listReportType,
	handleSelectWinnerForAuction,
}) {
	let history = useHistory();
	let store = useStore();
	let user = store.getState();
	const [comment, setComment] = useState('');
	const [price, setPrice] = useState(0);
	const [dialogState, setDialogState] = useState(false);
	const [openUtils, setOpenUtils] = useState(false);

	const showQR = async () => {
		let linkQR = await momoApi
			.getLinkMomoPay(auction.id, comments_list[0].id)
			.then((res) => res.url);
		return (
			<>
				<button className="button-pay">
					Quét mã MOMO để thanh toán
				</button>
				<div style={{ margin: '0 auto' }}>
					<img
						src={`https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${linkQR}`}
					/>
				</div>
			</>
		);
	};
	let utilItems = [];
	if (user && user.id == auction.user.id) {
		utilItems.push({ name: 'Chỉnh sửa bài', action: () => handleEdit() });
		utilItems.push({
			name: 'Xóa bài bài',
			action: () => handleDelete(auction.id),
		});
	} else {
		utilItems.push({ name: 'Báo cáo', action: () => setDialogState(true) });
	}
	//utils
	let handleEdit = () => {
		history.push({
			pathname: '/auctions/create',
			search: `?id=${auction.id}`,
		});
	};
	let move = (route) => {
		!comments_list && history.push(route);
	};
	let handleOpenUtils = (value) => {
		setOpenUtils(value);
	};
	// comments
	let sendComment = () => {
		if (comment.length === 0 || price <= 0) {
			window.alert('Vui lòng nhập đầy đủ thông tin');
			return;
		}
		let form = new FormData();
		form.set('content', comment);
		form.set('price', price);
		auctionApi
			.createAuctionComment(auction.id, form)
			.then((data) => {
				window.alert('Đấu giá thành công');
				getListComment();
				setComment('');
				setPrice(0);
			})
			.catch((err) => {
				console.log(err);
				return false;
			});
	};
	let handleOnKeyDown = (e) => {
		if (e.key === 'Enter') {
			sendComment();
		}
	};
	// tool bar
	let checkIfLiked = () => {
		if (auction.like.includes(user.id)) {
			return 'liked';
		}
	};
	let handleClickLike = () => {
		if (auction.like.includes(user.id)) {
			handleLike(auction.id, true);
		} else {
			handleLike(auction.id, false);
		}
	};
	//handle dialogs
	let handleCloseReportDialog = (value) => {
		if (value.action == 'confirm') {
			reportApi
				.postReportAuction({
					type: value.type,
					content: value.content,
					auction: auction.id,
				})
				.then((data) => {
					window.alert('Báo cáo thành công');
				})
				.catch((err) =>
					window.alert('Báo cáo thất bại, vui lòng thử lại sau')
				);
		}
		setDialogState(false);
		setOpenUtils(false);
	};

	return (
		<div className="post-item-container auction-item-container">
			<div className="utils">
				<PostUtil
					listItem={utilItems}
					handleClick={handleOpenUtils}
					isOpen={openUtils}
				/>
				<ReportDialog
					state={dialogState}
					handleClose={handleCloseReportDialog}
					listType={listReportType}
				></ReportDialog>
			</div>
			<div className="title">
				<h2 onClick={() => move(`/auctions/${auction.id}`)}>
					{auction.title}
				</h2>
			</div>
			<div className="avatar auction-avatar">
				<div className="avatar-body">
					<p>Bởi {auction.user.full_name}</p>
					<div className="date">
						<p>
							{moment(auction.createdAt).format(
								'DD/MM/YYYY - h:mm a'
							)}
						</p>
					</div>
				</div>
			</div>
			<div className="price">
				<div>
					<SmallConditionItem
						title="Trạng thái: "
						text={nameAuctionStatus[auction.status_auction]}
						icon={faBell}
						className="dark-grey"
					/>
					<SmallConditionItem
						title="Thời gian: "
						text={moment(auction.deadline).format('DD/MM/YYYY')}
						icon={faCalendarAlt}
					/>
				</div>
				<div>
					<SmallConditionItem
						title="Giá chấp nhận: "
						text={auction.accept_price}
						icon={faDollarSign}
						className="green"
					/>
					<SmallConditionItem
						title="Giá bắt đầu: "
						text={auction.base_price}
						icon={faDollarSign}
						className="green"
					/>
				</div>
			</div>
			<div className="content">
				<p>{auction.content}</p>
			</div>
			{auction.buyer && (
				<div className="buyer">
					<div>
						<h3>Người thắng cuộc:</h3>
						<div className="inner-container">
							<div className="avatar-img">
								<img
									src={auction.buyer.avatar}
									alt="img"
									title={`Người dùng: ${auction.buyer.full_name}`}
								/>
							</div>
							<p>{auction.buyer.full_name}</p>
						</div>
					</div>
				</div>
			)}
			<div className="wrapper-image">
				{auction.auction_images.length != 0 && (
					<ImgViewer imgArray={auction.auction_images} />
				)}
			</div>
			<div className="tool-bar">
				<div
					className="likes card"
					title="Thích"
					onClick={() => handleClickLike()}
				>
					<p className={checkIfLiked()}>
						<FontAwesomeIcon icon={faHeart} />
						{auction.like.length} lượt thích
					</p>
				</div>
				<div
					className="commends card"
					title="Bình luận"
					onClick={() => move(`/auctions/${auction.id}`)}
				>
					<p>
						<FontAwesomeIcon icon={faComment} />
						Bình luận
					</p>
				</div>
			</div>
			{isAllowedToComments &&
				auction.status_auction == 'being auctioned' && (
					<div>
						<AuctionComment
							onComment={(e) => setComment(e.target.value)}
							commentText={comment}
							onClick={sendComment}
							onKeyDown={handleOnKeyDown}
							price={price}
							onCommentPrice={(e) => setPrice(e.target.value)}
						/>
					</div>
				)}
			{comments_list && auction.buyer == null && (
				<div>
					<AuctionCommentList
						listComment={comments_list}
						auction={auction}
						handleSelectWinner={handleSelectWinnerForAuction}
					/>
				</div>
			)}
			{auction.user.id !== user.id &&
			comments_list[0] &&
			comments_list[0].status_transaction === 'in process'
				? showQR()
				: null}
		</div>
	);
}