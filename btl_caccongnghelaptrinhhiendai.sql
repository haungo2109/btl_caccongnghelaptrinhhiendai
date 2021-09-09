-- Adminer 4.7.7 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

TRUNCATE `social_network_auction`;
INSERT INTO `social_network_auction` (`id`, `content`, `create_at`, `title`, `active`, `vote`, `base_price`, `condition`, `deadline`, `accept_price`, `status_auction`, `user_id`, `category_id`, `buyer_id`, `date_success`) VALUES
(1,	'Bán nhà gây quỹ vào từ thiện 50% lợi nhuận',	'2021-08-05 10:17:24.962753',	'Auction',	1,	0,	1000,	'NOP',	'2021-09-10 09:11:27.000000',	20000,	'succ',	7,	2,	7,	'2021-09-04 03:39:25.139497'),
(2,	'comment auction',	'2021-09-02 08:57:07.206073',	'ahihi',	1,	0,	1000,	'no',	'2020-10-02 00:00:00.000000',	0,	'being auctioned',	7,	1,	NULL,	NULL),
(7,	'ahihi lan 2',	'2021-09-02 09:30:59.647487',	'test',	1,	1,	0,	'no',	'2020-02-02 00:00:00.000000',	0,	'being auctioned',	7,	1,	NULL,	NULL),
(8,	'nop',	'2021-09-02 10:14:21.359787',	'huhu',	1,	0,	1000,	'no',	'2020-10-03 00:00:00.000000',	0,	'being auctioned',	7,	2,	NULL,	NULL),
(9,	'ahihihihihihihi',	'2021-09-03 02:27:53.990976',	'ahihih',	1,	0,	0,	'no',	'2020-02-02 00:00:00.000000',	0,	'being auctioned',	7,	2,	NULL,	NULL),
(10,	'nopnopnopnop',	'2021-09-03 02:39:04.997890',	'huhuhuhuhuhu',	1,	0,	10,	'no',	'2020-10-03 00:00:00.000000',	0,	'being auctioned',	7,	2,	NULL,	NULL),
(12,	'Ahihi',	'2021-09-03 07:02:21.233534',	'Alala',	1,	0,	0,	'no',	'2020-02-02 12:00:00.000000',	0,	'being auctioned',	7,	1,	NULL,	NULL),
(13,	'change path static 1111111',	'2021-09-03 07:03:27.958068',	'huhuhuhuhuhu',	1,	0,	10,	'no',	'2020-10-03 00:00:00.000000',	0,	'being auctioned',	7,	2,	NULL,	NULL),
(14,	'change path static 1111111',	'2021-09-03 07:04:33.685324',	'huhuhuhuhuhu',	1,	0,	10,	'no',	'2020-10-03 00:00:00.000000',	0,	'being auctioned',	7,	2,	NULL,	NULL),
(15,	'change path static 1111111',	'2021-09-03 07:06:39.621430',	'huhuhuhuhuhu',	1,	0,	10,	'no',	'2020-10-03 12:00:00.000000',	0,	'being auctioned',	7,	2,	NULL,	NULL),
(16,	'change path static 1111111',	'2021-09-03 10:19:55.407666',	'huhuhuhuhuhu',	1,	0,	10,	'no',	'2020-10-03 12:00:00.000000',	0,	'being auctioned',	7,	2,	NULL,	NULL),
(17,	'change path static 1111111',	'2021-09-03 10:25:14.815380',	'huhuhuhuhuhu',	1,	0,	10,	'no',	'2020-10-03 12:00:00.000000',	0,	'being auctioned',	7,	2,	NULL,	NULL);

TRUNCATE `social_network_auctionimage`;
INSERT INTO `social_network_auctionimage` (`id`, `image`, `auction_id`) VALUES
(1,	'auction_images/2021/08/BH-Oakmont-211-2nd-st-46-6-1624611939.jpg',	1),
(2,	'auction_images/2021/08/home-banner-2020-02-min.jpg',	1),
(3,	'auction_images/2021/08/99231880.jpg',	1),
(8,	'auction_images/2021/09/covi19.jpg',	7),
(9,	'auction_images/2021/09/Screenshot_from_2021-08-23_10-06-00.png',	8),
(10,	'auction_images/2021/09/142d78192fda46d5b58e14c9d3f2fe51_8q5gfvq.jpg',	9),
(11,	'auction_images/2021/09/Screenshot_from_2021-08-23_10-06-00_uudzCoE.png',	10),
(12,	'auction_images/2021/09/Screenshot_from_2021-08-30_15-21-58.png',	10),
(14,	'static/auction_images/2021/09/142d78192fda46d5b58e14c9d3f2fe51_fJggykG.jpg',	12),
(15,	'static/auction_images/2021/09/119170527_2035657669902648_1262318113764188233_o.png',	13),
(16,	'static/auction_images/2021/09/119170527_2035657669902648_1262318113764188233_o_udZMTLY.png',	14),
(17,	'static/auction_images/2021/09/119170527_2035657669902648_1262318113764188233_o_0Apv4mx.png',	15);

TRUNCATE `social_network_auctionreport`;
INSERT INTO `social_network_auctionreport` (`id`, `content`, `create_at`, `type_id`, `auction_id`, `user_id`) VALUES
(1,	'Như đùa v',	'2021-09-05 03:07:08.871773',	2,	9,	7),
(2,	'ahhihihihi',	'2021-09-05 03:29:43.619261',	2,	1,	NULL),
(3,	'ahhihihihi',	'2021-09-05 03:33:12.237831',	2,	16,	NULL),
(4,	'ahhihihihi',	'2021-09-05 03:50:50.167627',	2,	17,	7);

TRUNCATE `social_network_categoryauction`;
INSERT INTO `social_network_categoryauction` (`id`, `name`) VALUES
(1,	'Bất động sản'),
(2,	'Nhà cửa'),
(3,	'Vận dụng Nội thất'),
(4,	'Xe cộ'),
(5,	'Nghệ thuật'),
(6,	'Đồ cổ');

TRUNCATE `social_network_hashtagpost`;
INSERT INTO `social_network_hashtagpost` (`id`, `name`) VALUES
(1,	'first post'),
(9,	'firsttime'),
(10,	'ahihi'),
(11,	'alala'),
(12,	'picture'),
(13,	'lala'),
(14,	'123');

TRUNCATE `social_network_post`;
INSERT INTO `social_network_post` (`id`, `content`, `create_at`, `vote`, `active`, `user_id`) VALUES
(1,	'hello world',	'2021-08-05 09:11:27.824571',	1,	1,	5),
(2,	'nggo vawn',	'2021-08-08 01:49:43.296662',	1,	1,	5),
(18,	'Test upload 5 file lan 2',	'2021-08-31 04:00:17.742423',	0,	1,	7),
(23,	'Post ms taoj de check link url',	'2021-09-07 01:41:27.008694',	0,	1,	7);

TRUNCATE `social_network_post_hashtag`;
INSERT INTO `social_network_post_hashtag` (`id`, `post_id`, `hashtagpost_id`) VALUES
(1,	1,	1),
(16,	18,	9),
(17,	18,	10);

TRUNCATE `social_network_post_like`;
INSERT INTO `social_network_post_like` (`id`, `post_id`, `user_id`) VALUES
(25,	1,	7),
(24,	2,	7);

TRUNCATE `social_network_postcomment`;
INSERT INTO `social_network_postcomment` (`id`, `content`, `create_at`, `vote`, `post_id`, `user_id`) VALUES
(1,	'Ahihi =)))',	'2021-08-05 09:35:00.258944',	0,	1,	5),
(2,	'ahihi',	'2021-09-02 01:18:05.048242',	0,	1,	7),
(3,	'Ahihi comment so 1 cho kan nhe.',	'2021-09-03 10:15:38.673072',	0,	1,	7),
(4,	'Ahihi comment so 1 cho kan nhe. lan 2',	'2021-09-03 10:16:34.375575',	0,	1,	7),
(5,	'Ahihi comment so 1 cho kan nhe. lan 2',	'2021-09-03 10:25:52.256432',	0,	1,	7),
(6,	'Ahihihi',	'2021-09-03 10:33:28.631969',	0,	1,	7),
(7,	'This is a comment with image',	'2021-09-05 01:58:28.178986',	0,	1,	7);

TRUNCATE `social_network_postimage`;
INSERT INTO `social_network_postimage` (`id`, `image`, `post_id`) VALUES
(1,	'static/post_images/2021/08/thumb-1920-161457.jpg',	1),
(2,	'static/post_images/2021/08/119170527_2035657669902648_1262318113764188233_o.png',	1),
(3,	'static/post_images/2021/08/images.jpeg',	2),
(4,	'static/post_images/2021/08/home-banner-2020-02-min.jpg',	2),
(5,	'static/post_images/2021/08/e5d058e4258bacbde1bf75874bd459f8.jpg',	18),
(6,	'static/post_images/2021/08/142d78192fda46d5b58e14c9d3f2fe51.jpg',	18),
(7,	'post_images/2021/08/spring-overview.png',	18),
(8,	'post_images/2021/08/covi19.jpg',	18),
(9,	'post_images/2021/08/images_FgkbNKW.jpeg',	18),
(11,	'static/post_images/2021/09/IMG_8628.jpg',	23),
(12,	'static/post_images/2021/09/IMG_8628.jpg',	1),
(13,	'static/post_images/2021/08/e5d058e4258bacbde1bf75874bd459f8.jpg',	2),
(14,	'static/post_images/2021/08/spring-overview.png',	2),
(15,	'static/post_images/2021/09/IMG_8628.jpg',	2);

TRUNCATE `social_network_reporttype`;
INSERT INTO `social_network_reporttype` (`id`, `name`) VALUES
(1,	'Thông tin sai sự thật'),
(2,	'Spam'),
(3,	'Bán hàng trái phép'),
(4,	'Ngôn từ không đúng chuẩn mực'),
(5,	'Vấn đề khác');

TRUNCATE `social_network_user`;
INSERT INTO `social_network_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `phone`, `avatar`, `address`, `birthday`) VALUES
(1,	'pbkdf2_sha256$260000$qQh4sfjYrHmQxoLvJJfyf9$few37ayqiXuHlAA8daiQK8/J1K24Vzfk/jH+giH4Kok=',	'2021-09-07 14:19:06.782747',	1,	'admin',	'',	'',	'ngovanhau1999@gmail.com',	1,	1,	'2021-08-05 07:46:02.456611',	NULL,	'',	NULL,	NULL),
(5,	'haungo',	'2021-08-05 08:39:19.000000',	0,	'haungo',	'Hau',	'Ngo',	'ngovanhau1999@gmail.com',	0,	1,	'2021-08-05 08:38:36.000000',	'0383793662',	'/static/avatar/user_haungo/suc_khoa.jpg',	'thon 10 Bom Bo',	'2000-10-02'),
(6,	'dungly',	NULL,	0,	'dungly',	'Dung',	'Ly',	'1851050025dung@ou.edu.vn',	0,	1,	'2021-08-05 09:14:47.000000',	'0123456789',	'/static/avatar/user_dungly/ahihi.jpeg',	'TP HCM',	'2000-01-01'),
(7,	'pbkdf2_sha256$260000$Ti8f6dDOewMBC1l8DMlr1D$jJv7GIWnrw1Nwbp34DGrJEdp3+ElWgEr4gjhFOYnNPI=',	NULL,	0,	'haungo1',	'kan',	'haungo',	'ngovanhau@gmail.com',	0,	1,	'2021-08-31 01:00:36.000000',	'0111111111',	'/static/avatar/user_haungo1/e5d058e4258bacbde1bf75874bd459f8.jpg',	'thon 10 Bom Bo',	'2000-10-02'),
(10,	'pbkdf2_sha256$260000$KSQ0njy6Zb0q9XYGOQiXI5$tcRFXfDUsIUAN9PB+h7r58br7s5qCNtoVtaveQ2kTck=',	NULL,	0,	'itouvn',	'IT',	'OUIT',	'IT@ou.edu.vn',	0,	1,	'2021-09-05 09:00:27.115940',	NULL,	'',	NULL,	NULL);

-- 2021-09-09 05:50:32
