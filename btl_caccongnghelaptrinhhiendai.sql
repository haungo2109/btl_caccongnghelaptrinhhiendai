-- Adminer 4.7.7 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

INSERT INTO `oauth2_provider_application` (`id`, `client_id`, `redirect_uris`, `client_type`, `authorization_grant_type`, `client_secret`, `name`, `user_id`, `skip_authorization`, `created`, `updated`, `algorithm`) VALUES
(1,	'yfy1heSiajX1jeMY2Uvgj2IBtT4ao8M45s298BpJ',	'',	'confidential',	'password',	'8LfgvcWEjbvzsDhIAM11gyUgck6Ufgf90MhBsT1mN9UreSxF0yn0Q0CfxmYVYshNxi22k5NChWaMkQ9QgFxuOqCGIYYYoj0AYD4VCakA12nJTVZBKK5hMsyyloAnThBB',	'social_network',	1,	0,	'2021-08-30 04:05:11.143745',	'2021-08-30 08:36:55.842076',	'');

INSERT INTO `social_network_auctionimage` (`id`, `image`, `auction_id`) VALUES
(1,	'auction_images/2021/08/BH-Oakmont-211-2nd-st-46-6-1624611939.jpg',	1),
(2,	'auction_images/2021/08/home-banner-2020-02-min.jpg',	1),
(3,	'auction_images/2021/08/99231880.jpg',	1);

INSERT INTO `social_network_post` (`id`, `content`, `create_at`, `vote`, `active`, `user_id`) VALUES
(1,	'hello world',	'2021-08-05 09:11:27.824571',	8,	1,	5),
(2,	'nggo vawn',	'2021-08-08 01:49:43.296662',	4,	1,	5);

INSERT INTO `social_network_postimage` (`id`, `image`, `post_id`) VALUES
(1,	'post_images/2021/08/thumb-1920-161457.jpg',	1),
(2,	'post_images/2021/08/119170527_2035657669902648_1262318113764188233_o.png',	1),
(3,	'post_images/2021/08/images.jpeg',	2),
(4,	'post_images/2021/08/home-banner-2020-02-min.jpg',	2);

INSERT INTO `social_network_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `phone`, `avatar`, `address`, `birthday`) VALUES
(1,	'pbkdf2_sha256$260000$qQh4sfjYrHmQxoLvJJfyf9$few37ayqiXuHlAA8daiQK8/J1K24Vzfk/jH+giH4Kok=',	'2021-08-30 08:23:29.384268',	1,	'admin',	'',	'',	'ngovanhau1999@gmail.com',	1,	1,	'2021-08-05 07:46:02.456611',	NULL,	'',	NULL,	NULL),
(5,	'haungo',	'2021-08-05 08:39:19.000000',	0,	'haungo',	'Hau',	'Ngo',	'ngovanhau1999@gmail.com',	0,	1,	'2021-08-05 08:38:36.000000',	'0383793662',	'avatar/user_haungo/suc_khoa.jpg',	'thon 10 Bom Bo',	'2000-10-02'),
(6,	'dungly',	NULL,	0,	'dungly',	'Dung',	'Ly',	'1851050025dung@ou.edu.vn',	0,	1,	'2021-08-05 09:14:47.000000',	'0123456789',	'avatar/user_dungly/ahihi.jpeg',	'TP HCM',	'2000-01-01');

-- 2021-08-30 08:49:49
