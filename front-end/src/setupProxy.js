const { createProxyMiddleware } = require('http-proxy-middleware');

module.exports = function (app) {
	app.use(
		['/static/avatar/', '/static/auction_images/', '/static/post_images/'],
		createProxyMiddleware({
			target: 'http://192.168.1.21:5000/',
			changeOrigin: true,
		})
	);
};
