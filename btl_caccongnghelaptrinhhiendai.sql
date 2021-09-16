-- Adminer 4.7.7 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `btl_caccongnghelaptrinhhiendai`;
CREATE DATABASE `btl_caccongnghelaptrinhhiendai` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `btl_caccongnghelaptrinhhiendai`;

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `auth_group`;

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `auth_group_permissions`;

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `auth_permission`;
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1,	'Can add log entry',	1,	'add_logentry'),
(2,	'Can change log entry',	1,	'change_logentry'),
(3,	'Can delete log entry',	1,	'delete_logentry'),
(4,	'Can view log entry',	1,	'view_logentry'),
(5,	'Can add permission',	2,	'add_permission'),
(6,	'Can change permission',	2,	'change_permission'),
(7,	'Can delete permission',	2,	'delete_permission'),
(8,	'Can view permission',	2,	'view_permission'),
(9,	'Can add group',	3,	'add_group'),
(10,	'Can change group',	3,	'change_group'),
(11,	'Can delete group',	3,	'delete_group'),
(12,	'Can view group',	3,	'view_group'),
(13,	'Can add content type',	4,	'add_contenttype'),
(14,	'Can change content type',	4,	'change_contenttype'),
(15,	'Can delete content type',	4,	'delete_contenttype'),
(16,	'Can view content type',	4,	'view_contenttype'),
(17,	'Can add session',	5,	'add_session'),
(18,	'Can change session',	5,	'change_session'),
(19,	'Can delete session',	5,	'delete_session'),
(20,	'Can view session',	5,	'view_session'),
(21,	'Can add user',	6,	'add_user'),
(22,	'Can change user',	6,	'change_user'),
(23,	'Can delete user',	6,	'delete_user'),
(24,	'Can view user',	6,	'view_user'),
(25,	'Can add auction',	7,	'add_auction'),
(26,	'Can change auction',	7,	'change_auction'),
(27,	'Can delete auction',	7,	'delete_auction'),
(28,	'Can view auction',	7,	'view_auction'),
(29,	'Can add post',	8,	'add_post'),
(30,	'Can change post',	8,	'change_post'),
(31,	'Can delete post',	8,	'delete_post'),
(32,	'Can view post',	8,	'view_post'),
(33,	'Can add post report',	9,	'add_postreport'),
(34,	'Can change post report',	9,	'change_postreport'),
(35,	'Can delete post report',	9,	'delete_postreport'),
(36,	'Can view post report',	9,	'view_postreport'),
(37,	'Can add post image',	10,	'add_postimage'),
(38,	'Can change post image',	10,	'change_postimage'),
(39,	'Can delete post image',	10,	'delete_postimage'),
(40,	'Can view post image',	10,	'view_postimage'),
(41,	'Can add post comment',	11,	'add_postcomment'),
(42,	'Can change post comment',	11,	'change_postcomment'),
(43,	'Can delete post comment',	11,	'delete_postcomment'),
(44,	'Can view post comment',	11,	'view_postcomment'),
(45,	'Can add auction report',	12,	'add_auctionreport'),
(46,	'Can change auction report',	12,	'change_auctionreport'),
(47,	'Can delete auction report',	12,	'delete_auctionreport'),
(48,	'Can view auction report',	12,	'view_auctionreport'),
(49,	'Can add auction image',	13,	'add_auctionimage'),
(50,	'Can change auction image',	13,	'change_auctionimage'),
(51,	'Can delete auction image',	13,	'delete_auctionimage'),
(52,	'Can view auction image',	13,	'view_auctionimage'),
(53,	'Can add auction comment',	14,	'add_auctioncomment'),
(54,	'Can change auction comment',	14,	'change_auctioncomment'),
(55,	'Can delete auction comment',	14,	'delete_auctioncomment'),
(56,	'Can view auction comment',	14,	'view_auctioncomment'),
(57,	'Can add category auction',	15,	'add_categoryauction'),
(58,	'Can change category auction',	15,	'change_categoryauction'),
(59,	'Can delete category auction',	15,	'delete_categoryauction'),
(60,	'Can view category auction',	15,	'view_categoryauction'),
(61,	'Can add hash tag post',	16,	'add_hashtagpost'),
(62,	'Can change hash tag post',	16,	'change_hashtagpost'),
(63,	'Can delete hash tag post',	16,	'delete_hashtagpost'),
(64,	'Can view hash tag post',	16,	'view_hashtagpost'),
(65,	'Can add application',	17,	'add_application'),
(66,	'Can change application',	17,	'change_application'),
(67,	'Can delete application',	17,	'delete_application'),
(68,	'Can view application',	17,	'view_application'),
(69,	'Can add access token',	18,	'add_accesstoken'),
(70,	'Can change access token',	18,	'change_accesstoken'),
(71,	'Can delete access token',	18,	'delete_accesstoken'),
(72,	'Can view access token',	18,	'view_accesstoken'),
(73,	'Can add grant',	19,	'add_grant'),
(74,	'Can change grant',	19,	'change_grant'),
(75,	'Can delete grant',	19,	'delete_grant'),
(76,	'Can view grant',	19,	'view_grant'),
(77,	'Can add refresh token',	20,	'add_refreshtoken'),
(78,	'Can change refresh token',	20,	'change_refreshtoken'),
(79,	'Can delete refresh token',	20,	'delete_refreshtoken'),
(80,	'Can view refresh token',	20,	'view_refreshtoken'),
(81,	'Can add id token',	21,	'add_idtoken'),
(82,	'Can change id token',	21,	'change_idtoken'),
(83,	'Can delete id token',	21,	'delete_idtoken'),
(84,	'Can view id token',	21,	'view_idtoken'),
(85,	'Can add cors model',	22,	'add_corsmodel'),
(86,	'Can change cors model',	22,	'change_corsmodel'),
(87,	'Can delete cors model',	22,	'delete_corsmodel'),
(88,	'Can view cors model',	22,	'view_corsmodel'),
(89,	'Can add repost type',	23,	'add_reposttype'),
(90,	'Can change repost type',	23,	'change_reposttype'),
(91,	'Can delete repost type',	23,	'delete_reposttype'),
(92,	'Can view repost type',	23,	'view_reposttype'),
(93,	'Can add report type',	23,	'add_reporttype'),
(94,	'Can change report type',	23,	'change_reporttype'),
(95,	'Can delete report type',	23,	'delete_reporttype'),
(96,	'Can view report type',	23,	'view_reporttype');

DROP TABLE IF EXISTS `corsheaders_corsmodel`;
CREATE TABLE `corsheaders_corsmodel` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cors` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `corsheaders_corsmodel`;

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_social_network_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_social_network_user_id` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `django_admin_log`;
INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1,	'2021-08-05 10:17:24.963877',	'1',	'Bán nhà gây quỹ vào từ thiện 50% lợi nhuận',	1,	'[{\"added\": {}}]',	7,	1),
(2,	'2021-08-05 11:45:32.533388',	'1',	'Bán nhà gây quỹ vào từ thiện 50% lợi nhuận',	2,	'[{\"added\": {\"name\": \"auction image\", \"object\": \"AuctionImage object (1)\"}}, {\"added\": {\"name\": \"auction image\", \"object\": \"AuctionImage object (2)\"}}, {\"added\": {\"name\": \"auction image\", \"object\": \"AuctionImage object (3)\"}}, {\"added\": {\"name\": \"auction comment\", \"object\": \"EM mu\\u1ed1n mua vs gi\\u00e1 1500 nh\\u01b0ng ch\\u1ec9 tr\\u1ea3 trc 500 \\u0111\\u00f4 c\\u00f2n l\\u1ea1i tr\\u1ea3 d\\u1ea7n trong 1 n\\u0103m\"}}]',	7,	1),
(3,	'2021-08-08 01:49:05.270458',	'1',	'first post',	1,	'[{\"added\": {}}]',	16,	1),
(4,	'2021-08-08 01:49:43.302485',	'2',	'nggo vawn',	1,	'[{\"added\": {}}, {\"added\": {\"name\": \"post image\", \"object\": \"PostImage object (3)\"}}, {\"added\": {\"name\": \"post image\", \"object\": \"PostImage object (4)\"}}]',	8,	1),
(5,	'2021-08-09 10:26:41.447950',	'1',	'hello world',	2,	'[{\"changed\": {\"fields\": [\"Hashtag\"]}}]',	8,	1),
(6,	'2021-09-01 08:52:08.948640',	'4',	'test create post',	3,	'',	8,	1),
(7,	'2021-09-01 08:52:08.977685',	'5',	'test create post',	3,	'',	8,	1),
(8,	'2021-09-01 08:52:09.019919',	'6',	'test create post',	3,	'',	8,	1),
(9,	'2021-09-01 08:52:09.050504',	'7',	'test create post',	3,	'',	8,	1),
(10,	'2021-09-01 08:52:09.078063',	'8',	'test create post',	3,	'',	8,	1),
(11,	'2021-09-01 08:52:09.104243',	'9',	'test create post',	3,	'',	8,	1),
(12,	'2021-09-01 08:52:09.130379',	'11',	'test create post ddaays ahihihi',	3,	'',	8,	1),
(13,	'2021-09-01 08:52:09.156629',	'12',	'test create post ddaays ahihihi',	3,	'',	8,	1),
(14,	'2021-09-01 08:52:09.182609',	'15',	'Test upload many file',	3,	'',	8,	1),
(15,	'2021-09-01 08:52:09.233657',	'16',	'Test upload many file',	3,	'',	8,	1),
(16,	'2021-09-01 09:05:46.467736',	'7',	'kan haungo',	2,	'[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Phone\", \"Address\", \"Birthday\"]}}]',	6,	1),
(17,	'2021-09-02 08:31:08.361101',	'1',	'Bất động sản',	1,	'[{\"added\": {}}]',	15,	1),
(18,	'2021-09-02 08:31:43.002741',	'2',	'Nhà cửa',	1,	'[{\"added\": {}}]',	15,	1),
(19,	'2021-09-02 08:32:00.660059',	'3',	'Vận dụng Nội thất',	1,	'[{\"added\": {}}]',	15,	1),
(20,	'2021-09-02 08:32:15.748674',	'4',	'Xe cộ',	1,	'[{\"added\": {}}]',	15,	1),
(21,	'2021-09-02 08:32:32.736182',	'5',	'Nghệ thuật',	1,	'[{\"added\": {}}]',	15,	1),
(22,	'2021-09-02 08:32:45.704464',	'6',	'Đồ cổ',	1,	'[{\"added\": {}}]',	15,	1),
(23,	'2021-09-02 08:36:42.639609',	'1',	'Bán nhà gây quỹ vào từ thiện 50% lợi nhuận',	2,	'[{\"changed\": {\"fields\": [\"User\", \"Category\"]}}]',	7,	1),
(24,	'2021-09-02 09:07:56.656873',	'3',	'comment auction 1',	3,	'',	7,	1),
(25,	'2021-09-02 09:07:56.685633',	'4',	'comment auction 1',	3,	'',	7,	1),
(26,	'2021-09-02 09:07:56.713725',	'5',	'comment auction 1',	3,	'',	7,	1),
(27,	'2021-09-05 02:59:28.735788',	'1',	'ReportType object (1)',	1,	'[{\"added\": {}}]',	23,	1),
(28,	'2021-09-05 02:59:38.474259',	'2',	'ReportType object (2)',	1,	'[{\"added\": {}}]',	23,	1),
(29,	'2021-09-05 02:59:59.291033',	'3',	'ReportType object (3)',	1,	'[{\"added\": {}}]',	23,	1),
(30,	'2021-09-05 03:00:22.833060',	'4',	'ReportType object (4)',	1,	'[{\"added\": {}}]',	23,	1),
(31,	'2021-09-05 03:00:37.046067',	'5',	'ReportType object (5)',	1,	'[{\"added\": {}}]',	23,	1),
(32,	'2021-09-05 03:03:50.753615',	'1',	'Thông tin không hữu ích-Spam',	1,	'[{\"added\": {}}]',	9,	1),
(33,	'2021-09-05 03:07:08.888433',	'1',	'Như đùa v-Spam',	1,	'[{\"added\": {}}]',	12,	1);

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `django_content_type`;
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1,	'admin',	'logentry'),
(3,	'auth',	'group'),
(2,	'auth',	'permission'),
(4,	'contenttypes',	'contenttype'),
(22,	'corsheaders',	'corsmodel'),
(18,	'oauth2_provider',	'accesstoken'),
(17,	'oauth2_provider',	'application'),
(19,	'oauth2_provider',	'grant'),
(21,	'oauth2_provider',	'idtoken'),
(20,	'oauth2_provider',	'refreshtoken'),
(5,	'sessions',	'session'),
(7,	'social_network',	'auction'),
(14,	'social_network',	'auctioncomment'),
(13,	'social_network',	'auctionimage'),
(12,	'social_network',	'auctionreport'),
(15,	'social_network',	'categoryauction'),
(16,	'social_network',	'hashtagpost'),
(8,	'social_network',	'post'),
(11,	'social_network',	'postcomment'),
(10,	'social_network',	'postimage'),
(9,	'social_network',	'postreport'),
(23,	'social_network',	'reporttype'),
(6,	'social_network',	'user');

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `django_migrations`;
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1,	'contenttypes',	'0001_initial',	'2021-08-05 10:13:31.986743'),
(2,	'contenttypes',	'0002_remove_content_type_name',	'2021-08-05 10:13:32.285043'),
(3,	'auth',	'0001_initial',	'2021-08-05 10:13:33.531854'),
(4,	'auth',	'0002_alter_permission_name_max_length',	'2021-08-05 10:13:33.749449'),
(5,	'auth',	'0003_alter_user_email_max_length',	'2021-08-05 10:13:33.775097'),
(6,	'auth',	'0004_alter_user_username_opts',	'2021-08-05 10:13:33.789067'),
(7,	'auth',	'0005_alter_user_last_login_null',	'2021-08-05 10:13:33.814408'),
(8,	'auth',	'0006_require_contenttypes_0002',	'2021-08-05 10:13:33.832617'),
(9,	'auth',	'0007_alter_validators_add_error_messages',	'2021-08-05 10:13:33.860329'),
(10,	'auth',	'0008_alter_user_username_max_length',	'2021-08-05 10:13:33.886381'),
(11,	'auth',	'0009_alter_user_last_name_max_length',	'2021-08-05 10:13:33.915425'),
(12,	'auth',	'0010_alter_group_name_max_length',	'2021-08-05 10:13:34.102803'),
(13,	'auth',	'0011_update_proxy_permissions',	'2021-08-05 10:13:34.130678'),
(14,	'auth',	'0012_alter_user_first_name_max_length',	'2021-08-05 10:13:34.156497'),
(15,	'social_network',	'0001_initial',	'2021-08-05 10:13:38.545977'),
(16,	'admin',	'0001_initial',	'2021-08-05 10:13:39.049940'),
(17,	'admin',	'0002_logentry_remove_auto_add',	'2021-08-05 10:13:39.094020'),
(18,	'admin',	'0003_logentry_add_action_flag_choices',	'2021-08-05 10:13:39.115735'),
(19,	'sessions',	'0001_initial',	'2021-08-05 10:13:39.241871'),
(20,	'social_network',	'0002_auto_20210805_1256',	'2021-08-05 12:56:20.969928'),
(21,	'social_network',	'0003_auto_20210809_0958',	'2021-08-09 09:58:10.614958'),
(22,	'oauth2_provider',	'0001_initial',	'2021-08-30 04:00:52.228796'),
(23,	'oauth2_provider',	'0002_auto_20190406_1805',	'2021-08-30 04:00:52.498323'),
(24,	'oauth2_provider',	'0003_auto_20201211_1314',	'2021-08-30 04:00:52.765619'),
(25,	'oauth2_provider',	'0004_auto_20200902_2022',	'2021-08-30 04:00:54.112402'),
(26,	'social_network',	'0004_post_like',	'2021-09-01 01:48:35.432869'),
(27,	'corsheaders',	'0001_initial',	'2021-09-01 09:58:31.437569'),
(28,	'social_network',	'0005_auction_like',	'2021-09-02 03:32:14.223186'),
(29,	'social_network',	'0006_auto_20210903_1337',	'2021-09-03 13:37:28.357127'),
(30,	'social_network',	'0007_alter_auctioncomment_status_transaction',	'2021-09-03 13:42:42.495157'),
(31,	'social_network',	'0008_auction_buyer',	'2021-09-04 03:10:28.304165'),
(32,	'social_network',	'0009_auction_date_success',	'2021-09-04 03:25:32.038144'),
(33,	'social_network',	'0010_auto_20210905_0231',	'2021-09-05 02:31:21.053677'),
(34,	'social_network',	'0011_auto_20210905_0231',	'2021-09-05 02:31:57.649204'),
(35,	'social_network',	'0012_rename_reposttype_reporttype',	'2021-09-05 02:36:36.893271');

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `django_session`;
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('awshxdk4w0k0up78711e9gotokesucnv',	'.eJxVjEEOwiAQRe_C2hBKcQCX7j0DmYFBqgaS0q6Md7dNutDtf-_9twi4LiWsnecwJXERgzj9boTxyXUH6YH13mRsdZknkrsiD9rlrSV-XQ_376BgL1sdWTkDGc8pZ7DG0QDWZ0-KdAZWqEfEtEEk65UZtbbeaMwAlAB5dOLzBfwIOGo:1mKcZl:bIOc_Tg-TKpbPbuK-wicMZVK9cYU8R-aTNRbIuv20AE',	'2021-09-13 08:23:29.396801'),
('ktbmji8btx27ns402vgm7yw2ld2durca',	'.eJxVjEEOwiAQRe_C2hBKcQCX7j0DmYFBqgaS0q6Md7dNutDtf-_9twi4LiWsnecwJXERgzj9boTxyXUH6YH13mRsdZknkrsiD9rlrSV-XQ_376BgL1sdWTkDGc8pZ7DG0QDWZ0-KdAZWqEfEtEEk65UZtbbeaMwAlAB5dOLzBfwIOGo:1mD23F:mHK6FP6hVZBfmzVhHUJZa__bfNXgbWneVGWLvThGBnY',	'2021-08-23 09:58:33.269669'),
('u1bftwdenhfqvrn4lck394rnchlzt2qk',	'.eJxVjEEOwiAQRe_C2hBKcQCX7j0DmYFBqgaS0q6Md7dNutDtf-_9twi4LiWsnecwJXERgzj9boTxyXUH6YH13mRsdZknkrsiD9rlrSV-XQ_376BgL1sdWTkDGc8pZ7DG0QDWZ0-KdAZWqEfEtEEk65UZtbbeaMwAlAB5dOLzBfwIOGo:1mBaOY:OWhCRnfwKHkPX-FSHulIw-tuvo3z9GIbw6P0fdS4pzQ',	'2021-08-19 10:14:34.793902'),
('whtyb9dc15x52uqiwqtcpjmmwj4ht4r5',	'.eJxVjEEOwiAQRe_C2hBKcQCX7j0DmYFBqgaS0q6Md7dNutDtf-_9twi4LiWsnecwJXERgzj9boTxyXUH6YH13mRsdZknkrsiD9rlrSV-XQ_376BgL1sdWTkDGc8pZ7DG0QDWZ0-KdAZWqEfEtEEk65UZtbbeaMwAlAB5dOLzBfwIOGo:1mNbwI:m_EaDH3brGWghtUZ1PnGJMzI8WyJ1R_wN2NN7cmp3mE',	'2021-09-21 14:19:06.796075');

DROP TABLE IF EXISTS `oauth2_provider_accesstoken`;
CREATE TABLE `oauth2_provider_accesstoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext COLLATE utf8_unicode_ci NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `source_refresh_token_id` bigint DEFAULT NULL,
  `id_token_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `source_refresh_token_id` (`source_refresh_token_id`),
  UNIQUE KEY `id_token_id` (`id_token_id`),
  KEY `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_acce_user_id_6e4c9a65_fk_social_ne` (`user_id`),
  CONSTRAINT `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_acce_id_token_id_85db651b_fk_oauth2_pr` FOREIGN KEY (`id_token_id`) REFERENCES `oauth2_provider_idtoken` (`id`),
  CONSTRAINT `oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr` FOREIGN KEY (`source_refresh_token_id`) REFERENCES `oauth2_provider_refreshtoken` (`id`),
  CONSTRAINT `oauth2_provider_acce_user_id_6e4c9a65_fk_social_ne` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `oauth2_provider_accesstoken`;
INSERT INTO `oauth2_provider_accesstoken` (`id`, `token`, `expires`, `scope`, `application_id`, `user_id`, `created`, `updated`, `source_refresh_token_id`, `id_token_id`) VALUES
(1,	'raQ1JYts3QjW2PG32j3LCTW94Cddut',	'2021-08-30 19:44:53.401666',	'read write',	3,	1,	'2021-08-30 09:44:53.402067',	'2021-08-30 09:44:53.402076',	NULL,	NULL),
(2,	'8YZR2neM2vQKMvMAn7HORgHf4gbOVJ',	'2021-08-31 11:02:05.215843',	'read write',	3,	7,	'2021-08-31 01:02:05.216588',	'2021-08-31 01:02:05.216600',	NULL,	NULL),
(3,	'7IudyylHMXJ3LUuDbHplRsWG14ymns',	'2021-08-31 18:40:40.958165',	'read write',	3,	7,	'2021-08-31 08:40:40.959673',	'2021-08-31 08:40:40.959705',	NULL,	NULL),
(4,	'iBU927UMFvIb4xYRDEu7E4ecAA6i3I',	'2021-09-01 12:29:38.828886',	'read write',	3,	7,	'2021-09-01 02:29:38.830074',	'2021-09-01 02:29:38.830103',	NULL,	NULL),
(5,	'9NtLLfe23Zsl1TXs7iXxeCMIihhUWl',	'2021-09-01 18:40:39.823385',	'read write',	3,	7,	'2021-09-01 08:40:39.824364',	'2021-09-01 08:40:39.824392',	NULL,	NULL),
(6,	'gAKFrOg0MW6lLiPA8QZoajpTIZANv7',	'2021-09-01 19:36:59.102830',	'read write',	3,	7,	'2021-09-01 09:36:59.103234',	'2021-09-01 09:36:59.103245',	NULL,	NULL),
(7,	'zPXfNU8gTkGqstjDx75PtuzkwxA1bu',	'2021-09-01 20:07:24.277525',	'read write',	3,	7,	'2021-09-01 10:07:24.277904',	'2021-09-01 10:07:24.277914',	NULL,	NULL),
(8,	'eDyyV9bVlWSkQg7iCweloXbtazdi4s',	'2021-09-01 20:10:29.446856',	'read write',	3,	7,	'2021-09-01 10:10:29.447151',	'2021-09-01 10:10:29.447160',	NULL,	NULL),
(9,	'jGYO2lb2WGju0908vctWO0LaJ0iLbD',	'2021-09-01 20:11:13.478097',	'read write',	3,	7,	'2021-09-01 10:11:13.478395',	'2021-09-01 10:11:13.478405',	NULL,	NULL),
(10,	'vYFFuEgyjXNS4ROJIyJGOS7kDcEZpw',	'2021-09-01 20:11:26.205152',	'read write',	3,	7,	'2021-09-01 10:11:26.205434',	'2021-09-01 10:11:26.205444',	NULL,	NULL),
(11,	'OMHasdHcLAxFWEv73qKNYdO19DWg7V',	'2021-09-01 20:15:53.254240',	'read write',	3,	7,	'2021-09-01 10:15:53.254530',	'2021-09-01 10:15:53.254540',	NULL,	NULL),
(12,	'OBWdF8ZvZLjVJz6siPHX6gDvH976Cz',	'2021-09-02 11:14:34.865490',	'read write',	3,	7,	'2021-09-02 01:14:34.866101',	'2021-09-02 01:14:34.866111',	NULL,	NULL),
(13,	'Dx6gfJkED9kQMRSVRnhOystCbAUSLz',	'2021-09-02 11:17:28.870949',	'read write',	3,	7,	'2021-09-02 01:17:28.871459',	'2021-09-02 01:17:28.871470',	NULL,	NULL),
(14,	'1vN273yt5fe3hnRR0AwB1CXo5bW3ja',	'2021-09-02 12:30:20.901324',	'read write',	3,	7,	'2021-09-02 02:30:20.902260',	'2021-09-02 02:30:20.902287',	NULL,	NULL),
(15,	'1V8wvu74iESMnxj5OphJnd3l2MZ5Ht',	'2021-09-02 12:33:54.744054',	'read write',	3,	7,	'2021-09-02 02:33:54.745349',	'2021-09-02 02:33:54.745380',	NULL,	NULL),
(16,	'CAAbjU7VHtAIDodJ9Uf3urN3QupNZY',	'2021-09-02 14:24:29.702766',	'read write',	3,	7,	'2021-09-02 04:24:29.703159',	'2021-09-02 04:24:29.703169',	NULL,	NULL),
(17,	'PfpiJkHpvTdkOtU43QdoOLVaJzuCL6',	'2021-09-02 16:47:38.115106',	'read write',	3,	7,	'2021-09-02 06:47:38.116086',	'2021-09-02 06:47:38.116114',	NULL,	NULL),
(18,	'WasEgXP5wc0WCHLFS0gGWWSQEN22Zw',	'2021-09-02 16:55:39.715412',	'read write',	3,	1,	'2021-09-02 06:55:39.716480',	'2021-09-02 06:55:39.716524',	NULL,	NULL),
(19,	'P3t4wsWCpLst96URr5RhMHZNoIVBnZ',	'2021-09-02 17:09:49.650272',	'read write',	3,	7,	'2021-09-02 07:09:49.651607',	'2021-09-02 07:09:49.651634',	NULL,	NULL),
(20,	'ZuUgorxTiYV8scs2tDRLCTTHfNSe3H',	'2021-09-02 17:17:32.919432',	'read write',	3,	7,	'2021-09-02 07:17:32.920093',	'2021-09-02 07:17:32.920120',	NULL,	NULL),
(21,	'cQZJCQTDKzFBs2l3vdlamCqRtwXnl2',	'2021-09-02 17:19:18.564693',	'read write',	3,	7,	'2021-09-02 07:19:18.565357',	'2021-09-02 07:19:18.565385',	NULL,	NULL),
(22,	'4ihGCetCnCx5g6TpVSLxlDZ1nZ8Nbe',	'2021-09-02 17:25:07.518419',	'read write',	3,	7,	'2021-09-02 07:25:07.519048',	'2021-09-02 07:25:07.519074',	NULL,	NULL),
(23,	'5k0Gr2Kq3wNPpOMTa6W9pMvUjJ4fqk',	'2021-09-02 18:06:01.493728',	'read write',	3,	1,	'2021-09-02 08:06:01.494627',	'2021-09-02 08:06:01.494654',	NULL,	NULL),
(24,	'Z16D4z3a69eZzMyYX0zmykzbVUpP6s',	'2021-09-02 18:35:07.297062',	'read write',	3,	1,	'2021-09-02 08:35:07.297443',	'2021-09-02 08:35:07.297453',	NULL,	NULL),
(25,	'Q3C8u9dkto8hQRu0J1gSfQDuNo0iX2',	'2021-09-02 18:36:50.761902',	'read write',	3,	7,	'2021-09-02 08:36:50.762210',	'2021-09-02 08:36:50.762220',	NULL,	NULL),
(26,	'NKE7zPckkRq2Qtj6rrJMaEJF43IN7T',	'2021-09-02 19:30:18.238092',	'read write',	3,	7,	'2021-09-02 09:30:18.239144',	'2021-09-02 09:30:18.239173',	NULL,	NULL),
(27,	'hhlqiVH1fnc4WqWt6i5x1HZXpeeZMm',	'2021-09-02 20:10:45.340475',	'read write',	3,	7,	'2021-09-02 10:10:45.341080',	'2021-09-02 10:10:45.341090',	NULL,	NULL),
(28,	'KAV9WDClEWR3oIdjgO1OOv6jTr0h2X',	'2021-09-03 12:27:27.397702',	'read write',	3,	7,	'2021-09-03 02:27:27.398093',	'2021-09-03 02:27:27.398104',	NULL,	NULL),
(29,	'xAGvDiLCR7o09EuuSEGoGzJcTxPkru',	'2021-09-03 12:38:48.088044',	'read write',	3,	7,	'2021-09-03 02:38:48.088431',	'2021-09-03 02:38:48.088442',	NULL,	NULL),
(30,	'vqNGRfhC44ZUNWRy3sMJk3f2V8WMzV',	'2021-09-03 12:38:56.862414',	'read write',	3,	7,	'2021-09-03 02:38:56.862804',	'2021-09-03 02:38:56.862814',	NULL,	NULL),
(31,	'xcGdMzv1yMpuTk7YqF3nnJjZJFgXKH',	'2021-09-03 13:36:03.181036',	'read write',	3,	7,	'2021-09-03 03:36:03.181789',	'2021-09-03 03:36:03.181800',	NULL,	NULL),
(32,	'fuSiM1EKQNtGVTLShu8XIwGk9gHet1',	'2021-09-03 17:02:11.268342',	'read write',	3,	7,	'2021-09-03 07:02:11.269282',	'2021-09-03 07:02:11.269311',	NULL,	NULL),
(33,	'qkKeAESzLkaTTYgWARKTh5lLy79s8u',	'2021-09-03 17:03:00.247319',	'read write',	3,	7,	'2021-09-03 07:03:00.248777',	'2021-09-03 07:03:00.248828',	NULL,	NULL),
(34,	'HsttPF7sFhUKFWCaGbu1ehAAOmKGci',	'2021-09-03 18:31:50.808461',	'read write',	3,	7,	'2021-09-03 08:31:50.809718',	'2021-09-03 08:31:50.809748',	NULL,	NULL),
(35,	't7TW6IipC0xZxu849AsTo65tXYy7QX',	'2021-09-03 18:58:51.265708',	'read write',	3,	7,	'2021-09-03 08:58:51.267035',	'2021-09-03 08:58:51.267066',	NULL,	NULL),
(36,	's4bgvaZHEczar6Ym0Gqs157pekVfxb',	'2021-09-03 19:37:34.645012',	'read write',	3,	7,	'2021-09-03 09:37:34.646029',	'2021-09-03 09:37:34.646058',	NULL,	NULL),
(37,	'c0w4FB6FpJLrkKmW3WQfg9HX7Rre9D',	'2021-09-03 20:06:53.013943',	'read write',	3,	7,	'2021-09-03 10:06:53.015011',	'2021-09-03 10:06:53.015040',	NULL,	NULL),
(38,	'ekLbDn9wneNd5hIWg4OTK2JSQukWph',	'2021-09-03 20:15:05.063042',	'read write',	3,	7,	'2021-09-03 10:15:05.064239',	'2021-09-03 10:15:05.064283',	NULL,	NULL),
(39,	'qOjMmphZaIblAnZmPuaZv3TKTfUu3V',	'2021-09-03 20:33:19.304865',	'read write',	3,	7,	'2021-09-03 10:33:19.305866',	'2021-09-03 10:33:19.305895',	NULL,	NULL),
(40,	'zXDqblhtCSAxzSJXruRVMWQhVIa6Fd',	'2021-09-03 23:29:55.523938',	'read write',	3,	7,	'2021-09-03 13:29:55.525139',	'2021-09-03 13:29:55.525167',	NULL,	NULL),
(41,	'ZmgRoNuiMsKnfZOmEMdtNXuOdLH7Rp',	'2021-09-04 10:34:58.580865',	'read write',	3,	7,	'2021-09-04 00:34:58.581797',	'2021-09-04 00:34:58.581824',	NULL,	NULL),
(42,	'tmeCeBJVdvm2IHty39pHtsanPqre8s',	'2021-09-04 12:36:58.847128',	'read write',	3,	7,	'2021-09-04 02:36:58.848141',	'2021-09-04 02:36:58.848170',	NULL,	NULL),
(43,	'q0oyzeluRnooC8WIrdPUyiZ2SCUcKO',	'2021-09-04 13:00:36.114209',	'read write',	3,	7,	'2021-09-04 03:00:36.115446',	'2021-09-04 03:00:36.115480',	NULL,	NULL),
(44,	'ODV2rwZpKZHRcmiB9hoR0aFnNTDWje',	'2021-09-04 13:30:14.954755',	'read write',	3,	7,	'2021-09-04 03:30:14.956398',	'2021-09-04 03:30:14.956429',	NULL,	NULL),
(45,	'TXmnUA8l4BcoDlOMp7zWCQYHS4lW6u',	'2021-09-04 14:17:24.583466',	'read write',	3,	7,	'2021-09-04 04:17:24.584670',	'2021-09-04 04:17:24.584698',	NULL,	NULL),
(46,	'T6sm8gfZyWvvh3FEbnr9w6BHX5bJYh',	'2021-09-04 22:15:17.819829',	'read write',	3,	7,	'2021-09-04 12:15:17.820215',	'2021-09-04 12:15:17.820226',	NULL,	NULL),
(47,	'uvsrCcn4O8SjZfZHSdZ30WozsUCEtk',	'2021-09-04 22:28:42.004119',	'read write',	3,	7,	'2021-09-04 12:28:42.004422',	'2021-09-04 12:28:42.004431',	NULL,	NULL),
(48,	'FklQwzS1Rp89MpacubzO15cc8cucjg',	'2021-09-05 11:58:09.843965',	'read write',	3,	7,	'2021-09-05 01:58:09.845008',	'2021-09-05 01:58:09.845036',	NULL,	NULL),
(49,	'EkxhTVmP4tawJFH27LxC1kCiWxIDWP',	'2021-09-05 13:29:40.881323',	'read write',	3,	7,	'2021-09-05 03:29:40.882339',	'2021-09-05 03:29:40.882368',	NULL,	NULL),
(50,	'wCelm1jocWlqpNkkhSkX1BXBMkE5uk',	'2021-09-05 14:07:08.035685',	'read write',	3,	7,	'2021-09-05 04:07:08.036710',	'2021-09-05 04:07:08.036740',	NULL,	NULL),
(51,	'bwUPRvvVRrjg7SslLLAK4K4hvlG5Rv',	'2021-09-05 14:17:45.692141',	'read write',	3,	7,	'2021-09-05 04:17:45.693587',	'2021-09-05 04:17:45.693617',	NULL,	NULL),
(52,	'5a1GTpkUJ6EnIBiywZFGZyZ5FdMBus',	'2021-09-05 18:51:04.256202',	'read write',	3,	7,	'2021-09-05 08:51:04.256604',	'2021-09-05 08:51:04.256614',	NULL,	NULL),
(53,	'8d1BdgGtcglrxgbaU5EwI3cZNunjqu',	'2021-09-05 19:00:27.438893',	'read write',	3,	10,	'2021-09-05 09:00:27.439208',	'2021-09-05 09:00:27.439218',	NULL,	NULL),
(54,	'aSpDtFsMag24AYDIipOvG8CoN2m1GX',	'2021-09-07 11:40:54.085285',	'read write',	3,	7,	'2021-09-07 01:40:54.085656',	'2021-09-07 01:40:54.085666',	NULL,	NULL),
(55,	'3cjepAYdpcTmftPCW65lTjw6zgRNOG',	'2021-09-08 00:31:07.114400',	'read write',	3,	7,	'2021-09-07 14:31:07.114779',	'2021-09-07 14:31:07.114790',	NULL,	NULL),
(56,	'v8EQRc4JzFFNjL0k9hKKH1RXaDHOUM',	'2021-09-08 00:31:07.263390',	'read write',	3,	7,	'2021-09-07 14:31:07.263681',	'2021-09-07 14:31:07.263691',	NULL,	NULL),
(57,	'ixg1q2jmGLSkYZbbIme10dNjk4lvFL',	'2021-09-08 00:31:07.423223',	'read write',	3,	7,	'2021-09-07 14:31:07.423520',	'2021-09-07 14:31:07.423629',	NULL,	NULL),
(58,	'djKD9VwELP4Pfn7eaOD3baPc4pGoBr',	'2021-09-08 13:10:44.127891',	'read write',	3,	7,	'2021-09-08 03:10:44.128286',	'2021-09-08 03:10:44.128297',	NULL,	NULL),
(59,	'fvWyi371WkxItAoFdkfNdNQtAn4t4c',	'2021-09-08 13:16:58.804259',	'read write',	3,	7,	'2021-09-08 03:16:58.804568',	'2021-09-08 03:16:58.804577',	NULL,	NULL),
(60,	'mkdG1xi2nJxggqN8bolHyEgWV6Jwu1',	'2021-09-08 13:49:24.064321',	'read write',	3,	7,	'2021-09-08 03:49:24.064607',	'2021-09-08 03:49:24.064616',	NULL,	NULL),
(61,	'ES5kjLjNxHugat0FZzckySflTeLt6u',	'2021-09-08 13:52:33.648325',	'read write',	3,	7,	'2021-09-08 03:52:33.648612',	'2021-09-08 03:52:33.648622',	NULL,	NULL),
(62,	'HQViQGftWCfj1WfDyLpDfqFuahym7L',	'2021-09-08 13:59:11.323797',	'read write',	3,	7,	'2021-09-08 03:59:11.324087',	'2021-09-08 03:59:11.324097',	NULL,	NULL),
(63,	'0RdEYMCRKmWxZdsUWEO2tToq48AZKT',	'2021-09-08 13:59:12.427314',	'read write',	3,	7,	'2021-09-08 03:59:12.427606',	'2021-09-08 03:59:12.427615',	NULL,	NULL),
(64,	'eAJkXkPZfvVdF64u4gi7xnABRO4gjA',	'2021-09-08 16:29:19.717026',	'read write',	3,	7,	'2021-09-08 06:29:19.717416',	'2021-09-08 06:29:19.717427',	NULL,	NULL),
(65,	'Sms6FXAd4hQajlU2n22YxkNtgxFhS8',	'2021-09-08 16:30:51.763679',	'read write',	3,	7,	'2021-09-08 06:30:51.763983',	'2021-09-08 06:30:51.763994',	NULL,	NULL),
(66,	'ruMGSLoXtEFbkdozeFCdTUukWfFZic',	'2021-09-08 16:34:49.324353',	'read write',	3,	7,	'2021-09-08 06:34:49.324699',	'2021-09-08 06:34:49.324710',	NULL,	NULL),
(67,	'i1lAgDYOnmNrj8LM0ZgPbVv77sYZgE',	'2021-09-08 18:17:35.412825',	'read write',	3,	1,	'2021-09-08 08:17:35.413168',	'2021-09-08 08:17:35.413178',	NULL,	NULL),
(68,	'0gj7AhUUeiP8yg9ljAdsr4R0PIWKDw',	'2021-09-08 18:20:20.623156',	'read write',	3,	7,	'2021-09-08 08:20:20.623472',	'2021-09-08 08:20:20.623487',	NULL,	NULL),
(69,	'JPjfWmSYSQlBFcPpgRrqOrZZ72c11H',	'2021-09-09 01:39:02.909576',	'read write',	3,	7,	'2021-09-08 15:39:02.910151',	'2021-09-08 15:39:02.910166',	NULL,	NULL),
(70,	'ZhFGT4oofzg2ccuDgwNHvJ0RMKpui4',	'2021-09-09 02:16:32.126485',	'read write',	3,	7,	'2021-09-08 16:16:32.126734',	'2021-09-08 16:16:32.126743',	NULL,	NULL),
(71,	'ZbcvpvUN6txB30YHAdDRX3SKsGLqFi',	'2021-09-09 02:53:23.276923',	'read write',	3,	7,	'2021-09-08 16:53:23.277188',	'2021-09-08 16:53:23.277197',	NULL,	NULL),
(72,	'wWGiRHchrLL7xM3HI86IRn2hhLaRUm',	'2021-09-09 10:05:09.083433',	'read write',	3,	7,	'2021-09-09 00:05:09.083810',	'2021-09-09 00:05:09.083821',	NULL,	NULL),
(73,	'elntfIVbmrqevE6N7uF1cgoxMjoU95',	'2021-09-09 10:30:01.699646',	'read write',	3,	7,	'2021-09-09 00:30:01.700019',	'2021-09-09 00:30:01.700029',	NULL,	NULL),
(74,	'KaDeoDEyri6UUevVm1F2wMcNh41bQQ',	'2021-09-09 17:42:41.262948',	'read write',	3,	7,	'2021-09-09 07:42:41.264422',	'2021-09-09 07:42:41.264432',	NULL,	NULL),
(75,	'i0cqERZ3ZDf06S4iiYDF6ADSYWnQwp',	'2021-09-09 19:50:33.017631',	'read write',	3,	7,	'2021-09-09 09:50:33.017986',	'2021-09-09 09:50:33.017997',	NULL,	NULL),
(78,	'r9b1nPTCWp7Am4U9doFVMrlhzXWRdt',	'2021-09-09 19:53:43.992151',	'read write',	3,	7,	'2021-09-09 09:53:44.011670',	'2021-09-09 09:53:44.011697',	77,	NULL),
(79,	'iBjWIpzOJ9EiZJPU3ldyq27dgjeq0L',	'2021-09-09 23:02:06.779926',	'read write',	3,	7,	'2021-09-09 13:02:06.780307',	'2021-09-09 13:02:06.780317',	NULL,	NULL),
(80,	'TROCJYMxRcGS7FM4Kr2EgLYJtB8pCZ',	'2021-09-10 00:21:45.781180',	'read write',	3,	7,	'2021-09-09 14:21:45.781496',	'2021-09-09 14:21:45.781506',	NULL,	NULL),
(81,	'B5smKhZzGBQ1JNWcJzy6kajhC51eVq',	'2021-09-10 00:33:59.194680',	'read write',	3,	7,	'2021-09-09 14:33:59.194993',	'2021-09-09 14:33:59.195003',	NULL,	NULL),
(82,	'LQViHP1sl895804c4Q5W2SxNE05jxQ',	'2021-09-10 00:36:15.638206',	'read write',	3,	7,	'2021-09-09 14:36:15.638513',	'2021-09-09 14:36:15.638524',	NULL,	NULL),
(83,	'CaxHobOXC8fGH2EXIV8D3lD22alHOo',	'2021-09-10 11:45:39.471690',	'read write',	3,	7,	'2021-09-10 01:45:39.472057',	'2021-09-10 01:45:39.472068',	NULL,	NULL),
(84,	'RituvHAbkEAlnfw7et6Cjq2uzOXLnE',	'2021-09-10 12:00:24.834343',	'read write',	3,	7,	'2021-09-10 02:00:24.834661',	'2021-09-10 02:00:24.834671',	NULL,	NULL),
(85,	'a0YsGLn3Popuw3OnRuQOMLOMNTU31W',	'2021-09-10 12:09:58.389582',	'read write',	3,	7,	'2021-09-10 02:09:58.390181',	'2021-09-10 02:09:58.390201',	NULL,	NULL),
(88,	'vqrFVsejMSBwrjNR1baiNRBIG6dqcF',	'2021-09-11 03:16:37.947117',	'read write',	3,	7,	'2021-09-10 17:16:37.947424',	'2021-09-10 17:16:37.947434',	NULL,	NULL),
(90,	'BJhzArmPJqbyZCFt0FD6fJ6MdFHtO6',	'2021-09-11 12:38:53.697107',	'read write',	3,	7,	'2021-09-11 02:38:53.697438',	'2021-09-11 02:38:53.697448',	NULL,	NULL),
(91,	'bpEalfWYrs0cZQxH5TAnttJFRI4BrC',	'2021-09-11 12:49:14.989070',	'read write',	3,	7,	'2021-09-11 02:49:14.989399',	'2021-09-11 02:49:14.989409',	NULL,	NULL),
(92,	'zFG4AzFwnPpHzQHjvso3wdB20vDbZp',	'2021-09-11 13:01:12.664731',	'read write',	3,	7,	'2021-09-11 03:01:12.666132',	'2021-09-11 03:01:12.666162',	NULL,	NULL),
(93,	'GQsFgjsfOoiWqROHvfvd8QCHNP6YxF',	'2021-09-11 13:02:06.050529',	'read write',	3,	7,	'2021-09-11 03:02:06.052032',	'2021-09-11 03:02:06.052127',	NULL,	NULL),
(94,	'hm4x2wMWeCSbXaRRFUakrIiz9LsaIS',	'2021-09-11 13:02:56.888242',	'read write',	3,	7,	'2021-09-11 03:02:56.889588',	'2021-09-11 03:02:56.889618',	NULL,	NULL),
(95,	'11JymQG4DQ1ubfgdYpS26qpTO9Gc5I',	'2021-09-11 13:10:22.160233',	'read write',	3,	7,	'2021-09-11 03:10:22.161124',	'2021-09-11 03:10:22.161159',	NULL,	NULL),
(96,	'EBSSgS62W2chkYC3nLXqgcbCvJrm8t',	'2021-09-11 13:21:04.187787',	'read write',	3,	7,	'2021-09-11 03:21:04.188648',	'2021-09-11 03:21:04.188677',	NULL,	NULL),
(97,	'TrrRIh0Sgp6ZbpnDEkZqLgHBBjMGoK',	'2021-09-11 13:25:04.977644',	'read write',	3,	7,	'2021-09-11 03:25:04.979063',	'2021-09-11 03:25:04.979103',	NULL,	NULL),
(98,	'3eVZnXhZfkxbufkJ9jng248Ni5Gm7K',	'2021-09-11 13:25:54.543622',	'read write',	3,	7,	'2021-09-11 03:25:54.544629',	'2021-09-11 03:25:54.544658',	NULL,	NULL),
(99,	'B3rvTj0V5vjJ3dyuQB778CFK3sy1X8',	'2021-09-11 16:00:55.485117',	'read write',	3,	7,	'2021-09-11 06:00:55.486215',	'2021-09-11 06:00:55.486245',	NULL,	NULL),
(100,	'eqoDbz9dlvAh8o4ucXvvs4GvBNBkEj',	'2021-09-11 16:04:11.952061',	'read write',	3,	7,	'2021-09-11 06:04:11.952772',	'2021-09-11 06:04:11.952800',	NULL,	NULL),
(101,	'WPcU3Ki8NwwTU7F8RLYn5MON8m1xAp',	'2021-09-11 16:06:11.522319',	'read write',	3,	7,	'2021-09-11 06:06:11.523273',	'2021-09-11 06:06:11.523320',	NULL,	NULL),
(102,	'ICbSAv0PobUnyeXUaL0n4LJzvlxEBr',	'2021-09-11 16:12:28.499832',	'read write',	3,	7,	'2021-09-11 06:12:28.500542',	'2021-09-11 06:12:28.500570',	NULL,	NULL),
(103,	'de023uLECW5b51hexKeDrITEjQ46jk',	'2021-09-11 16:12:30.024998',	'read write',	3,	7,	'2021-09-11 06:12:30.025830',	'2021-09-11 06:12:30.025858',	NULL,	NULL),
(104,	'Td835UYNnOVQNkyw4q32w0hI8vqn77',	'2021-09-11 16:28:13.256730',	'read write',	3,	7,	'2021-09-11 06:28:13.257697',	'2021-09-11 06:28:13.257725',	NULL,	NULL),
(105,	'f0WZyI9EcaplcXlD6p9M84TgIVhHYw',	'2021-09-11 16:35:08.324027',	'read write',	3,	7,	'2021-09-11 06:35:08.324753',	'2021-09-11 06:35:08.324782',	NULL,	NULL),
(106,	'JAowGGz89pEj6ZSinQHiv40FVHxeDM',	'2021-09-11 16:37:17.295926',	'read write',	3,	7,	'2021-09-11 06:37:17.296642',	'2021-09-11 06:37:17.296670',	NULL,	NULL),
(107,	'aAdYoibHXsQ6fAyV6ZiQVXFYfZ4gep',	'2021-09-11 16:41:45.152848',	'read write',	3,	7,	'2021-09-11 06:41:45.154277',	'2021-09-11 06:41:45.154308',	NULL,	NULL),
(108,	'sYfZAOHW92ZMl374AGognfJJZzvte3',	'2021-09-11 16:43:43.866860',	'read write',	3,	7,	'2021-09-11 06:43:43.867615',	'2021-09-11 06:43:43.867643',	NULL,	NULL),
(109,	'68QFg8zDsDUTwzjNWwjT0D3Pq4aQBV',	'2021-09-11 16:45:12.147722',	'read write',	3,	7,	'2021-09-11 06:45:12.148418',	'2021-09-11 06:45:12.148446',	NULL,	NULL),
(110,	'MXGxMiR4Zmya7As38nRY5u2mUvApOY',	'2021-09-11 16:46:21.053493',	'read write',	3,	7,	'2021-09-11 06:46:21.054943',	'2021-09-11 06:46:21.054975',	NULL,	NULL),
(111,	'twLIqFQtCgLa3TuhA6y3gBSgvnAT9l',	'2021-09-11 16:50:23.958702',	'read write',	3,	7,	'2021-09-11 06:50:23.959803',	'2021-09-11 06:50:23.959831',	NULL,	NULL),
(112,	'ZXopV613bKXvaBuvYylL69HyLnf343',	'2021-09-11 16:53:54.845189',	'read write',	3,	7,	'2021-09-11 06:53:54.845875',	'2021-09-11 06:53:54.845902',	NULL,	NULL),
(113,	'GWVxnbArX8YcliUCx0sqgHOiW9EXHY',	'2021-09-11 17:09:28.101501',	'read write',	3,	7,	'2021-09-11 07:09:28.102221',	'2021-09-11 07:09:28.102252',	NULL,	NULL),
(114,	'cAm3KsXtT5pEP381ozhow17UVQLufR',	'2021-09-11 17:09:29.600775',	'read write',	3,	7,	'2021-09-11 07:09:29.601595',	'2021-09-11 07:09:29.601625',	NULL,	NULL),
(115,	'vQnqEGlRbWouNTyq0pyCt7VFMDpXP8',	'2021-09-11 17:20:55.558539',	'read write',	3,	7,	'2021-09-11 07:20:55.559614',	'2021-09-11 07:20:55.559643',	NULL,	NULL),
(116,	'F8F5PwDrvvcBEPfNp1vLrL0iDJYqsu',	'2021-09-12 19:46:30.584532',	'read write',	3,	7,	'2021-09-12 09:46:30.586084',	'2021-09-12 09:46:30.586122',	NULL,	NULL),
(117,	'1LqpfCpMvnjkDLf6hxetDlbIDwEnGR',	'2021-09-13 15:12:06.013472',	'read write',	3,	7,	'2021-09-13 05:12:06.015719',	'2021-09-13 05:12:06.015756',	NULL,	NULL),
(118,	'NynPetLnoxlmFnddiSdNSnGCU87bPF',	'2021-09-14 17:04:36.358053',	'read write',	3,	7,	'2021-09-14 07:04:36.386428',	'2021-09-14 07:04:36.386472',	89,	NULL),
(119,	'p9PUdALPPiTAZNT6IXZXSF1735c0Qn',	'2021-09-15 02:27:08.058072',	'read write',	3,	7,	'2021-09-14 16:27:08.058429',	'2021-09-14 16:27:08.058439',	NULL,	NULL),
(120,	'ux5VtvGty1Jdx9uilJGp387uWaFV8p',	'2021-09-15 02:28:38.168585',	'read write',	3,	7,	'2021-09-14 16:28:38.168866',	'2021-09-14 16:28:38.168876',	NULL,	NULL),
(121,	'k7ggWHrYcgfK8LAgOO6Ahv4FFoPMpm',	'2021-09-15 02:43:38.222121',	'read write',	3,	7,	'2021-09-14 16:43:38.222428',	'2021-09-14 16:43:38.222437',	NULL,	NULL),
(123,	'8yTJriRlwb1RuQyp78iptWYnc5OjK0',	'2021-09-15 13:13:57.103160',	'read write',	3,	7,	'2021-09-15 03:13:57.118555',	'2021-09-15 03:13:57.118565',	122,	NULL),
(124,	'qRX9fEbiuzfrfy9Cmf5bgZSkwlxeid',	'2021-09-15 13:49:04.739173',	'read write',	3,	7,	'2021-09-15 03:49:04.739482',	'2021-09-15 03:49:04.739492',	NULL,	NULL),
(125,	'LvAsg7Hk1K0YzvjWxMDMaEh0gUKmsO',	'2021-09-15 13:50:19.869355',	'read write',	3,	7,	'2021-09-15 03:50:19.869616',	'2021-09-15 03:50:19.869627',	NULL,	NULL),
(126,	'dVysKD2krAVjxBgLiYjZ67Zo3ZdmbB',	'2021-09-15 13:51:57.987122',	'read write',	3,	7,	'2021-09-15 03:51:57.987413',	'2021-09-15 03:51:57.987423',	NULL,	NULL),
(127,	'yDKpxXiM7UPKGP4KTcl2yZDN9KTdbU',	'2021-09-15 13:52:54.835603',	'read write',	3,	7,	'2021-09-15 03:52:54.835888',	'2021-09-15 03:52:54.835897',	NULL,	NULL),
(128,	'f0XZzYbQCXnpBB7zpUVHl0sligRMD0',	'2021-09-15 14:09:30.029543',	'read write',	3,	7,	'2021-09-15 04:09:30.029842',	'2021-09-15 04:09:30.029852',	NULL,	NULL),
(129,	'bYj24GXn16Y9rYRvtl7X44oV0t9HMt',	'2021-09-15 14:09:58.421380',	'read write',	3,	7,	'2021-09-15 04:09:58.421682',	'2021-09-15 04:09:58.421692',	NULL,	NULL),
(130,	'kv2d0MvSGAUJhPiVGWwBTSf4jDChXq',	'2021-09-15 16:04:12.846002',	'read write',	3,	7,	'2021-09-15 06:04:12.846414',	'2021-09-15 06:04:12.846424',	NULL,	NULL),
(131,	'SfAa7xc692ZZ7LJNWf1A8HxUx9UZsP',	'2021-09-15 16:09:31.691868',	'read write',	3,	7,	'2021-09-15 06:09:31.692185',	'2021-09-15 06:09:31.692195',	NULL,	NULL),
(132,	'7BOhHbMSgfLNZy7moBDblresnQLhMn',	'2021-09-15 17:09:09.327644',	'read write',	3,	7,	'2021-09-15 07:09:09.327947',	'2021-09-15 07:09:09.327957',	NULL,	NULL),
(133,	'n4bJS5OHYqT0LtSgxUhlhfLlCbGdLR',	'2021-09-15 19:07:31.839445',	'read write',	3,	16,	'2021-09-15 09:07:31.839776',	'2021-09-15 09:07:31.839786',	NULL,	NULL),
(134,	'ecDeYX2PmWlPeEULc5jfXWaTxnuI2j',	'2021-09-15 19:11:54.756289',	'read write',	3,	16,	'2021-09-15 09:11:54.756570',	'2021-09-15 09:11:54.756580',	NULL,	NULL),
(135,	'QNjWEJqYi6dHZwoJMalsynZdnRzPpm',	'2021-09-15 19:32:48.730872',	'read write',	3,	16,	'2021-09-15 09:32:48.731238',	'2021-09-15 09:32:48.731248',	NULL,	NULL),
(136,	'kePvB3TiLBxK8WRGZFBjRrHxVNy51B',	'2021-09-15 19:47:43.119704',	'read write',	3,	7,	'2021-09-15 09:47:43.120071',	'2021-09-15 09:47:43.120081',	NULL,	NULL),
(137,	'jicdRhnDmdee1Y5YIlaQgt6q4sVCfO',	'2021-09-15 19:56:37.310609',	'read write',	3,	16,	'2021-09-15 09:56:37.310917',	'2021-09-15 09:56:37.310927',	NULL,	NULL),
(138,	'DvRatd5aPKNkjaprSygpIb4qmtd9Yk',	'2021-09-15 20:15:32.563542',	'read write',	3,	17,	'2021-09-15 10:15:32.563937',	'2021-09-15 10:15:32.563946',	NULL,	NULL),
(139,	'oTtwf0W8Qf2w3mSjfvpdCwaqOzbIjT',	'2021-09-15 22:35:15.431273',	'read write',	3,	7,	'2021-09-15 12:35:15.431647',	'2021-09-15 12:35:15.431658',	NULL,	NULL),
(140,	'OzPwzQjVtdn4MXChzGtHHHjcxQzbJN',	'2021-09-15 22:47:12.486938',	'read write',	3,	16,	'2021-09-15 12:47:12.487254',	'2021-09-15 12:47:12.487265',	NULL,	NULL),
(141,	'u9jcHkXGVfgIhAJNHXnDX6kTFy7mf8',	'2021-09-16 18:53:30.043587',	'read write',	3,	7,	'2021-09-16 08:53:30.044609',	'2021-09-16 08:53:30.044637',	NULL,	NULL);

DROP TABLE IF EXISTS `oauth2_provider_application`;
CREATE TABLE `oauth2_provider_application` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `client_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `redirect_uris` longtext COLLATE utf8_unicode_ci NOT NULL,
  `client_type` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `authorization_grant_type` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `client_secret` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `skip_authorization` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `algorithm` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `oauth2_provider_appl_user_id_79829054_fk_social_ne` (`user_id`),
  KEY `oauth2_provider_application_client_secret_53133678` (`client_secret`),
  CONSTRAINT `oauth2_provider_appl_user_id_79829054_fk_social_ne` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `oauth2_provider_application`;
INSERT INTO `oauth2_provider_application` (`id`, `client_id`, `redirect_uris`, `client_type`, `authorization_grant_type`, `client_secret`, `name`, `user_id`, `skip_authorization`, `created`, `updated`, `algorithm`) VALUES
(3,	'TPLrxQE8mF9slRzevZSNbNCLQXDSSbJrnIprMCNM',	'',	'confidential',	'password',	'QRHKVKgNnYo8GmwvxUfFtJRAtvtoLTD4mDoNtWzxulgFhrY8rssWssFglvAvZxZpm2vHHBY2nIJDHETm3SOONxD0ADRKL0ald5Ip8hCoUeOAxQn8KipFFjkU64LlzlCQ',	'social-app',	1,	0,	'2021-08-30 09:13:44.257565',	'2021-08-30 09:13:44.257620',	'');

DROP TABLE IF EXISTS `oauth2_provider_grant`;
CREATE TABLE `oauth2_provider_grant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `redirect_uri` longtext COLLATE utf8_unicode_ci NOT NULL,
  `scope` longtext COLLATE utf8_unicode_ci NOT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `code_challenge` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `code_challenge_method` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `nonce` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `claims` longtext COLLATE utf8_unicode_ci NOT NULL DEFAULT (_utf8mb3''),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_grant_user_id_e8f62af8_fk_social_network_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_grant_user_id_e8f62af8_fk_social_network_user_id` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `oauth2_provider_grant`;

DROP TABLE IF EXISTS `oauth2_provider_idtoken`;
CREATE TABLE `oauth2_provider_idtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `jti` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jti` (`jti`),
  KEY `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_idto_user_id_dd512b59_fk_social_ne` (`user_id`),
  CONSTRAINT `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_idto_user_id_dd512b59_fk_social_ne` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `oauth2_provider_idtoken`;

DROP TABLE IF EXISTS `oauth2_provider_refreshtoken`;
CREATE TABLE `oauth2_provider_refreshtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `access_token_id` bigint DEFAULT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `revoked` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_token_id` (`access_token_id`),
  UNIQUE KEY `oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq` (`token`,`revoked`),
  KEY `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_refr_user_id_da837fce_fk_social_ne` (`user_id`),
  CONSTRAINT `oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr` FOREIGN KEY (`access_token_id`) REFERENCES `oauth2_provider_accesstoken` (`id`),
  CONSTRAINT `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_refr_user_id_da837fce_fk_social_ne` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `oauth2_provider_refreshtoken`;
INSERT INTO `oauth2_provider_refreshtoken` (`id`, `token`, `access_token_id`, `application_id`, `user_id`, `created`, `updated`, `revoked`) VALUES
(1,	'IW3ccfH5JbCSH3VGG92elqu8Vmo25O',	1,	3,	1,	'2021-08-30 09:44:53.402979',	'2021-08-30 09:44:53.402996',	NULL),
(2,	'wn7ogMMTLiApLLMIj7IXwzbZ3TYhsa',	2,	3,	7,	'2021-08-31 01:02:05.219779',	'2021-08-31 01:02:05.219804',	NULL),
(3,	'3G3ZV86kneIrbl6BqrC9q5ODJpP1Vr',	3,	3,	7,	'2021-08-31 08:40:40.971517',	'2021-08-31 08:40:40.971566',	NULL),
(4,	'sgjw1kETfvBWBdS4jezHGMr6lgwayh',	4,	3,	7,	'2021-09-01 02:29:38.853511',	'2021-09-01 02:29:38.853555',	NULL),
(5,	'a2eqChN5d8HE2kFgWFbXg6z4ODWj2N',	5,	3,	7,	'2021-09-01 08:40:39.846652',	'2021-09-01 08:40:39.846695',	NULL),
(6,	'Q5vHICnp864GymQcTUA541rNQSiYmV',	6,	3,	7,	'2021-09-01 09:36:59.113826',	'2021-09-01 09:36:59.113860',	NULL),
(7,	'GGHx6XSKH3ahi0QdXo42FFZbgVTDql',	7,	3,	7,	'2021-09-01 10:07:24.283066',	'2021-09-01 10:07:24.283094',	NULL),
(8,	'93GVWwDVBrxzhYdynqym3JZNL06k9G',	8,	3,	7,	'2021-09-01 10:10:29.451751',	'2021-09-01 10:10:29.451768',	NULL),
(9,	'17TrUEwwvfZ3f9C3mP5zWubd5rxAd9',	9,	3,	7,	'2021-09-01 10:11:13.482957',	'2021-09-01 10:11:13.482974',	NULL),
(10,	'2wuXUgyOziSckuk9tBDgZv3cW66XHl',	10,	3,	7,	'2021-09-01 10:11:26.209948',	'2021-09-01 10:11:26.209965',	NULL),
(11,	'HMLZYkEOs7be3GP17pORDDQjNXfRPS',	11,	3,	7,	'2021-09-01 10:15:53.259209',	'2021-09-01 10:15:53.259227',	NULL),
(12,	'CsqHmSGHULyhMgu4DxPz8EY2VOO7gC',	12,	3,	7,	'2021-09-02 01:14:34.876009',	'2021-09-02 01:14:34.876039',	NULL),
(13,	'UIJeAC6hco6qyi7neXIYBaDD9ed0S7',	13,	3,	7,	'2021-09-02 01:17:28.877344',	'2021-09-02 01:17:28.877373',	NULL),
(14,	'db3Y015ODzRwi0OoM9SdBkk5N25qsl',	14,	3,	7,	'2021-09-02 02:30:20.929311',	'2021-09-02 02:30:20.929350',	NULL),
(15,	'jK3f2I2aigQwPQisZeMHpMEw8043Fk',	15,	3,	7,	'2021-09-02 02:33:54.766368',	'2021-09-02 02:33:54.766415',	NULL),
(16,	'6jTlBSz3pWckizPzlB4m2EQZxjsQtH',	16,	3,	7,	'2021-09-02 04:24:29.717109',	'2021-09-02 04:24:29.717152',	NULL),
(17,	'SE7bMDABZK59CPm2Ba7y7LDFBbr8HB',	17,	3,	7,	'2021-09-02 06:47:38.142734',	'2021-09-02 06:47:38.142775',	NULL),
(18,	'QB17ttALwplNjI7AkPsYzwHa7SQLzL',	18,	3,	1,	'2021-09-02 06:55:39.739181',	'2021-09-02 06:55:39.739229',	NULL),
(19,	'hvO087BEBsaoCQrzecUgM2KKBXWzZ9',	19,	3,	7,	'2021-09-02 07:09:49.671591',	'2021-09-02 07:09:49.671630',	NULL),
(20,	'mkOI9ALiUvPO2kPRTnZGhdCMU4kAfB',	20,	3,	7,	'2021-09-02 07:17:32.938260',	'2021-09-02 07:17:32.938295',	NULL),
(21,	'1CGH8L2O22xputcSKyUnRbxAe7sIbu',	21,	3,	7,	'2021-09-02 07:19:18.583719',	'2021-09-02 07:19:18.583755',	NULL),
(22,	'SAlIe90L5DbsElyJtTGz7UXZedG00t',	22,	3,	7,	'2021-09-02 07:25:07.537108',	'2021-09-02 07:25:07.537144',	NULL),
(23,	'71T3UODSqNsDnZu4T2QQcpRwwvMEON',	23,	3,	1,	'2021-09-02 08:06:01.518720',	'2021-09-02 08:06:01.518759',	NULL),
(24,	'9YccHRNZMcYn0yi9XcMjr80BWMZiab',	24,	3,	1,	'2021-09-02 08:35:07.302385',	'2021-09-02 08:35:07.302432',	NULL),
(25,	'GX2drgA8Jk5madd170qgq0qZepRnFg',	25,	3,	7,	'2021-09-02 08:36:50.766782',	'2021-09-02 08:36:50.766799',	NULL),
(26,	'EIaNxi110TrCJ6W4nwXJhmU6IaL7b5',	26,	3,	7,	'2021-09-02 09:30:18.261768',	'2021-09-02 09:30:18.261813',	NULL),
(27,	'HOULY6WSfl4JubFwVa6dj5k2CYrC2R',	27,	3,	7,	'2021-09-02 10:10:45.346076',	'2021-09-02 10:10:45.346095',	NULL),
(28,	'ebr0mAVKHuet8MUQMJ5QICj9JTcPCJ',	28,	3,	7,	'2021-09-03 02:27:27.424864',	'2021-09-03 02:27:27.424903',	NULL),
(29,	'F4Bm1ejUa0gPXZKi13IpQn1nBwzxvZ',	29,	3,	7,	'2021-09-03 02:38:48.093688',	'2021-09-03 02:38:48.093706',	NULL),
(30,	'8R5Z0o7yCptznvoNoGJ1yKlbw9imgo',	30,	3,	7,	'2021-09-03 02:38:56.867861',	'2021-09-03 02:38:56.867886',	NULL),
(31,	'9KH4qekNb6n0ElbbezKVNQj1gdNNU4',	31,	3,	7,	'2021-09-03 03:36:03.187540',	'2021-09-03 03:36:03.187566',	NULL),
(32,	'Vau2onc7OPrr9SricjsnyUQnauesMw',	32,	3,	7,	'2021-09-03 07:02:11.293657',	'2021-09-03 07:02:11.293701',	NULL),
(33,	'sknjrhxvfJ4WRwSPQhNE9OIfv9A4Bl',	33,	3,	7,	'2021-09-03 07:03:00.272603',	'2021-09-03 07:03:00.272650',	NULL),
(34,	'aEWR7A6S0IDU7w0fREnYavoe9q84Wf',	34,	3,	7,	'2021-09-03 08:31:50.830172',	'2021-09-03 08:31:50.830218',	NULL),
(35,	'bBUYGtrhz18SpSMOBsFn2Epg7icYLH',	35,	3,	7,	'2021-09-03 08:58:51.291187',	'2021-09-03 08:58:51.291235',	NULL),
(36,	'UaU7NvQHtT2MxyGfuRqVtmVX8ARLAR',	36,	3,	7,	'2021-09-03 09:37:34.669437',	'2021-09-03 09:37:34.669485',	NULL),
(37,	'u4JaydJYNwNKkKzrpBWXxngcijfdMU',	37,	3,	7,	'2021-09-03 10:06:53.039509',	'2021-09-03 10:06:53.039556',	NULL),
(38,	'11tioZisjPMCiDG4HGoaN5X6IgrvLu',	38,	3,	7,	'2021-09-03 10:15:05.091805',	'2021-09-03 10:15:05.091850',	NULL),
(39,	'f8EPLq4ECt0pfyvybFMPBdTqmuhBR3',	39,	3,	7,	'2021-09-03 10:33:19.325794',	'2021-09-03 10:33:19.325836',	NULL),
(40,	'uvxs5HFj2mmyPJFqdniS9TpPkBXp7Q',	40,	3,	7,	'2021-09-03 13:29:55.552287',	'2021-09-03 13:29:55.552331',	NULL),
(41,	'Gm9ty1UpDFa9s5RrkvdqU8qsaBsf8b',	41,	3,	7,	'2021-09-04 00:34:58.605530',	'2021-09-04 00:34:58.605571',	NULL),
(42,	'94PhPekHM8UBpeoz9YjkReHvG2HfbS',	42,	3,	7,	'2021-09-04 02:36:58.867655',	'2021-09-04 02:36:58.867696',	NULL),
(43,	'CiFiSsYEBFFzTS3aHT4UXqvhk893Ak',	43,	3,	7,	'2021-09-04 03:00:36.136717',	'2021-09-04 03:00:36.136764',	NULL),
(44,	'ipgdQHQuEawBdsazVpyUKdOAp8FRvk',	44,	3,	7,	'2021-09-04 03:30:14.979258',	'2021-09-04 03:30:14.979305',	NULL),
(45,	'ZFwY4shgPHyJzdX4gyLR8qCn8winhu',	45,	3,	7,	'2021-09-04 04:17:24.603652',	'2021-09-04 04:17:24.603688',	NULL),
(46,	'xqnIccSNNXU4uraFLz1aZPulN08abk',	46,	3,	7,	'2021-09-04 12:15:17.830257',	'2021-09-04 12:15:17.830276',	NULL),
(47,	'0PkVUjlXfZOO5etTfHyYPCPRLiqScm',	47,	3,	7,	'2021-09-04 12:28:42.008810',	'2021-09-04 12:28:42.008827',	NULL),
(48,	'cGAeEj6VklLqXevRmOl53TwrONYkZd',	48,	3,	7,	'2021-09-05 01:58:09.873532',	'2021-09-05 01:58:09.873596',	NULL),
(49,	'qdiemrROHrTOVD0o6RRlP2mMnS9hAB',	49,	3,	7,	'2021-09-05 03:29:40.904622',	'2021-09-05 03:29:40.904669',	NULL),
(50,	'PcX3bBpPUW4oaXfuhppa4dQbvDPtg6',	50,	3,	7,	'2021-09-05 04:07:08.060319',	'2021-09-05 04:07:08.060366',	NULL),
(51,	'ifZSkwyGIHMRbiTXKr0A6xDhoyxVFj',	51,	3,	7,	'2021-09-05 04:17:45.714975',	'2021-09-05 04:17:45.715022',	NULL),
(52,	'BSCngDtPwMvpndrjXgCOt2xSBb6mOu',	52,	3,	7,	'2021-09-05 08:51:04.269241',	'2021-09-05 08:51:04.269265',	NULL),
(53,	'0E0iv2wARhF6z6RiTJTQMgR5yxof1k',	53,	3,	10,	'2021-09-05 09:00:27.444211',	'2021-09-05 09:00:27.444229',	NULL),
(54,	'ek14y3zi9Tapd6HD09rpxbnaYYewGv',	54,	3,	7,	'2021-09-07 01:40:54.088136',	'2021-09-07 01:40:54.088158',	NULL),
(55,	'EkKILLawc1ZouhkKQei0VaC0GmmGvn',	55,	3,	7,	'2021-09-07 14:31:07.117267',	'2021-09-07 14:31:07.117290',	NULL),
(56,	'l6GvpbhsGZaAtrNKKxmRhNtcS0PxtG',	56,	3,	7,	'2021-09-07 14:31:07.264530',	'2021-09-07 14:31:07.264546',	NULL),
(57,	'r0vwxzbg4fFahXRo0i50xRGrpcllou',	57,	3,	7,	'2021-09-07 14:31:07.424433',	'2021-09-07 14:31:07.424450',	NULL),
(58,	'41oQMbbC63Cs9T5919Fgaem0j8DJ6V',	58,	3,	7,	'2021-09-08 03:10:44.132708',	'2021-09-08 03:10:44.132726',	NULL),
(59,	'LCHGvKHyecBJufJxoPYBjAmgP9AlkS',	59,	3,	7,	'2021-09-08 03:16:58.805401',	'2021-09-08 03:16:58.805418',	NULL),
(60,	'PrkdaPbUzopFhWNBSa0iHlE3Z2VfvB',	60,	3,	7,	'2021-09-08 03:49:24.065391',	'2021-09-08 03:49:24.065407',	NULL),
(61,	'rHYa7iaJ10EdZexpUcXKilJIXlWXLs',	61,	3,	7,	'2021-09-08 03:52:33.649398',	'2021-09-08 03:52:33.649414',	NULL),
(62,	'DtbVSE00CkBmcQprg3ETqmhjtu3qKU',	62,	3,	7,	'2021-09-08 03:59:11.324869',	'2021-09-08 03:59:11.324885',	NULL),
(63,	'1b11MJvFH9gqX91jFhky4CmWvkERpF',	63,	3,	7,	'2021-09-08 03:59:12.428416',	'2021-09-08 03:59:12.428433',	NULL),
(64,	'PpUqn2Sir8dsGbmqKj3EGaRbrR95gf',	64,	3,	7,	'2021-09-08 06:29:19.740400',	'2021-09-08 06:29:19.740434',	NULL),
(65,	'bmxlc34R20UTUxPEZyadHpsCqmPgCh',	65,	3,	7,	'2021-09-08 06:30:51.764801',	'2021-09-08 06:30:51.764820',	NULL),
(66,	'zsBAPCEKe3jFSzwqVZFffxoSWApbGX',	66,	3,	7,	'2021-09-08 06:34:49.325621',	'2021-09-08 06:34:49.325644',	NULL),
(67,	'MKDucQKlDMsRdc6PK5gmQlweNZOp0N',	67,	3,	1,	'2021-09-08 08:17:35.418196',	'2021-09-08 08:17:35.418251',	NULL),
(68,	'zGAoTkBUvZSjVn8I8IK8XIAVBpu6g0',	68,	3,	7,	'2021-09-08 08:20:20.624240',	'2021-09-08 08:20:20.624256',	NULL),
(69,	'2J22XxgG0Xhz77LYOoYFqlOPXPS1Tg',	69,	3,	7,	'2021-09-08 15:39:02.973562',	'2021-09-08 15:39:02.973656',	NULL),
(70,	'SrmqFFFzy1OmR8aojBoCDSYnJRaoSf',	70,	3,	7,	'2021-09-08 16:16:32.127436',	'2021-09-08 16:16:32.127453',	NULL),
(71,	'RmHfrRJJh6I9IJdH6H6t8txRyw60is',	71,	3,	7,	'2021-09-08 16:53:23.277914',	'2021-09-08 16:53:23.277931',	NULL),
(72,	'feMLxLqM0dZcj7mZrdQU7epZTVIXVD',	72,	3,	7,	'2021-09-09 00:05:09.086275',	'2021-09-09 00:05:09.086293',	NULL),
(73,	'vuN7XvIefXsD2d0DHxglKFiPHHQ7RH',	73,	3,	7,	'2021-09-09 00:30:01.700871',	'2021-09-09 00:30:01.700888',	NULL),
(74,	'sLibAmWjmZI0R7312cd9YMIQAFGggN',	74,	3,	7,	'2021-09-09 07:42:41.274639',	'2021-09-09 07:42:41.274659',	NULL),
(75,	'2QTN3MxVgh11M4WOZVQ64tUrOakJxc',	75,	3,	7,	'2021-09-09 09:50:33.022117',	'2021-09-09 09:50:33.022167',	NULL),
(76,	'PM2yivASAvCiwNj2vZUKDfMQq9aEvE',	NULL,	3,	7,	'2021-09-09 09:51:07.611483',	'2021-09-09 09:52:18.434275',	'2021-09-09 09:52:18.434050'),
(77,	'JB0y89t28YFuqgekfhuOPv1UyoiDTN',	NULL,	3,	7,	'2021-09-09 09:52:18.438122',	'2021-09-09 09:53:44.009251',	'2021-09-09 09:53:44.009088'),
(78,	'n1zgnEFD7E5qUMpdCfUeoTryXbuxtk',	78,	3,	7,	'2021-09-09 09:53:44.013035',	'2021-09-09 09:53:44.013083',	NULL),
(79,	'eG1kDTAAZVe7G21NyqW4AcdgvwHpHn',	79,	3,	7,	'2021-09-09 13:02:06.786838',	'2021-09-09 13:02:06.786859',	NULL),
(80,	'O0DBmOnHhkXZ3wfr1em9kCWUDMndes',	80,	3,	7,	'2021-09-09 14:21:45.782250',	'2021-09-09 14:21:45.782267',	NULL),
(81,	'hgtiLlZnUrYlXFouvwlYqWJgt9jw41',	81,	3,	7,	'2021-09-09 14:33:59.195824',	'2021-09-09 14:33:59.195839',	NULL),
(82,	'F5OGgS4yq1jFQsWWcv9LgchvVOPirb',	82,	3,	7,	'2021-09-09 14:36:15.639216',	'2021-09-09 14:36:15.639232',	NULL),
(83,	'HTbeBGAZrVK8BsrQpsG32bURmON9CH',	83,	3,	7,	'2021-09-10 01:45:39.483863',	'2021-09-10 01:45:39.483881',	NULL),
(84,	'h6xOL0tCK4liroaq2bGt3GJdSdKYlC',	84,	3,	7,	'2021-09-10 02:00:24.835414',	'2021-09-10 02:00:24.835431',	NULL),
(85,	'GAXhzRrl9aBuZqtQocOlkqTdqnI8rx',	85,	3,	7,	'2021-09-10 02:09:58.391383',	'2021-09-10 02:09:58.391411',	NULL),
(86,	'Lwjf2yWF0NaztbndGfKLiF8naGy160',	NULL,	3,	7,	'2021-09-10 02:26:28.655231',	'2021-09-10 15:18:05.137573',	'2021-09-10 15:18:05.137261'),
(87,	'wUCJ8cApTovQfs3xqSvqIWQiUq0k2D',	NULL,	3,	7,	'2021-09-10 15:18:05.145013',	'2021-09-11 02:35:51.492477',	'2021-09-11 02:35:51.492154'),
(88,	'fXfFk2CnaRn0vczn1WqSUlGXQWKU5B',	88,	3,	7,	'2021-09-10 17:16:37.948174',	'2021-09-10 17:16:37.948192',	NULL),
(89,	'2LuuIoJxCaCEFKazoLyWkDQWLsnQSl',	NULL,	3,	7,	'2021-09-11 02:35:51.499562',	'2021-09-14 07:04:36.381748',	'2021-09-14 07:04:36.381403'),
(90,	'Cwi6b1xZVDAZXTskjnSIUp3PdEbaFr',	90,	3,	7,	'2021-09-11 02:38:53.698299',	'2021-09-11 02:38:53.698316',	NULL),
(91,	'0saVdbO9yO4gPkudzaLiY8oLX7Yxy4',	91,	3,	7,	'2021-09-11 02:49:14.990187',	'2021-09-11 02:49:14.990207',	NULL),
(92,	'5irwduHggD0w6GMnuqXbF57BD9p4mO',	92,	3,	7,	'2021-09-11 03:01:12.689957',	'2021-09-11 03:01:12.690003',	NULL),
(93,	'NftkxEJjIJrpHeHF878mvNKcwBzUAG',	93,	3,	7,	'2021-09-11 03:02:06.073510',	'2021-09-11 03:02:06.073556',	NULL),
(94,	'JcHEHdP4gocRxvu5TDdocrIJz4xc5x',	94,	3,	7,	'2021-09-11 03:02:56.911665',	'2021-09-11 03:02:56.911718',	NULL),
(95,	'gqVvjKrwGL3bvVP3qjIc0ZFQTKIG7X',	95,	3,	7,	'2021-09-11 03:10:22.181919',	'2021-09-11 03:10:22.181966',	NULL),
(96,	'3AIFNyzhrubtFXdAbdV7n417XdkpbF',	96,	3,	7,	'2021-09-11 03:21:04.209351',	'2021-09-11 03:21:04.209400',	NULL),
(97,	'csJc4CwhsjkqPA1Pko5K2fYAXXWUGd',	97,	3,	7,	'2021-09-11 03:25:05.009055',	'2021-09-11 03:25:05.009146',	NULL),
(98,	'3FpICoxPFTkKoPAO2GYxNeSDWodhwH',	98,	3,	7,	'2021-09-11 03:25:54.564923',	'2021-09-11 03:25:54.564968',	NULL),
(99,	'sk5pFWf3OFqezOieCM7qEcxHAHmVzq',	99,	3,	7,	'2021-09-11 06:00:55.518926',	'2021-09-11 06:00:55.518972',	NULL),
(100,	'LED2C10G6iI8O3c0ttbno1PxNx1ssm',	100,	3,	7,	'2021-09-11 06:04:11.973654',	'2021-09-11 06:04:11.973703',	NULL),
(101,	'g4Ht6lHEIsVaA6QfwqamGiJEgKjDXB',	101,	3,	7,	'2021-09-11 06:06:11.560657',	'2021-09-11 06:06:11.560703',	NULL),
(102,	'8tF1qmAlZJ08r8GgRTzHOGbr2ZuzVM',	102,	3,	7,	'2021-09-11 06:12:28.520636',	'2021-09-11 06:12:28.520682',	NULL),
(103,	'l8V1SBmPId3OELBdM9Lw0kQwwbmkSu',	103,	3,	7,	'2021-09-11 06:12:30.058880',	'2021-09-11 06:12:30.059004',	NULL),
(104,	'eUmWELrmoIQiOwxDTrCdmak8nuYOP4',	104,	3,	7,	'2021-09-11 06:28:13.278466',	'2021-09-11 06:28:13.278511',	NULL),
(105,	'CSzdu2FhQgimqlKGTj9QC4M6PpbObj',	105,	3,	7,	'2021-09-11 06:35:08.344877',	'2021-09-11 06:35:08.344923',	NULL),
(106,	'I7jBdk5UEUFK4wRdfNWoZlFichi0Dy',	106,	3,	7,	'2021-09-11 06:37:17.316797',	'2021-09-11 06:37:17.316843',	NULL),
(107,	'xmJu3iZRlv39XtQ4Q7gMQGg1o5MATm',	107,	3,	7,	'2021-09-11 06:41:45.175543',	'2021-09-11 06:41:45.175590',	NULL),
(108,	'UtU6sQCzZeECoo5x6sprj5Imv7f9Yl',	108,	3,	7,	'2021-09-11 06:43:43.889202',	'2021-09-11 06:43:43.889268',	NULL),
(109,	'npnzIznbzfGdTm1ovW9PWSn8UoEZmP',	109,	3,	7,	'2021-09-11 06:45:12.168268',	'2021-09-11 06:45:12.168313',	NULL),
(110,	'e6k2ckXgfD7XZFjiq8AMY4iwRwPhdl',	110,	3,	7,	'2021-09-11 06:46:21.076108',	'2021-09-11 06:46:21.076153',	NULL),
(111,	'eadfmLM3xFhf8P7yoXK0gCQjJHWv7u',	111,	3,	7,	'2021-09-11 06:50:23.980447',	'2021-09-11 06:50:23.980568',	NULL),
(112,	'QzyVE8MKLvUVvvcIiJbDymRQOrSY3i',	112,	3,	7,	'2021-09-11 06:53:54.865840',	'2021-09-11 06:53:54.865886',	NULL),
(113,	'nVu4LQmXxrzJ3Le1XUhr5S9JvApVMw',	113,	3,	7,	'2021-09-11 07:09:28.123171',	'2021-09-11 07:09:28.123249',	NULL),
(114,	'D4OGMXm7YzQSuO8HGaR6ARs5xz1w3L',	114,	3,	7,	'2021-09-11 07:09:29.636429',	'2021-09-11 07:09:29.636479',	NULL),
(115,	'50ICrNsL9daJqEjUMGltHaYkFmCUdO',	115,	3,	7,	'2021-09-11 07:20:55.580578',	'2021-09-11 07:20:55.580624',	NULL),
(116,	'QZEJ38GNSmv52iUSORQQWduHcDzkp3',	116,	3,	7,	'2021-09-12 09:46:30.610207',	'2021-09-12 09:46:30.610254',	NULL),
(117,	'eNOUXsP3IKCTrSUv1YeSNTrwu9O6Bi',	117,	3,	7,	'2021-09-13 05:12:06.058862',	'2021-09-13 05:12:06.058965',	NULL),
(118,	'hUuK92UBYFWcyDYmQ4KzflGwFrZGaW',	118,	3,	7,	'2021-09-14 07:04:36.388712',	'2021-09-14 07:04:36.388784',	NULL),
(119,	'lWqK6YaDijemXSn7uCqvGkQOZffhmJ',	119,	3,	7,	'2021-09-14 16:27:08.076829',	'2021-09-14 16:27:08.076855',	NULL),
(120,	'2F3PL6b5pMS3pAzhKzzwh36vGQ183p',	120,	3,	7,	'2021-09-14 16:28:38.169606',	'2021-09-14 16:28:38.169623',	NULL),
(121,	'TBJDdUKoFfboSQQK53LJGBjGySfB6T',	121,	3,	7,	'2021-09-14 16:43:38.223163',	'2021-09-14 16:43:38.223180',	NULL),
(122,	'68XlBhmK3mXVCuznkBfdOkauI4hFAo',	NULL,	3,	7,	'2021-09-14 16:47:18.934775',	'2021-09-15 03:13:57.115612',	'2021-09-15 03:13:57.115340'),
(123,	'QHSpUw4ayTNk66m7s8hsMPvZknqHEO',	123,	3,	7,	'2021-09-15 03:13:57.119500',	'2021-09-15 03:13:57.119541',	NULL),
(124,	'KdnDe129Axx1HXJJYWcDuUsZIomflv',	124,	3,	7,	'2021-09-15 03:49:04.740215',	'2021-09-15 03:49:04.740230',	NULL),
(125,	'HQYZ4plMUTBVe7fLHFm5gxdAolp6zB',	125,	3,	7,	'2021-09-15 03:50:19.870328',	'2021-09-15 03:50:19.870344',	NULL),
(126,	'1g7IJ8rZCHQNrYIdehS34BYkJxxNQT',	126,	3,	7,	'2021-09-15 03:51:57.988126',	'2021-09-15 03:51:57.988142',	NULL),
(127,	'm2WmoJ50EngdL64QqH4Vrtyp4Avpe9',	127,	3,	7,	'2021-09-15 03:52:54.836607',	'2021-09-15 03:52:54.836623',	NULL),
(128,	'WKWw3QSYHW5Moh1j1YEqyLukXOZqCs',	128,	3,	7,	'2021-09-15 04:09:30.030583',	'2021-09-15 04:09:30.030599',	NULL),
(129,	'3BFFubGcgtTH9CD6ourSx7iVdsuSGj',	129,	3,	7,	'2021-09-15 04:09:58.422466',	'2021-09-15 04:09:58.422484',	NULL),
(130,	'0nUd1W3fSDMg1ITTLlxKT6tZ44oY6b',	130,	3,	7,	'2021-09-15 06:04:12.848966',	'2021-09-15 06:04:12.848984',	NULL),
(131,	'k9xIcCumiPDlurPKG8YwYiDu6Xy2y6',	131,	3,	7,	'2021-09-15 06:09:31.693024',	'2021-09-15 06:09:31.693040',	NULL),
(132,	'YFv5jGtHJ8fp6yLE1kk79xnrwFki1J',	132,	3,	7,	'2021-09-15 07:09:09.328726',	'2021-09-15 07:09:09.328742',	NULL),
(133,	'BRU3Cn4fkru3D9WKxpW7QcG0jvSd3A',	133,	3,	16,	'2021-09-15 09:07:31.840546',	'2021-09-15 09:07:31.840563',	NULL),
(134,	'rpnf8fcHL85j9BBH8qVbidEmo2Puf7',	134,	3,	16,	'2021-09-15 09:11:54.757357',	'2021-09-15 09:11:54.757374',	NULL),
(135,	'8pU1xgK0ATTVpUaZXDZymzBvDg0eiW',	135,	3,	16,	'2021-09-15 09:32:48.733742',	'2021-09-15 09:32:48.733758',	NULL),
(136,	'JS1YdIIeBhAcozyI3MlzgYkcx2WzLG',	136,	3,	7,	'2021-09-15 09:47:43.120856',	'2021-09-15 09:47:43.120873',	NULL),
(137,	'7Mt6dhevAJpHAsqbboO3nH32RY18zr',	137,	3,	16,	'2021-09-15 09:56:37.311667',	'2021-09-15 09:56:37.311684',	NULL),
(138,	'nTlAALjoP2ZoZafci8huVFVQR4xsrb',	138,	3,	17,	'2021-09-15 10:15:32.564742',	'2021-09-15 10:15:32.564760',	NULL),
(139,	't6v3YRDAevtSnPoBq71YSTCDDnxS8h',	139,	3,	7,	'2021-09-15 12:35:15.433850',	'2021-09-15 12:35:15.433867',	NULL),
(140,	'xUDLlmE9rBYmSEJh52dWf9pShGjUOX',	140,	3,	16,	'2021-09-15 12:47:12.488088',	'2021-09-15 12:47:12.488105',	NULL),
(141,	'zDVaFPyNvQUniKAnRvKS43Lkf9T6bs',	141,	3,	7,	'2021-09-16 08:53:30.049542',	'2021-09-16 08:53:30.049653',	NULL);

DROP TABLE IF EXISTS `social_network_auction`;
CREATE TABLE `social_network_auction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext COLLATE utf8_unicode_ci,
  `create_at` datetime(6) DEFAULT NULL,
  `title` varchar(225) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `count_comment` int NOT NULL,
  `base_price` double NOT NULL,
  `condition` longtext COLLATE utf8_unicode_ci,
  `deadline` datetime(6) NOT NULL,
  `date_success` datetime(6) DEFAULT NULL,
  `accept_price` double DEFAULT NULL,
  `status_auction` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `buyer_id` bigint DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_network_aucti_category_id_0a50e334_fk_social_ne` (`category_id`),
  KEY `social_network_aucti_user_id_f42c1fd2_fk_social_ne` (`user_id`),
  KEY `social_network_aucti_buyer_id_a53a418c_fk_social_ne` (`buyer_id`),
  CONSTRAINT `social_network_aucti_buyer_id_a53a418c_fk_social_ne` FOREIGN KEY (`buyer_id`) REFERENCES `social_network_user` (`id`),
  CONSTRAINT `social_network_aucti_category_id_0a50e334_fk_social_ne` FOREIGN KEY (`category_id`) REFERENCES `social_network_categoryauction` (`id`),
  CONSTRAINT `social_network_aucti_user_id_f42c1fd2_fk_social_ne` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_auction`;
INSERT INTO `social_network_auction` (`id`, `content`, `create_at`, `title`, `active`, `count_comment`, `base_price`, `condition`, `deadline`, `date_success`, `accept_price`, `status_auction`, `buyer_id`, `category_id`, `user_id`) VALUES
(1,	'Bán nhà gây quỹ vào từ thiện 50% lợi nhuận',	'2021-08-05 10:17:24.962753',	'Auction',	1,	2,	1000,	'NOP',	'2021-09-10 09:11:27.000000',	'2021-09-04 03:39:25.139497',	20000,	'succ',	7,	2,	7),
(2,	'comment auction',	'2021-09-02 08:57:07.206073',	'ahihi',	1,	1,	1000,	'no',	'2020-10-02 00:00:00.000000',	NULL,	0,	'being auctioned',	NULL,	1,	7),
(7,	'ahihi lan 2',	'2021-09-02 09:30:59.647487',	'test',	1,	0,	0,	'no',	'2020-02-02 00:00:00.000000',	NULL,	0,	'being auctioned',	NULL,	1,	7),
(8,	'nop',	'2021-09-02 10:14:21.359787',	'huhu',	1,	0,	1000,	'no',	'2020-10-03 00:00:00.000000',	NULL,	0,	'being auctioned',	NULL,	2,	7),
(9,	'ahihihihihihihi',	'2021-09-03 02:27:53.990976',	'ahihih',	1,	1,	0,	'no',	'2020-02-02 00:00:00.000000',	NULL,	0,	'being auctioned',	NULL,	2,	7),
(10,	'nopnopnopnop',	'2021-09-03 02:39:04.997890',	'huhuhuhuhuhu',	1,	0,	10,	'no',	'2020-10-03 00:00:00.000000',	NULL,	0,	'being auctioned',	NULL,	2,	7),
(12,	'Ahihi',	'2021-09-03 07:02:21.233534',	'Alala',	1,	0,	0,	'no',	'2020-02-02 12:00:00.000000',	NULL,	0,	'being auctioned',	NULL,	1,	7),
(13,	'change path static 1111111',	'2021-09-03 07:03:27.958068',	'huhuhuhuhuhu',	1,	0,	10,	'no',	'2020-10-03 00:00:00.000000',	NULL,	0,	'being auctioned',	NULL,	2,	7),
(14,	'change path static 1111111',	'2021-09-03 07:04:33.685324',	'huhuhuhuhuhu',	1,	0,	10,	'no',	'2020-10-03 00:00:00.000000',	NULL,	0,	'being auctioned',	NULL,	2,	7),
(15,	'change path static 1111111',	'2021-09-03 07:06:39.621430',	'huhuhuhuhuhu',	1,	0,	10,	'no',	'2020-10-03 12:00:00.000000',	NULL,	0,	'being auctioned',	NULL,	2,	7),
(16,	'change path static 1111111',	'2021-09-03 10:19:55.407666',	'huhuhuhuhuhu',	1,	0,	10,	'no',	'2020-10-03 12:00:00.000000',	NULL,	0,	'being auctioned',	NULL,	2,	7),
(17,	'change path static 1111111',	'2021-09-03 10:25:14.815380',	'huhuhuhuhuhu',	1,	0,	10,	'no',	'2020-10-03 12:00:00.000000',	NULL,	0,	'being auctioned',	NULL,	2,	7),
(18,	'them tu postman',	'2021-09-11 03:11:18.687600',	'huhuhuhuhuhu',	1,	0,	1000,	'no',	'2020-10-03 12:00:00.000000',	NULL,	0,	'being auctioned',	NULL,	2,	7),
(19,	'them tu postman',	'2021-09-11 03:18:19.521337',	'huhuhuhuhuhu',	1,	0,	1000,	'no',	'2020-10-03 12:00:00.000000',	NULL,	0,	'being auctioned',	NULL,	2,	7);

DROP TABLE IF EXISTS `social_network_auction_like`;
CREATE TABLE `social_network_auction_like` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `auction_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_network_auction_like_auction_id_user_id_ba8c7f0c_uniq` (`auction_id`,`user_id`),
  KEY `social_network_aucti_user_id_460a0327_fk_social_ne` (`user_id`),
  CONSTRAINT `social_network_aucti_auction_id_527b16ba_fk_social_ne` FOREIGN KEY (`auction_id`) REFERENCES `social_network_auction` (`id`),
  CONSTRAINT `social_network_aucti_user_id_460a0327_fk_social_ne` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_auction_like`;
INSERT INTO `social_network_auction_like` (`id`, `auction_id`, `user_id`) VALUES
(1,	1,	7),
(7,	1,	16),
(2,	7,	7),
(5,	7,	16),
(3,	8,	7);

DROP TABLE IF EXISTS `social_network_auctioncomment`;
CREATE TABLE `social_network_auctioncomment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext COLLATE utf8_unicode_ci,
  `create_at` datetime(6) DEFAULT NULL,
  `price` double NOT NULL,
  `status_transaction` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `auction_id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `social_network_aucti_auction_id_33992e6a_fk_social_ne` (`auction_id`),
  KEY `social_network_aucti_user_id_4c77bfc6_fk_social_ne` (`user_id`),
  CONSTRAINT `social_network_aucti_auction_id_33992e6a_fk_social_ne` FOREIGN KEY (`auction_id`) REFERENCES `social_network_auction` (`id`),
  CONSTRAINT `social_network_aucti_user_id_4c77bfc6_fk_social_ne` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_auctioncomment`;
INSERT INTO `social_network_auctioncomment` (`id`, `content`, `create_at`, `price`, `status_transaction`, `auction_id`, `user_id`) VALUES
(1,	'EM muốn mua vs giá 1500 nhưng chỉ trả trc 500 đô còn lại trả dần trong 1 năm',	'2021-08-05 11:45:32.532491',	1500,	'none',	1,	6),
(2,	'Toi chi duoc gia nay thoin nha',	'2021-09-03 13:33:38.588944',	1200,	'succ',	1,	7),
(3,	'Em đk cũng k tốt lắm nhưng  em sẽ cố hết sức vs dự án này.',	'2021-09-04 03:42:53.108882',	1800,	'none',	2,	7),
(4,	'Toi chi duoc gia nay thoin nha',	'2021-09-12 09:48:03.018738',	1200,	'none',	7,	7),
(5,	'Toi chi duoc gia nay thoin nha',	'2021-09-12 09:50:42.445727',	1200,	'none',	8,	7),
(6,	'Toi chi duoc gia nay thoin nha',	'2021-09-12 09:52:03.881207',	1200,	'none',	9,	7);

DROP TABLE IF EXISTS `social_network_auctionimage`;
CREATE TABLE `social_network_auctionimage` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `auction_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_network_aucti_auction_id_8dc02dc6_fk_social_ne` (`auction_id`),
  CONSTRAINT `social_network_aucti_auction_id_8dc02dc6_fk_social_ne` FOREIGN KEY (`auction_id`) REFERENCES `social_network_auction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(17,	'static/auction_images/2021/09/119170527_2035657669902648_1262318113764188233_o_0Apv4mx.png',	15),
(18,	'static/auction_images/2021/09/Screenshot_from_2021-08-30_15-21-58_rtu3GLN.png',	18),
(19,	'static/auction_images/2021/09/Screenshot_from_2021-08-30_15-21-58_0dLNRyT.png',	19);

DROP TABLE IF EXISTS `social_network_auctionreport`;
CREATE TABLE `social_network_auctionreport` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext COLLATE utf8_unicode_ci,
  `create_at` datetime(6) DEFAULT NULL,
  `auction_id` bigint NOT NULL,
  `type_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `social_network_aucti_auction_id_8b79ac7b_fk_social_ne` (`auction_id`),
  KEY `social_network_aucti_type_id_7f79c945_fk_social_ne` (`type_id`),
  KEY `social_network_aucti_user_id_1922cecd_fk_social_ne` (`user_id`),
  CONSTRAINT `social_network_aucti_auction_id_8b79ac7b_fk_social_ne` FOREIGN KEY (`auction_id`) REFERENCES `social_network_auction` (`id`),
  CONSTRAINT `social_network_aucti_type_id_7f79c945_fk_social_ne` FOREIGN KEY (`type_id`) REFERENCES `social_network_reporttype` (`id`),
  CONSTRAINT `social_network_aucti_user_id_1922cecd_fk_social_ne` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_auctionreport`;

DROP TABLE IF EXISTS `social_network_categoryauction`;
CREATE TABLE `social_network_categoryauction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_categoryauction`;
INSERT INTO `social_network_categoryauction` (`id`, `name`) VALUES
(1,	'Bất động sản'),
(2,	'Nhà cửa'),
(3,	'Vận dụng Nội thất'),
(4,	'Xe cộ'),
(5,	'Nghệ thuật'),
(6,	'Đồ cổ');

DROP TABLE IF EXISTS `social_network_hashtagpost`;
CREATE TABLE `social_network_hashtagpost` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_hashtagpost`;
INSERT INTO `social_network_hashtagpost` (`id`, `name`) VALUES
(1,	'first post'),
(11,	'alala'),
(12,	'picture'),
(13,	'lala'),
(14,	'123'),
(15,	'áđf'),
(16,	'effd'),
(17,	'nothinh'),
(18,	'chicohinhanh'),
(21,	'ahihilallaa'),
(22,	'huhu'),
(23,	'test'),
(24,	'hinhhaungoz'),
(25,	'good');

DROP TABLE IF EXISTS `social_network_post`;
CREATE TABLE `social_network_post` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext COLLATE utf8_unicode_ci,
  `create_at` datetime(6) DEFAULT NULL,
  `count_comment` int NOT NULL,
  `active` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_network_post_user_id_f9469041_fk_social_network_user_id` (`user_id`),
  CONSTRAINT `social_network_post_user_id_f9469041_fk_social_network_user_id` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_post`;
INSERT INTO `social_network_post` (`id`, `content`, `create_at`, `count_comment`, `active`, `user_id`) VALUES
(1,	'hello world',	'2021-08-05 09:11:27.824571',	11,	1,	5),
(2,	'nggo vawn',	'2021-08-08 01:49:43.296662',	0,	1,	5),
(18,	'Test upload 5 file lan 3',	'2021-08-31 04:00:17.742423',	1,	1,	7),
(23,	'Post ms đc chỉnh sửa',	'2021-09-07 01:41:27.008694',	0,	1,	7),
(24,	'ahihi',	'2021-09-09 07:43:16.097909',	0,	1,	7),
(29,	'ms thêm để thử vs redux',	'2021-09-09 13:42:16.705572',	0,	1,	7),
(30,	'chi có nd',	'2021-09-10 16:40:12.476817',	0,	1,	7),
(31,	NULL,	'2021-09-10 16:40:47.249156',	0,	1,	7),
(32,	'Ms tạo tài khoản nên tò mò đăng thử\ncũng khá là hay',	'2021-09-15 12:48:04.270167',	0,	1,	16);

DROP TABLE IF EXISTS `social_network_post_hashtag`;
CREATE TABLE `social_network_post_hashtag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` bigint NOT NULL,
  `hashtagpost_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_network_post_hashtag_post_id_hashtagpost_id_05fd050d_uniq` (`post_id`,`hashtagpost_id`),
  KEY `social_network_post__hashtagpost_id_f50a0780_fk_social_ne` (`hashtagpost_id`),
  CONSTRAINT `social_network_post__hashtagpost_id_f50a0780_fk_social_ne` FOREIGN KEY (`hashtagpost_id`) REFERENCES `social_network_hashtagpost` (`id`),
  CONSTRAINT `social_network_post__post_id_bffa1324_fk_social_ne` FOREIGN KEY (`post_id`) REFERENCES `social_network_post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_post_hashtag`;
INSERT INTO `social_network_post_hashtag` (`id`, `post_id`, `hashtagpost_id`) VALUES
(1,	1,	1),
(32,	18,	21),
(33,	18,	22),
(35,	23,	24),
(28,	29,	17),
(29,	31,	18),
(36,	32,	25);

DROP TABLE IF EXISTS `social_network_post_like`;
CREATE TABLE `social_network_post_like` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_network_post_like_post_id_user_id_5b8e345c_uniq` (`post_id`,`user_id`),
  KEY `social_network_post__user_id_cfdec8bd_fk_social_ne` (`user_id`),
  CONSTRAINT `social_network_post__post_id_08c29e98_fk_social_ne` FOREIGN KEY (`post_id`) REFERENCES `social_network_post` (`id`),
  CONSTRAINT `social_network_post__user_id_cfdec8bd_fk_social_ne` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_post_like`;
INSERT INTO `social_network_post_like` (`id`, `post_id`, `user_id`) VALUES
(35,	1,	7),
(36,	1,	16),
(24,	2,	7),
(37,	18,	16),
(27,	23,	7),
(26,	24,	7),
(31,	29,	7),
(29,	30,	7),
(30,	31,	7);

DROP TABLE IF EXISTS `social_network_postcomment`;
CREATE TABLE `social_network_postcomment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext COLLATE utf8_unicode_ci,
  `create_at` datetime(6) DEFAULT NULL,
  `post_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_network_postc_post_id_1d20aba3_fk_social_ne` (`post_id`),
  KEY `social_network_postc_user_id_08033e89_fk_social_ne` (`user_id`),
  CONSTRAINT `social_network_postc_post_id_1d20aba3_fk_social_ne` FOREIGN KEY (`post_id`) REFERENCES `social_network_post` (`id`),
  CONSTRAINT `social_network_postc_user_id_08033e89_fk_social_ne` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_postcomment`;
INSERT INTO `social_network_postcomment` (`id`, `content`, `create_at`, `post_id`, `user_id`) VALUES
(1,	'Ahihi =)))',	'2021-08-05 09:35:00.258944',	1,	5),
(2,	'ahihi',	'2021-09-02 01:18:05.048242',	1,	7),
(3,	'Ahihi comment so 1 cho kan nhe.',	'2021-09-03 10:15:38.673072',	1,	7),
(4,	'Ahihi comment so 1 cho kan nhe. lan 2',	'2021-09-03 10:16:34.375575',	1,	7),
(5,	'Ahihi comment so 1 cho kan nhe. lan 2',	'2021-09-03 10:25:52.256432',	1,	7),
(6,	'Ahihihi',	'2021-09-03 10:33:28.631969',	1,	7),
(7,	'This is a comment with image',	'2021-09-05 01:58:28.178986',	1,	7),
(8,	'ahihi',	'2021-09-11 03:02:09.495604',	1,	7),
(9,	'ma thêm comment bằng app nèk',	'2021-09-15 01:41:39.658203',	1,	7),
(10,	'ahlolo',	'2021-09-15 01:42:16.126544',	1,	7),
(11,	'ahihi test api hả',	'2021-09-15 13:04:00.744292',	18,	16),
(12,	'ahihi',	'2021-09-16 08:53:35.956101',	1,	7);

DROP TABLE IF EXISTS `social_network_postimage`;
CREATE TABLE `social_network_postimage` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `post_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_network_posti_post_id_d6826d11_fk_social_ne` (`post_id`),
  CONSTRAINT `social_network_posti_post_id_d6826d11_fk_social_ne` FOREIGN KEY (`post_id`) REFERENCES `social_network_post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_postimage`;
INSERT INTO `social_network_postimage` (`id`, `image`, `post_id`) VALUES
(1,	'static/post_images/2021/08/thumb-1920-161457.jpg',	1),
(2,	'static/post_images/2021/08/119170527_2035657669902648_1262318113764188233_o.png',	1),
(3,	'static/post_images/2021/08/images.jpeg',	2),
(4,	'static/post_images/2021/08/home-banner-2020-02-min.jpg',	2),
(12,	'static/post_images/2021/09/IMG_8628.jpg',	1),
(13,	'static/post_images/2021/08/e5d058e4258bacbde1bf75874bd459f8.jpg',	2),
(14,	'static/post_images/2021/08/spring-overview.png',	2),
(15,	'static/post_images/2021/09/IMG_8628.jpg',	2),
(16,	'static/post_images/2021/09/datanet.jpeg',	24),
(20,	'static/post_images/2021/09/20210408_105342_nb1BiIS.jpg',	29),
(21,	'static/post_images/2021/09/20201117_080000_3HyUaTu.jpg',	29),
(22,	'static/post_images/2021/09/localhost_3000__wAEEucJ.png',	29),
(23,	'static/post_images/2021/09/id_password.jpg',	31),
(25,	'static/post_images/2021/09/Screenshot_from_2021-08-30_15-21-58_FP27zhT.png',	18),
(27,	'static/post_images/2021/09/filename0.jpg',	23),
(28,	'static/post_images/2021/09/1521798484898702754.jpg',	32),
(29,	'static/post_images/2021/09/1519955912576480406.jpg',	32);

DROP TABLE IF EXISTS `social_network_postreport`;
CREATE TABLE `social_network_postreport` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext COLLATE utf8_unicode_ci,
  `create_at` datetime(6) DEFAULT NULL,
  `post_id` bigint DEFAULT NULL,
  `type_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `social_network_postr_post_id_85597e85_fk_social_ne` (`post_id`),
  KEY `social_network_postr_type_id_bcac82d3_fk_social_ne` (`type_id`),
  KEY `social_network_postr_user_id_0bb2c9e5_fk_social_ne` (`user_id`),
  CONSTRAINT `social_network_postr_post_id_85597e85_fk_social_ne` FOREIGN KEY (`post_id`) REFERENCES `social_network_post` (`id`),
  CONSTRAINT `social_network_postr_type_id_bcac82d3_fk_social_ne` FOREIGN KEY (`type_id`) REFERENCES `social_network_reporttype` (`id`),
  CONSTRAINT `social_network_postr_user_id_0bb2c9e5_fk_social_ne` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_postreport`;
INSERT INTO `social_network_postreport` (`id`, `content`, `create_at`, `post_id`, `type_id`, `user_id`) VALUES
(1,	'Thông tin không hữu ích',	'2021-09-05 03:03:50.735512',	NULL,	2,	6),
(2,	'Cais post nay spam qua nen t report thoi',	'2021-09-11 06:12:33.380537',	18,	2,	7);

DROP TABLE IF EXISTS `social_network_reporttype`;
CREATE TABLE `social_network_reporttype` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_reporttype`;
INSERT INTO `social_network_reporttype` (`id`, `name`) VALUES
(1,	'Thông tin sai sự thật'),
(2,	'Spam'),
(3,	'Bán hàng trái phép'),
(4,	'Ngôn từ không đúng chuẩn mực'),
(5,	'Vấn đề khác');

DROP TABLE IF EXISTS `social_network_user`;
CREATE TABLE `social_network_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `phone` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_user`;
INSERT INTO `social_network_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `phone`, `avatar`, `address`, `birthday`) VALUES
(1,	'pbkdf2_sha256$260000$qQh4sfjYrHmQxoLvJJfyf9$few37ayqiXuHlAA8daiQK8/J1K24Vzfk/jH+giH4Kok=',	'2021-09-07 14:19:06.782747',	1,	'admin',	'',	'',	'ngovanhau1999@gmail.com',	1,	1,	'2021-08-05 07:46:02.456611',	NULL,	'',	NULL,	NULL),
(5,	'haungo',	'2021-08-05 08:39:19.000000',	0,	'haungo',	'Hau',	'Ngo',	'ngovanhau1999@gmail.com',	0,	1,	'2021-08-05 08:38:36.000000',	'0383793662',	'/static/avatar/user_haungo/suc_khoa.jpg',	'thon 10 Bom Bo',	'2000-10-02'),
(6,	'dungly',	NULL,	0,	'dungly',	'Dung',	'Ly',	'1851050025dung@ou.edu.vn',	0,	1,	'2021-08-05 09:14:47.000000',	'0123456789',	'/static/avatar/user_dungly/ahihi.jpeg',	'TP HCM',	'2000-01-01'),
(7,	'pbkdf2_sha256$260000$Ti8f6dDOewMBC1l8DMlr1D$jJv7GIWnrw1Nwbp34DGrJEdp3+ElWgEr4gjhFOYnNPI=',	NULL,	0,	'haungo1',	'kanj',	'haungo',	'ngovanhau@gmail.com',	0,	1,	'2021-08-31 01:00:36.000000',	'0988039184',	'static/avatar/user_haungo1/20210408_105342_o6Ls5jm.jpg',	'thôn 10 Bom Bo, Bù Đăng, Bình Phước',	'2000-10-02'),
(10,	'pbkdf2_sha256$260000$KSQ0njy6Zb0q9XYGOQiXI5$tcRFXfDUsIUAN9PB+h7r58br7s5qCNtoVtaveQ2kTck=',	NULL,	0,	'itouvn',	'IT',	'OUIT',	'IT@ou.edu.vn',	0,	1,	'2021-09-05 09:00:27.115940',	NULL,	'',	NULL,	NULL),
(11,	'pbkdf2_sha256$260000$VjpkbhEsBLuXlRB2qmGxzT$nlASOOeyw2DK2Wo0Je7KMlFgKFje0rHWgznW5HPLrUs=',	NULL,	0,	'',	'Haungo',	'Van',	'ngovanhau2109@gmail.com',	0,	1,	'2021-09-11 06:27:02.388273',	NULL,	'',	NULL,	NULL),
(14,	'pbkdf2_sha256$260000$F3mJRe6gQPBDsbmjq98QrH$px3FrOuisGvh9DAxBqx09Egh3gJrmR9FKnicnal/EqE=',	NULL,	0,	'ahihi',	'Haungo',	'Van',	'ngovanhau2109@gmail.com',	0,	1,	'2021-09-15 08:13:21.388373',	NULL,	'',	NULL,	NULL),
(15,	'pbkdf2_sha256$260000$vBU3R4uCmix3TyQhaYElIG$PoMepNTakbgkQcKC4EakVBS1GhpdcfjUZtFURMWtDaU=',	NULL,	0,	'ahihio',	'Haungo',	'Van',	'ngovanhau2109@gmail.com',	0,	1,	'2021-09-15 08:14:12.030632',	NULL,	'',	NULL,	NULL),
(16,	'pbkdf2_sha256$260000$RTOzQspa0ZcOrNcNe1wqja$7Wx+VPATUcu01mswwyBVjzBoeIy7QaCI8Vt+GC2wxzA=',	NULL,	0,	'dungly1',	'Dung',	'Ly',	'dungly1@gmail.com',	0,	1,	'2021-09-15 09:07:14.662641',	'0174628476',	'static/avatar/user_dungly1/Screenshot_2021-09-01-20-19-40-86.png',	'Phú Nhuận',	'2020-10-25'),
(17,	'pbkdf2_sha256$260000$5BQasxicLrK1SMi3dL8HcO$B390Uz2bBhO+6mMNv0HncWVOT7deCPTUtG2lHhn/QUA=',	NULL,	0,	'itecit02',	'Dung',	'Ly',	'dungly1@gmail.com',	0,	1,	'2021-09-15 10:15:27.336377',	NULL,	'static/avatar/user_itecit02/20201117_080000.jpg',	NULL,	'2020-10-25');

DROP TABLE IF EXISTS `social_network_user_groups`;
CREATE TABLE `social_network_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_network_user_groups_user_id_group_id_34469280_uniq` (`user_id`,`group_id`),
  KEY `social_network_user_groups_group_id_aef9a7cb_fk_auth_group_id` (`group_id`),
  CONSTRAINT `social_network_user__user_id_d9ed9249_fk_social_ne` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`),
  CONSTRAINT `social_network_user_groups_group_id_aef9a7cb_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_user_groups`;

DROP TABLE IF EXISTS `social_network_user_user_permissions`;
CREATE TABLE `social_network_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_network_user_user_user_id_permission_id_597e8975_uniq` (`user_id`,`permission_id`),
  KEY `social_network_user__permission_id_7821e7d5_fk_auth_perm` (`permission_id`),
  CONSTRAINT `social_network_user__permission_id_7821e7d5_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `social_network_user__user_id_d707facd_fk_social_ne` FOREIGN KEY (`user_id`) REFERENCES `social_network_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE `social_network_user_user_permissions`;

-- 2021-09-16 09:00:24
