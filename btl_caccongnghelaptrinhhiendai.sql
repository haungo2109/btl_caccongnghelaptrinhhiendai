-- Adminer 4.7.7 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

INSERT INTO `oauth2_provider_accesstoken` (`id`, `token`, `expires`, `scope`, `application_id`, `user_id`, `created`, `updated`, `source_refresh_token_id`, `id_token_id`) VALUES
(1,	'raQ1JYts3QjW2PG32j3LCTW94Cddut',	'2021-08-30 19:44:53.401666',	'read write',	3,	1,	'2021-08-30 09:44:53.402067',	'2021-08-30 09:44:53.402076',	NULL,	NULL),
(2,	'8YZR2neM2vQKMvMAn7HORgHf4gbOVJ',	'2021-08-31 11:02:05.215843',	'read write',	3,	7,	'2021-08-31 01:02:05.216588',	'2021-08-31 01:02:05.216600',	NULL,	NULL),
(3,	'7IudyylHMXJ3LUuDbHplRsWG14ymns',	'2021-08-31 18:40:40.958165',	'read write',	3,	7,	'2021-08-31 08:40:40.959673',	'2021-08-31 08:40:40.959705',	NULL,	NULL);

INSERT INTO `oauth2_provider_refreshtoken` (`id`, `token`, `access_token_id`, `application_id`, `user_id`, `created`, `updated`, `revoked`) VALUES
(1,	'IW3ccfH5JbCSH3VGG92elqu8Vmo25O',	1,	3,	1,	'2021-08-30 09:44:53.402979',	'2021-08-30 09:44:53.402996',	NULL),
(2,	'wn7ogMMTLiApLLMIj7IXwzbZ3TYhsa',	2,	3,	7,	'2021-08-31 01:02:05.219779',	'2021-08-31 01:02:05.219804',	NULL),
(3,	'3G3ZV86kneIrbl6BqrC9q5ODJpP1Vr',	3,	3,	7,	'2021-08-31 08:40:40.971517',	'2021-08-31 08:40:40.971566',	NULL);

INSERT INTO `social_network_auctionimage` (`id`, `image`, `auction_id`) VALUES
(1,	'auction_images/2021/08/BH-Oakmont-211-2nd-st-46-6-1624611939.jpg',	1),
(2,	'auction_images/2021/08/home-banner-2020-02-min.jpg',	1),
(3,	'auction_images/2021/08/99231880.jpg',	1);

INSERT INTO `social_network_hashtagpost` (`id`, `name`) VALUES
(1,	'first post'),
(9,	'firsttime'),
(10,	'ahihi'),
(11,	'alala'),
(12,	'picture');

INSERT INTO `social_network_post` (`id`, `content`, `create_at`, `vote`, `active`, `user_id`) VALUES
(1,	'hello world',	'2021-08-05 09:11:27.824571',	8,	1,	5),
(2,	'nggo vawn',	'2021-08-08 01:49:43.296662',	4,	1,	5),
(3,	'test create post',	'2021-08-31 02:05:11.529444',	0,	1,	7),
(4,	'test create post',	'2021-08-31 02:05:13.711115',	0,	1,	7),
(5,	'test create post',	'2021-08-31 02:09:51.438785',	0,	1,	7),
(6,	'test create post',	'2021-08-31 02:10:08.634839',	0,	1,	7),
(7,	'test create post',	'2021-08-31 02:44:21.852079',	0,	1,	7),
(8,	'test create post',	'2021-08-31 02:52:47.555931',	0,	1,	7),
(9,	'test create post',	'2021-08-31 02:56:54.479912',	0,	1,	7),
(10,	'test create post ddaays ahihihi',	'2021-08-31 03:03:32.992676',	0,	1,	7),
(11,	'test create post ddaays ahihihi',	'2021-08-31 03:04:13.337071',	0,	1,	7),
(12,	'test create post ddaays ahihihi',	'2021-08-31 03:06:57.894895',	0,	1,	7),
(13,	'Ngay hom nay that dep',	'2021-08-31 03:07:14.794353',	0,	1,	7),
(14,	'Test upload many file',	'2021-08-31 03:33:18.528215',	0,	1,	7),
(15,	'Test upload many file',	'2021-08-31 03:33:51.742119',	0,	1,	7),
(16,	'Test upload many file',	'2021-08-31 03:34:23.568292',	0,	1,	7),
(17,	'Test upload 5 file',	'2021-08-31 03:57:39.477108',	0,	1,	7),
(18,	'Test upload 5 file lan 2',	'2021-08-31 04:00:17.742423',	0,	1,	7),
(19,	'Test upload 5 file lan 3',	'2021-08-31 09:04:07.934840',	0,	1,	7),
(20,	'Test upload 5 file lan 4',	'2021-08-31 09:04:47.851701',	0,	1,	7);

INSERT INTO `social_network_post_hashtag` (`id`, `post_id`, `hashtagpost_id`) VALUES
(1,	1,	1),
(2,	9,	9),
(3,	9,	10),
(4,	12,	9),
(5,	12,	10),
(6,	13,	9),
(7,	13,	10),
(8,	14,	9),
(9,	14,	10),
(10,	15,	9),
(11,	15,	10),
(12,	16,	9),
(13,	16,	10),
(14,	17,	9),
(15,	17,	10),
(16,	18,	9),
(17,	18,	10),
(18,	19,	9),
(19,	19,	10),
(20,	19,	11),
(21,	20,	12);

INSERT INTO `social_network_postimage` (`id`, `image`, `post_id`) VALUES
(1,	'post_images/2021/08/thumb-1920-161457.jpg',	1),
(2,	'post_images/2021/08/119170527_2035657669902648_1262318113764188233_o.png',	1),
(3,	'post_images/2021/08/images.jpeg',	2),
(4,	'post_images/2021/08/home-banner-2020-02-min.jpg',	2),
(5,	'post_images/2021/08/e5d058e4258bacbde1bf75874bd459f8.jpg',	18),
(6,	'post_images/2021/08/142d78192fda46d5b58e14c9d3f2fe51.jpg',	18),
(7,	'post_images/2021/08/spring-overview.png',	18),
(8,	'post_images/2021/08/covi19.jpg',	18),
(9,	'post_images/2021/08/images_FgkbNKW.jpeg',	18),
(10,	'post_images/2021/08/Screenshot_from_2021-08-30_15-21-58.png',	20);

INSERT INTO `social_network_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `phone`, `avatar`, `address`, `birthday`) VALUES
(1,	'pbkdf2_sha256$260000$qQh4sfjYrHmQxoLvJJfyf9$few37ayqiXuHlAA8daiQK8/J1K24Vzfk/jH+giH4Kok=',	'2021-08-31 02:30:42.145138',	1,	'admin',	'',	'',	'ngovanhau1999@gmail.com',	1,	1,	'2021-08-05 07:46:02.456611',	NULL,	'',	NULL,	NULL),
(5,	'haungo',	'2021-08-05 08:39:19.000000',	0,	'haungo',	'Hau',	'Ngo',	'ngovanhau1999@gmail.com',	0,	1,	'2021-08-05 08:38:36.000000',	'0383793662',	'avatar/user_haungo/suc_khoa.jpg',	'thon 10 Bom Bo',	'2000-10-02'),
(6,	'dungly',	NULL,	0,	'dungly',	'Dung',	'Ly',	'1851050025dung@ou.edu.vn',	0,	1,	'2021-08-05 09:14:47.000000',	'0123456789',	'avatar/user_dungly/ahihi.jpeg',	'TP HCM',	'2000-01-01'),
(7,	'pbkdf2_sha256$260000$Ti8f6dDOewMBC1l8DMlr1D$jJv7GIWnrw1Nwbp34DGrJEdp3+ElWgEr4gjhFOYnNPI=',	NULL,	0,	'haungo1',	'Hau',	'Ngo Van',	'ngovanhau@gmail.com',	0,	1,	'2021-08-31 01:00:36.757159',	NULL,	'avatar/user_haungo1/e5d058e4258bacbde1bf75874bd459f8.jpg',	NULL,	NULL);

-- 2021-08-31 09:30:46
