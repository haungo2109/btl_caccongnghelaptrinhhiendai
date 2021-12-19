import axiosClient from './axiosClient';

const config = {
	headers: {
		'Content-Type': 'application/json',
	},
};

const momoApi = {
	getLinkMomoPay: (auctionId, commentId) => {
		const url = '/momopay/linkQR/';
		return axiosClient.get(url, {
			...config,
			params: {
				auctionId,
				commentId,
			},
		});
	},
};

export default momoApi;

// const partnerCode = 'MOMOBDAF20201207';
// const storeId = 'abcdefABCDEF0189';
// const storeSlug = `${partnerCode}-${storeId}`;
// const secretkey = '6VzFAPfP9eGsw47dEPx6FiYqGWete93n';
// const billId = (auctionId, commentId) =>
// 	`auctionId_${auctionId}-commentId_${commentId}`;

// export const getLinkQR = (auctionId, commentId, amount) => {
// 	let orderId = billId(auctionId, commentId);
// 	const signature = crypto.HmacSHA256(
// 		`storeSlug=${storeSlug}&amount=${amount}&billId=${orderId}`,
// 		secretkey
// 	);
// 	const url = `https://test-payment.momo.vn/pay/store/${storeSlug}?a=${amount}&b=${orderId}&s=${signature}`;
// 	return url;
// };