const { createProxyMiddleware } = require('http-proxy-middleware');

module.exports = function (app) {
	app.use(
		['/static/avatar/', '/static/auction_images/', '/static/post_images/'],
		createProxyMiddleware({
			target: 'http://localhost:8000',
			changeOrigin: true,
		})
	);
};
