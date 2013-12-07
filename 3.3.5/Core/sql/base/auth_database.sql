/*
Navicat MySQL Data Transfer

Source Server         : Database01
Source Server Version : 50611
Source Host           : localhost:3306
Source Database       : auth

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2013-12-07 17:55:25
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `account`
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Identifier',
  `username` varchar(32) NOT NULL DEFAULT '',
  `sha_pass_hash` varchar(40) NOT NULL DEFAULT '',
  `sessionkey` varchar(80) NOT NULL DEFAULT '',
  `v` varchar(64) NOT NULL DEFAULT '',
  `s` varchar(64) NOT NULL DEFAULT '',
  `token_key` varchar(100) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `reg_mail` varchar(255) NOT NULL DEFAULT '',
  `joindate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_ip` varchar(15) NOT NULL DEFAULT '127.0.0.1',
  `failed_logins` int(10) unsigned NOT NULL DEFAULT '0',
  `locked` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `lock_country` varchar(2) NOT NULL DEFAULT '00',
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `online` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `expansion` tinyint(3) unsigned NOT NULL DEFAULT '2',
  `mutetime` bigint(20) NOT NULL DEFAULT '0',
  `mutereason` varchar(255) NOT NULL DEFAULT '',
  `muteby` varchar(50) NOT NULL DEFAULT '',
  `locale` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `os` varchar(3) NOT NULL DEFAULT '',
  `recruiter` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Account System';

-- ----------------------------
-- Records of account
-- ----------------------------

-- ----------------------------
-- Table structure for `account_access`
-- ----------------------------
DROP TABLE IF EXISTS `account_access`;
CREATE TABLE `account_access` (
  `id` int(10) unsigned NOT NULL,
  `gmlevel` tinyint(3) unsigned NOT NULL,
  `RealmID` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`,`RealmID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account_access
-- ----------------------------

-- ----------------------------
-- Table structure for `account_banned`
-- ----------------------------
DROP TABLE IF EXISTS `account_banned`;
CREATE TABLE `account_banned` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Account id',
  `bandate` int(10) unsigned NOT NULL DEFAULT '0',
  `unbandate` int(10) unsigned NOT NULL DEFAULT '0',
  `bannedby` varchar(50) NOT NULL,
  `banreason` varchar(255) NOT NULL,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`bandate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Ban List';

-- ----------------------------
-- Records of account_banned
-- ----------------------------

-- ----------------------------
-- Table structure for `autobroadcast`
-- ----------------------------
DROP TABLE IF EXISTS `autobroadcast`;
CREATE TABLE `autobroadcast` (
  `realmid` int(11) NOT NULL DEFAULT '-1',
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `weight` tinyint(3) unsigned DEFAULT '1',
  `text` longtext NOT NULL,
  PRIMARY KEY (`id`,`realmid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of autobroadcast
-- ----------------------------

-- ----------------------------
-- Table structure for `ip2nation`
-- ----------------------------
DROP TABLE IF EXISTS `ip2nation`;
CREATE TABLE `ip2nation` (
  `ip` int(11) unsigned NOT NULL DEFAULT '0',
  `country` char(2) NOT NULL DEFAULT '',
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ip2nation
-- ----------------------------

-- ----------------------------
-- Table structure for `ip2nationcountries`
-- ----------------------------
DROP TABLE IF EXISTS `ip2nationcountries`;
CREATE TABLE `ip2nationcountries` (
  `code` varchar(4) NOT NULL DEFAULT '',
  `iso_code_2` varchar(2) NOT NULL DEFAULT '',
  `iso_code_3` varchar(3) DEFAULT '',
  `iso_country` varchar(255) NOT NULL DEFAULT '',
  `country` varchar(255) NOT NULL DEFAULT '',
  `lat` float NOT NULL DEFAULT '0',
  `lon` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`code`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ip2nationcountries
-- ----------------------------

-- ----------------------------
-- Table structure for `ip_banned`
-- ----------------------------
DROP TABLE IF EXISTS `ip_banned`;
CREATE TABLE `ip_banned` (
  `ip` varchar(15) NOT NULL DEFAULT '127.0.0.1',
  `bandate` int(10) unsigned NOT NULL,
  `unbandate` int(10) unsigned NOT NULL,
  `bannedby` varchar(50) NOT NULL DEFAULT '[Console]',
  `banreason` varchar(255) NOT NULL DEFAULT 'no reason',
  PRIMARY KEY (`ip`,`bandate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Banned IPs';

-- ----------------------------
-- Records of ip_banned
-- ----------------------------

-- ----------------------------
-- Table structure for `logs`
-- ----------------------------
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `time` int(10) unsigned NOT NULL,
  `realm` int(10) unsigned NOT NULL,
  `type` varchar(250) DEFAULT NULL,
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `string` text CHARACTER SET latin1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of logs
-- ----------------------------

-- ----------------------------
-- Table structure for `rbac_account_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `rbac_account_permissions`;
CREATE TABLE `rbac_account_permissions` (
  `accountId` int(10) unsigned NOT NULL COMMENT 'Account id',
  `permissionId` int(10) unsigned NOT NULL COMMENT 'Permission id',
  `granted` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Granted = 1, Denied = 0',
  `realmId` int(11) NOT NULL DEFAULT '-1' COMMENT 'Realm Id, -1 means all',
  PRIMARY KEY (`accountId`,`permissionId`,`realmId`),
  KEY `fk__rbac_account_roles__rbac_permissions` (`permissionId`),
  CONSTRAINT `fk__rbac_account_permissions__account` FOREIGN KEY (`accountId`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__rbac_account_roles__rbac_permissions` FOREIGN KEY (`permissionId`) REFERENCES `rbac_permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Account-Permission relation';

-- ----------------------------
-- Records of rbac_account_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for `rbac_default_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `rbac_default_permissions`;
CREATE TABLE `rbac_default_permissions` (
  `secId` int(10) unsigned NOT NULL COMMENT 'Security Level id',
  `permissionId` int(10) unsigned NOT NULL COMMENT 'permission id',
  PRIMARY KEY (`secId`,`permissionId`),
  KEY `fk__rbac_default_permissions__rbac_permissions` (`permissionId`),
  CONSTRAINT `fk__rbac_default_permissions__rbac_permissions` FOREIGN KEY (`permissionId`) REFERENCES `rbac_permissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Default permission to assign to different account security levels';

-- ----------------------------
-- Records of rbac_default_permissions
-- ----------------------------
INSERT INTO rbac_default_permissions VALUES ('3', '192');
INSERT INTO rbac_default_permissions VALUES ('2', '193');
INSERT INTO rbac_default_permissions VALUES ('1', '194');
INSERT INTO rbac_default_permissions VALUES ('0', '195');

-- ----------------------------
-- Table structure for `rbac_linked_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `rbac_linked_permissions`;
CREATE TABLE `rbac_linked_permissions` (
  `id` int(10) unsigned NOT NULL COMMENT 'Permission id',
  `linkedId` int(10) unsigned NOT NULL COMMENT 'Linked Permission id',
  PRIMARY KEY (`id`,`linkedId`),
  KEY `fk__rbac_linked_permissions__rbac_permissions1` (`id`),
  KEY `fk__rbac_linked_permissions__rbac_permissions2` (`linkedId`),
  CONSTRAINT `fk__rbac_linked_permissions__rbac_permissions1` FOREIGN KEY (`id`) REFERENCES `rbac_permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__rbac_linked_permissions__rbac_permissions2` FOREIGN KEY (`linkedId`) REFERENCES `rbac_permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Permission - Linked Permission relation';

-- ----------------------------
-- Records of rbac_linked_permissions
-- ----------------------------
INSERT INTO rbac_linked_permissions VALUES ('192', '193');
INSERT INTO rbac_linked_permissions VALUES ('192', '196');
INSERT INTO rbac_linked_permissions VALUES ('193', '194');
INSERT INTO rbac_linked_permissions VALUES ('193', '197');
INSERT INTO rbac_linked_permissions VALUES ('194', '195');
INSERT INTO rbac_linked_permissions VALUES ('194', '198');
INSERT INTO rbac_linked_permissions VALUES ('195', '199');
INSERT INTO rbac_linked_permissions VALUES ('196', '400');

-- ----------------------------
-- Table structure for `rbac_permissions`
-- ----------------------------
DROP TABLE IF EXISTS `rbac_permissions`;
CREATE TABLE `rbac_permissions` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Permission id',
  `name` varchar(100) NOT NULL COMMENT 'Permission name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Permission List';

-- ----------------------------
-- Records of rbac_permissions
-- ----------------------------
INSERT INTO rbac_permissions VALUES ('1', 'Instant logout');
INSERT INTO rbac_permissions VALUES ('2', 'Skip Queue');
INSERT INTO rbac_permissions VALUES ('3', 'Join Normal Battleground');
INSERT INTO rbac_permissions VALUES ('4', 'Join Random Battleground');
INSERT INTO rbac_permissions VALUES ('5', 'Join Arenas');
INSERT INTO rbac_permissions VALUES ('6', 'Join Dungeon Finder');
INSERT INTO rbac_permissions VALUES ('11', 'Log GM trades');
INSERT INTO rbac_permissions VALUES ('13', 'Skip Instance required bosses check');
INSERT INTO rbac_permissions VALUES ('14', 'Skip character creation team mask check');
INSERT INTO rbac_permissions VALUES ('15', 'Skip character creation class mask check');
INSERT INTO rbac_permissions VALUES ('16', 'Skip character creation race mask check');
INSERT INTO rbac_permissions VALUES ('17', 'Skip character creation reserved name check');
INSERT INTO rbac_permissions VALUES ('18', 'Skip character creation heroic min level check');
INSERT INTO rbac_permissions VALUES ('19', 'Skip needed requirements to use channel check');
INSERT INTO rbac_permissions VALUES ('20', 'Skip disable map check');
INSERT INTO rbac_permissions VALUES ('21', 'Skip reset talents when used more than allowed check');
INSERT INTO rbac_permissions VALUES ('22', 'Skip spam chat check');
INSERT INTO rbac_permissions VALUES ('23', 'Skip over-speed ping check');
INSERT INTO rbac_permissions VALUES ('24', 'Two side faction characters on the same account');
INSERT INTO rbac_permissions VALUES ('25', 'Allow say chat between factions');
INSERT INTO rbac_permissions VALUES ('26', 'Allow channel chat between factions');
INSERT INTO rbac_permissions VALUES ('27', 'Two side mail interaction');
INSERT INTO rbac_permissions VALUES ('28', 'See two side who list');
INSERT INTO rbac_permissions VALUES ('29', 'Add friends of other faction');
INSERT INTO rbac_permissions VALUES ('30', 'Save character without delay with .save command');
INSERT INTO rbac_permissions VALUES ('31', 'Use params with .unstuck command');
INSERT INTO rbac_permissions VALUES ('32', 'Can be assigned tickets with .assign ticket command');
INSERT INTO rbac_permissions VALUES ('33', 'Notify if a command was not found');
INSERT INTO rbac_permissions VALUES ('34', 'Check if should appear in list using .gm ingame command');
INSERT INTO rbac_permissions VALUES ('35', 'See all security levels with who command');
INSERT INTO rbac_permissions VALUES ('36', 'Filter whispers');
INSERT INTO rbac_permissions VALUES ('37', 'Use staff badge in chat');
INSERT INTO rbac_permissions VALUES ('38', 'Resurrect with full Health Points');
INSERT INTO rbac_permissions VALUES ('39', 'Restore saved gm setting states');
INSERT INTO rbac_permissions VALUES ('40', 'Allows to add a gm to friend list');
INSERT INTO rbac_permissions VALUES ('41', 'Use Config option START_GM_LEVEL to assign new character level');
INSERT INTO rbac_permissions VALUES ('42', 'Allows to use CMSG_WORLD_TELEPORT opcode');
INSERT INTO rbac_permissions VALUES ('43', 'Allows to use CMSG_WHOIS opcode');
INSERT INTO rbac_permissions VALUES ('44', 'Receive global GM messages/texts');
INSERT INTO rbac_permissions VALUES ('45', 'Join channels without announce');
INSERT INTO rbac_permissions VALUES ('46', 'Change channel settings without being channel moderator');
INSERT INTO rbac_permissions VALUES ('47', 'Enables lower security than target check');
INSERT INTO rbac_permissions VALUES ('48', 'Enable IP, Last Login and EMail output in pinfo');
INSERT INTO rbac_permissions VALUES ('49', 'Forces to enter the email for confirmation on password change');
INSERT INTO rbac_permissions VALUES ('50', 'Allow user to check his own email with .account');
INSERT INTO rbac_permissions VALUES ('192', 'Role: Sec Level Administrator');
INSERT INTO rbac_permissions VALUES ('193', 'Role: Sec Level Gamemaster');
INSERT INTO rbac_permissions VALUES ('194', 'Role: Sec Level Moderator');
INSERT INTO rbac_permissions VALUES ('195', 'Role: Sec Level Player');
INSERT INTO rbac_permissions VALUES ('196', 'Role: Administrator Commands');
INSERT INTO rbac_permissions VALUES ('197', 'Role: Gamemaster Commands');
INSERT INTO rbac_permissions VALUES ('198', 'Role: Moderator Commands');
INSERT INTO rbac_permissions VALUES ('199', 'Role: Player Commands');
INSERT INTO rbac_permissions VALUES ('200', 'Command: .rbac');
INSERT INTO rbac_permissions VALUES ('201', 'Command: .rbac account');
INSERT INTO rbac_permissions VALUES ('202', 'Command: .rbac account permission');
INSERT INTO rbac_permissions VALUES ('203', 'Command: .rbac account permission grant');
INSERT INTO rbac_permissions VALUES ('204', 'Command: .rbac account permission deny');
INSERT INTO rbac_permissions VALUES ('205', 'Command: .rbac account permission revoke');
INSERT INTO rbac_permissions VALUES ('206', 'Command: .rbac list');
INSERT INTO rbac_permissions VALUES ('217', 'Command: .account');
INSERT INTO rbac_permissions VALUES ('218', 'Command: .account addon');
INSERT INTO rbac_permissions VALUES ('219', 'Command: .account create');
INSERT INTO rbac_permissions VALUES ('220', 'Command: .account delete');
INSERT INTO rbac_permissions VALUES ('221', 'Command: .account lock');
INSERT INTO rbac_permissions VALUES ('222', 'Command: .account lock country');
INSERT INTO rbac_permissions VALUES ('223', 'Command: .account lock ip');
INSERT INTO rbac_permissions VALUES ('224', 'Command: .account onlinelist');
INSERT INTO rbac_permissions VALUES ('225', 'Command: .account password');
INSERT INTO rbac_permissions VALUES ('226', 'Command: .account set');
INSERT INTO rbac_permissions VALUES ('227', 'Command: .account set addon');
INSERT INTO rbac_permissions VALUES ('228', 'Command: .account set gmlevel');
INSERT INTO rbac_permissions VALUES ('229', 'Command: .account set password');
INSERT INTO rbac_permissions VALUES ('230', 'Command: achievement');
INSERT INTO rbac_permissions VALUES ('231', 'Command: achievement add');
INSERT INTO rbac_permissions VALUES ('232', 'Command: arena');
INSERT INTO rbac_permissions VALUES ('233', 'Command: arena captain');
INSERT INTO rbac_permissions VALUES ('234', 'Command: arena create');
INSERT INTO rbac_permissions VALUES ('235', 'Command: arena disband');
INSERT INTO rbac_permissions VALUES ('236', 'Command: arena info');
INSERT INTO rbac_permissions VALUES ('237', 'Command: arena lookup');
INSERT INTO rbac_permissions VALUES ('238', 'Command: arena rename');
INSERT INTO rbac_permissions VALUES ('239', 'Command: ban');
INSERT INTO rbac_permissions VALUES ('240', 'Command: ban account');
INSERT INTO rbac_permissions VALUES ('241', 'Command: ban character');
INSERT INTO rbac_permissions VALUES ('242', 'Command: ban ip');
INSERT INTO rbac_permissions VALUES ('243', 'Command: ban playeraccount');
INSERT INTO rbac_permissions VALUES ('244', 'Command: baninfo');
INSERT INTO rbac_permissions VALUES ('245', 'Command: baninfo account');
INSERT INTO rbac_permissions VALUES ('246', 'Command: baninfo character');
INSERT INTO rbac_permissions VALUES ('247', 'Command: baninfo ip');
INSERT INTO rbac_permissions VALUES ('248', 'Command: banlist');
INSERT INTO rbac_permissions VALUES ('249', 'Command: banlist account');
INSERT INTO rbac_permissions VALUES ('250', 'Command: banlist character');
INSERT INTO rbac_permissions VALUES ('251', 'Command: banlist ip');
INSERT INTO rbac_permissions VALUES ('252', 'Command: unban');
INSERT INTO rbac_permissions VALUES ('253', 'Command: unban account');
INSERT INTO rbac_permissions VALUES ('254', 'Command: unban character');
INSERT INTO rbac_permissions VALUES ('255', 'Command: unban ip');
INSERT INTO rbac_permissions VALUES ('256', 'Command: unban playeraccount');
INSERT INTO rbac_permissions VALUES ('257', 'Command: bf');
INSERT INTO rbac_permissions VALUES ('258', 'Command: bf start');
INSERT INTO rbac_permissions VALUES ('259', 'Command: bf stop');
INSERT INTO rbac_permissions VALUES ('260', 'Command: bf switch');
INSERT INTO rbac_permissions VALUES ('261', 'Command: bf timer');
INSERT INTO rbac_permissions VALUES ('262', 'Command: bf enable');
INSERT INTO rbac_permissions VALUES ('263', 'Command: account email');
INSERT INTO rbac_permissions VALUES ('264', 'Command: account set sec');
INSERT INTO rbac_permissions VALUES ('265', 'Command: account set sec email');
INSERT INTO rbac_permissions VALUES ('266', 'Command: account set sec regmail');
INSERT INTO rbac_permissions VALUES ('267', 'Command: cast');
INSERT INTO rbac_permissions VALUES ('268', 'Command: cast back');
INSERT INTO rbac_permissions VALUES ('269', 'Command: cast dist');
INSERT INTO rbac_permissions VALUES ('270', 'Command: cast self');
INSERT INTO rbac_permissions VALUES ('271', 'Command: cast target');
INSERT INTO rbac_permissions VALUES ('272', 'Command: cast dest');
INSERT INTO rbac_permissions VALUES ('273', 'Command: character');
INSERT INTO rbac_permissions VALUES ('274', 'Command: character customize');
INSERT INTO rbac_permissions VALUES ('275', 'Command: character changefaction');
INSERT INTO rbac_permissions VALUES ('276', 'Command: character changerace');
INSERT INTO rbac_permissions VALUES ('277', 'Command: character deleted');
INSERT INTO rbac_permissions VALUES ('279', 'Command: character deleted list');
INSERT INTO rbac_permissions VALUES ('280', 'Command: character deleted restore');
INSERT INTO rbac_permissions VALUES ('283', 'Command: character level');
INSERT INTO rbac_permissions VALUES ('284', 'Command: character rename');
INSERT INTO rbac_permissions VALUES ('285', 'Command: character reputation');
INSERT INTO rbac_permissions VALUES ('286', 'Command: character titles');
INSERT INTO rbac_permissions VALUES ('287', 'Command: levelup');
INSERT INTO rbac_permissions VALUES ('288', 'Command: pdump');
INSERT INTO rbac_permissions VALUES ('289', 'Command: pdump load');
INSERT INTO rbac_permissions VALUES ('290', 'Command: pdump write');
INSERT INTO rbac_permissions VALUES ('291', 'Command: cheat');
INSERT INTO rbac_permissions VALUES ('292', 'Command: cheat casttime');
INSERT INTO rbac_permissions VALUES ('293', 'Command: cheat cooldown');
INSERT INTO rbac_permissions VALUES ('294', 'Command: cheat explore');
INSERT INTO rbac_permissions VALUES ('295', 'Command: cheat god');
INSERT INTO rbac_permissions VALUES ('296', 'Command: cheat power');
INSERT INTO rbac_permissions VALUES ('297', 'Command: cheat status');
INSERT INTO rbac_permissions VALUES ('298', 'Command: cheat taxi');
INSERT INTO rbac_permissions VALUES ('299', 'Command: cheat waterwalk');
INSERT INTO rbac_permissions VALUES ('300', 'Command: debug');
INSERT INTO rbac_permissions VALUES ('301', 'Command: debug anim');
INSERT INTO rbac_permissions VALUES ('302', 'Command: debug areatriggers');
INSERT INTO rbac_permissions VALUES ('303', 'Command: debug arena');
INSERT INTO rbac_permissions VALUES ('304', 'Command: debug bg');
INSERT INTO rbac_permissions VALUES ('305', 'Command: debug entervehicle');
INSERT INTO rbac_permissions VALUES ('306', 'Command: debug getitemstate');
INSERT INTO rbac_permissions VALUES ('307', 'Command: debug getitemvalue');
INSERT INTO rbac_permissions VALUES ('308', 'Command: debug getvalue');
INSERT INTO rbac_permissions VALUES ('309', 'Command: debug hostil');
INSERT INTO rbac_permissions VALUES ('310', 'Command: debug itemexpire');
INSERT INTO rbac_permissions VALUES ('311', 'Command: debug lootrecipient');
INSERT INTO rbac_permissions VALUES ('312', 'Command: debug los');
INSERT INTO rbac_permissions VALUES ('313', 'Command: debug mod32value');
INSERT INTO rbac_permissions VALUES ('314', 'Command: debug moveflags');
INSERT INTO rbac_permissions VALUES ('315', 'Command: debug play');
INSERT INTO rbac_permissions VALUES ('316', 'Command: debug play cinematics');
INSERT INTO rbac_permissions VALUES ('317', 'Command: debug play movie');
INSERT INTO rbac_permissions VALUES ('318', 'Command: debug play sound');
INSERT INTO rbac_permissions VALUES ('319', 'Command: debug send');
INSERT INTO rbac_permissions VALUES ('320', 'Command: debug send buyerror');
INSERT INTO rbac_permissions VALUES ('321', 'Command: debug send channelnotify');
INSERT INTO rbac_permissions VALUES ('322', 'Command: debug send chatmessage');
INSERT INTO rbac_permissions VALUES ('323', 'Command: debug send equiperror');
INSERT INTO rbac_permissions VALUES ('324', 'Command: debug send largepacket');
INSERT INTO rbac_permissions VALUES ('325', 'Command: debug send opcode');
INSERT INTO rbac_permissions VALUES ('326', 'Command: debug send qinvalidmsg');
INSERT INTO rbac_permissions VALUES ('327', 'Command: debug send qpartymsg');
INSERT INTO rbac_permissions VALUES ('328', 'Command: debug send sellerror');
INSERT INTO rbac_permissions VALUES ('329', 'Command: debug send setphaseshift');
INSERT INTO rbac_permissions VALUES ('330', 'Command: debug send spellfail');
INSERT INTO rbac_permissions VALUES ('331', 'Command: debug setaurastate');
INSERT INTO rbac_permissions VALUES ('332', 'Command: debug setbit');
INSERT INTO rbac_permissions VALUES ('333', 'Command: debug setitemvalue');
INSERT INTO rbac_permissions VALUES ('334', 'Command: debug setvalue');
INSERT INTO rbac_permissions VALUES ('335', 'Command: debug setvid');
INSERT INTO rbac_permissions VALUES ('336', 'Command: debug spawnvehicle');
INSERT INTO rbac_permissions VALUES ('337', 'Command: debug threat');
INSERT INTO rbac_permissions VALUES ('338', 'Command: debug update');
INSERT INTO rbac_permissions VALUES ('339', 'Command: debug uws');
INSERT INTO rbac_permissions VALUES ('340', 'Command: wpgps');
INSERT INTO rbac_permissions VALUES ('341', 'Command: deserter');
INSERT INTO rbac_permissions VALUES ('342', 'Command: deserter bg');
INSERT INTO rbac_permissions VALUES ('343', 'Command: deserter bg add');
INSERT INTO rbac_permissions VALUES ('344', 'Command: deserter bg remove');
INSERT INTO rbac_permissions VALUES ('345', 'Command: deserter instance');
INSERT INTO rbac_permissions VALUES ('346', 'Command: deserter instance add');
INSERT INTO rbac_permissions VALUES ('347', 'Command: deserter instance remove');
INSERT INTO rbac_permissions VALUES ('348', 'Command: disable');
INSERT INTO rbac_permissions VALUES ('349', 'Command: disable add');
INSERT INTO rbac_permissions VALUES ('350', 'Command: disable add achievement_criteria');
INSERT INTO rbac_permissions VALUES ('351', 'Command: disable add battleground');
INSERT INTO rbac_permissions VALUES ('352', 'Command: disable add map');
INSERT INTO rbac_permissions VALUES ('353', 'Command: disable add mmap');
INSERT INTO rbac_permissions VALUES ('354', 'Command: disable add outdoorpvp');
INSERT INTO rbac_permissions VALUES ('355', 'Command: disable add quest');
INSERT INTO rbac_permissions VALUES ('356', 'Command: disable add spell');
INSERT INTO rbac_permissions VALUES ('357', 'Command: disable add vmap');
INSERT INTO rbac_permissions VALUES ('358', 'Command: disable remove');
INSERT INTO rbac_permissions VALUES ('359', 'Command: disable remove achievement_criteria');
INSERT INTO rbac_permissions VALUES ('360', 'Command: disable remove battleground');
INSERT INTO rbac_permissions VALUES ('361', 'Command: disable remove map');
INSERT INTO rbac_permissions VALUES ('362', 'Command: disable remove mmap');
INSERT INTO rbac_permissions VALUES ('363', 'Command: disable remove outdoorpvp');
INSERT INTO rbac_permissions VALUES ('364', 'Command: disable remove quest');
INSERT INTO rbac_permissions VALUES ('365', 'Command: disable remove spell');
INSERT INTO rbac_permissions VALUES ('366', 'Command: disable remove vmap');
INSERT INTO rbac_permissions VALUES ('367', 'Command: event');
INSERT INTO rbac_permissions VALUES ('368', 'Command: event activelist');
INSERT INTO rbac_permissions VALUES ('369', 'Command: event start');
INSERT INTO rbac_permissions VALUES ('370', 'Command: event stop');
INSERT INTO rbac_permissions VALUES ('371', 'Command: gm');
INSERT INTO rbac_permissions VALUES ('372', 'Command: gm chat');
INSERT INTO rbac_permissions VALUES ('373', 'Command: gm fly');
INSERT INTO rbac_permissions VALUES ('374', 'Command: gm ingame');
INSERT INTO rbac_permissions VALUES ('375', 'Command: gm list');
INSERT INTO rbac_permissions VALUES ('376', 'Command: gm visible');
INSERT INTO rbac_permissions VALUES ('377', 'Command: go');
INSERT INTO rbac_permissions VALUES ('378', 'Command: go creature');
INSERT INTO rbac_permissions VALUES ('379', 'Command: go graveyard');
INSERT INTO rbac_permissions VALUES ('380', 'Command: go grid');
INSERT INTO rbac_permissions VALUES ('381', 'Command: go object');
INSERT INTO rbac_permissions VALUES ('382', 'Command: go taxinode');
INSERT INTO rbac_permissions VALUES ('383', 'Command: go ticket');
INSERT INTO rbac_permissions VALUES ('384', 'Command: go trigger');
INSERT INTO rbac_permissions VALUES ('385', 'Command: go xyz');
INSERT INTO rbac_permissions VALUES ('386', 'Command: go zonexy');
INSERT INTO rbac_permissions VALUES ('387', 'Command: gobject');
INSERT INTO rbac_permissions VALUES ('388', 'Command: gobject activate');
INSERT INTO rbac_permissions VALUES ('389', 'Command: gobject add');
INSERT INTO rbac_permissions VALUES ('390', 'Command: gobject add temp');
INSERT INTO rbac_permissions VALUES ('391', 'Command: gobject delete');
INSERT INTO rbac_permissions VALUES ('392', 'Command: gobject info');
INSERT INTO rbac_permissions VALUES ('393', 'Command: gobject move');
INSERT INTO rbac_permissions VALUES ('394', 'Command: gobject near');
INSERT INTO rbac_permissions VALUES ('395', 'Command: gobject set');
INSERT INTO rbac_permissions VALUES ('396', 'Command: gobject set phase');
INSERT INTO rbac_permissions VALUES ('397', 'Command: gobject set state');
INSERT INTO rbac_permissions VALUES ('398', 'Command: gobject target');
INSERT INTO rbac_permissions VALUES ('399', 'Command: gobject turn');
INSERT INTO rbac_permissions VALUES ('400', 'debug transport');
INSERT INTO rbac_permissions VALUES ('401', 'Command: guild');
INSERT INTO rbac_permissions VALUES ('402', 'Command: guild create');
INSERT INTO rbac_permissions VALUES ('403', 'Command: guild delete');
INSERT INTO rbac_permissions VALUES ('404', 'Command: guild invite');
INSERT INTO rbac_permissions VALUES ('405', 'Command: guild uninvite');
INSERT INTO rbac_permissions VALUES ('406', 'Command: guild rank');
INSERT INTO rbac_permissions VALUES ('407', 'Command: guild rename');
INSERT INTO rbac_permissions VALUES ('408', 'Command: honor');
INSERT INTO rbac_permissions VALUES ('409', 'Command: honor add');
INSERT INTO rbac_permissions VALUES ('410', 'Command: honor add kill');
INSERT INTO rbac_permissions VALUES ('411', 'Command: honor update');
INSERT INTO rbac_permissions VALUES ('412', 'Command: instance');
INSERT INTO rbac_permissions VALUES ('413', 'Command: instance listbinds');
INSERT INTO rbac_permissions VALUES ('414', 'Command: instance unbind');
INSERT INTO rbac_permissions VALUES ('415', 'Command: instance stats');
INSERT INTO rbac_permissions VALUES ('416', 'Command: instance savedata');
INSERT INTO rbac_permissions VALUES ('417', 'Command: learn');
INSERT INTO rbac_permissions VALUES ('418', 'Command: learn all');
INSERT INTO rbac_permissions VALUES ('419', 'Command: learn all my');
INSERT INTO rbac_permissions VALUES ('420', 'Command: learn all my class');
INSERT INTO rbac_permissions VALUES ('421', 'Command: learn all my pettalents');
INSERT INTO rbac_permissions VALUES ('422', 'Command: learn all my spells');
INSERT INTO rbac_permissions VALUES ('423', 'Command: learn all my talents');
INSERT INTO rbac_permissions VALUES ('424', 'Command: learn all gm');
INSERT INTO rbac_permissions VALUES ('425', 'Command: learn all crafts');
INSERT INTO rbac_permissions VALUES ('426', 'Command: learn all default');
INSERT INTO rbac_permissions VALUES ('427', 'Command: learn all lang');
INSERT INTO rbac_permissions VALUES ('428', 'Command: learn all recipes');
INSERT INTO rbac_permissions VALUES ('429', 'Command: unlearn');
INSERT INTO rbac_permissions VALUES ('430', 'Command: lfg');
INSERT INTO rbac_permissions VALUES ('431', 'Command: lfg player');
INSERT INTO rbac_permissions VALUES ('432', 'Command: lfg group');
INSERT INTO rbac_permissions VALUES ('433', 'Command: lfg queue');
INSERT INTO rbac_permissions VALUES ('434', 'Command: lfg clean');
INSERT INTO rbac_permissions VALUES ('435', 'Command: lfg options');
INSERT INTO rbac_permissions VALUES ('436', 'Command: list');
INSERT INTO rbac_permissions VALUES ('437', 'Command: list creature');
INSERT INTO rbac_permissions VALUES ('438', 'Command: list item');
INSERT INTO rbac_permissions VALUES ('439', 'Command: list object');
INSERT INTO rbac_permissions VALUES ('440', 'Command: list auras');
INSERT INTO rbac_permissions VALUES ('441', 'Command: list mail');
INSERT INTO rbac_permissions VALUES ('442', 'Command: lookup');
INSERT INTO rbac_permissions VALUES ('443', 'Command: lookup area');
INSERT INTO rbac_permissions VALUES ('444', 'Command: lookup creature');
INSERT INTO rbac_permissions VALUES ('445', 'Command: lookup event');
INSERT INTO rbac_permissions VALUES ('446', 'Command: lookup faction');
INSERT INTO rbac_permissions VALUES ('447', 'Command: lookup item');
INSERT INTO rbac_permissions VALUES ('448', 'Command: lookup itemset');
INSERT INTO rbac_permissions VALUES ('449', 'Command: lookup object');
INSERT INTO rbac_permissions VALUES ('450', 'Command: lookup quest');
INSERT INTO rbac_permissions VALUES ('451', 'Command: lookup player');
INSERT INTO rbac_permissions VALUES ('452', 'Command: lookup player ip');
INSERT INTO rbac_permissions VALUES ('453', 'Command: lookup player account');
INSERT INTO rbac_permissions VALUES ('454', 'Command: lookup player email');
INSERT INTO rbac_permissions VALUES ('455', 'Command: lookup skill');
INSERT INTO rbac_permissions VALUES ('456', 'Command: lookup spell');
INSERT INTO rbac_permissions VALUES ('457', 'Command: lookup spell id');
INSERT INTO rbac_permissions VALUES ('458', 'Command: lookup taxinode');
INSERT INTO rbac_permissions VALUES ('459', 'Command: lookup tele');
INSERT INTO rbac_permissions VALUES ('460', 'Command: lookup title');
INSERT INTO rbac_permissions VALUES ('461', 'Command: lookup map');
INSERT INTO rbac_permissions VALUES ('462', 'Command: announce');
INSERT INTO rbac_permissions VALUES ('463', 'Command: channel');
INSERT INTO rbac_permissions VALUES ('464', 'Command: channel set');
INSERT INTO rbac_permissions VALUES ('465', 'Command: channel set ownership');
INSERT INTO rbac_permissions VALUES ('466', 'Command: gmannounce');
INSERT INTO rbac_permissions VALUES ('467', 'Command: gmnameannounce');
INSERT INTO rbac_permissions VALUES ('468', 'Command: gmnotify');
INSERT INTO rbac_permissions VALUES ('469', 'Command: nameannounce');
INSERT INTO rbac_permissions VALUES ('470', 'Command: notify');
INSERT INTO rbac_permissions VALUES ('471', 'Command: whispers');
INSERT INTO rbac_permissions VALUES ('472', 'Command: group');
INSERT INTO rbac_permissions VALUES ('473', 'Command: group leader');
INSERT INTO rbac_permissions VALUES ('474', 'Command: group disband');
INSERT INTO rbac_permissions VALUES ('475', 'Command: group remove');
INSERT INTO rbac_permissions VALUES ('476', 'Command: group join');
INSERT INTO rbac_permissions VALUES ('477', 'Command: group list');
INSERT INTO rbac_permissions VALUES ('478', 'Command: group summon');
INSERT INTO rbac_permissions VALUES ('479', 'Command: pet');
INSERT INTO rbac_permissions VALUES ('480', 'Command: pet create');
INSERT INTO rbac_permissions VALUES ('481', 'Command: pet learn');
INSERT INTO rbac_permissions VALUES ('482', 'Command: pet unlearn');
INSERT INTO rbac_permissions VALUES ('483', 'Command: send');
INSERT INTO rbac_permissions VALUES ('484', 'Command: send items');
INSERT INTO rbac_permissions VALUES ('485', 'Command: send mail');
INSERT INTO rbac_permissions VALUES ('486', 'Command: send message');
INSERT INTO rbac_permissions VALUES ('487', 'Command: send money');
INSERT INTO rbac_permissions VALUES ('488', 'Command: additem');
INSERT INTO rbac_permissions VALUES ('489', 'Command: additemset');
INSERT INTO rbac_permissions VALUES ('490', 'Command: appear');
INSERT INTO rbac_permissions VALUES ('491', 'Command: aura');
INSERT INTO rbac_permissions VALUES ('492', 'Command: bank');
INSERT INTO rbac_permissions VALUES ('493', 'Command: bindsight');
INSERT INTO rbac_permissions VALUES ('494', 'Command: combatstop');
INSERT INTO rbac_permissions VALUES ('495', 'Command: cometome');
INSERT INTO rbac_permissions VALUES ('496', 'Command: commands');
INSERT INTO rbac_permissions VALUES ('497', 'Command: cooldown');
INSERT INTO rbac_permissions VALUES ('498', 'Command: damage');
INSERT INTO rbac_permissions VALUES ('499', 'Command: dev');
INSERT INTO rbac_permissions VALUES ('500', 'Command: die');
INSERT INTO rbac_permissions VALUES ('501', 'Command: dismount');
INSERT INTO rbac_permissions VALUES ('502', 'Command: distance');
INSERT INTO rbac_permissions VALUES ('503', 'Command: flusharenapoints');
INSERT INTO rbac_permissions VALUES ('504', 'Command: freeze');
INSERT INTO rbac_permissions VALUES ('505', 'Command: gps');
INSERT INTO rbac_permissions VALUES ('506', 'Command: guid');
INSERT INTO rbac_permissions VALUES ('507', 'Command: help');
INSERT INTO rbac_permissions VALUES ('508', 'Command: hidearea');
INSERT INTO rbac_permissions VALUES ('509', 'Command: itemmove');
INSERT INTO rbac_permissions VALUES ('510', 'Command: kick');
INSERT INTO rbac_permissions VALUES ('511', 'Command: linkgrave');
INSERT INTO rbac_permissions VALUES ('512', 'Command: listfreeze');
INSERT INTO rbac_permissions VALUES ('513', 'Command: maxskill');
INSERT INTO rbac_permissions VALUES ('514', 'Command: movegens');
INSERT INTO rbac_permissions VALUES ('515', 'Command: mute');
INSERT INTO rbac_permissions VALUES ('516', 'Command: neargrave');
INSERT INTO rbac_permissions VALUES ('517', 'Command: pinfo');
INSERT INTO rbac_permissions VALUES ('518', 'Command: playall');
INSERT INTO rbac_permissions VALUES ('519', 'Command: possess');
INSERT INTO rbac_permissions VALUES ('520', 'Command: recall');
INSERT INTO rbac_permissions VALUES ('521', 'Command: repairitems');
INSERT INTO rbac_permissions VALUES ('522', 'Command: respawn');
INSERT INTO rbac_permissions VALUES ('523', 'Command: revive');
INSERT INTO rbac_permissions VALUES ('524', 'Command: saveall');
INSERT INTO rbac_permissions VALUES ('525', 'Command: save');
INSERT INTO rbac_permissions VALUES ('526', 'Command: setskill');
INSERT INTO rbac_permissions VALUES ('527', 'Command: showarea');
INSERT INTO rbac_permissions VALUES ('528', 'Command: summon');
INSERT INTO rbac_permissions VALUES ('529', 'Command: unaura');
INSERT INTO rbac_permissions VALUES ('530', 'Command: unbindsight');
INSERT INTO rbac_permissions VALUES ('531', 'Command: unfreeze');
INSERT INTO rbac_permissions VALUES ('532', 'Command: unmute');
INSERT INTO rbac_permissions VALUES ('533', 'Command: unpossess');
INSERT INTO rbac_permissions VALUES ('534', 'Command: unstuck');
INSERT INTO rbac_permissions VALUES ('535', 'Command: wchange');
INSERT INTO rbac_permissions VALUES ('536', 'Command: mmap');
INSERT INTO rbac_permissions VALUES ('537', 'Command: mmap loadedtiles');
INSERT INTO rbac_permissions VALUES ('538', 'Command: mmap loc');
INSERT INTO rbac_permissions VALUES ('539', 'Command: mmap path');
INSERT INTO rbac_permissions VALUES ('540', 'Command: mmap stats');
INSERT INTO rbac_permissions VALUES ('541', 'Command: mmap testarea');
INSERT INTO rbac_permissions VALUES ('542', 'Command: morph');
INSERT INTO rbac_permissions VALUES ('543', 'Command: demorph');
INSERT INTO rbac_permissions VALUES ('544', 'Command: modify');
INSERT INTO rbac_permissions VALUES ('545', 'Command: modify arenapoints');
INSERT INTO rbac_permissions VALUES ('546', 'Command: modify bit');
INSERT INTO rbac_permissions VALUES ('547', 'Command: modify drunk');
INSERT INTO rbac_permissions VALUES ('548', 'Command: modify energy');
INSERT INTO rbac_permissions VALUES ('549', 'Command: modify faction');
INSERT INTO rbac_permissions VALUES ('550', 'Command: modify gender');
INSERT INTO rbac_permissions VALUES ('551', 'Command: modify honor');
INSERT INTO rbac_permissions VALUES ('552', 'Command: modify hp');
INSERT INTO rbac_permissions VALUES ('553', 'Command: modify mana');
INSERT INTO rbac_permissions VALUES ('554', 'Command: modify money');
INSERT INTO rbac_permissions VALUES ('555', 'Command: modify mount');
INSERT INTO rbac_permissions VALUES ('556', 'Command: modify phase');
INSERT INTO rbac_permissions VALUES ('557', 'Command: modify rage');
INSERT INTO rbac_permissions VALUES ('558', 'Command: modify reputation');
INSERT INTO rbac_permissions VALUES ('559', 'Command: modify runicpower');
INSERT INTO rbac_permissions VALUES ('560', 'Command: modify scale');
INSERT INTO rbac_permissions VALUES ('561', 'Command: modify speed');
INSERT INTO rbac_permissions VALUES ('562', 'Command: modify speed all');
INSERT INTO rbac_permissions VALUES ('563', 'Command: modify speed backwalk');
INSERT INTO rbac_permissions VALUES ('564', 'Command: modify speed fly');
INSERT INTO rbac_permissions VALUES ('565', 'Command: modify speed walk');
INSERT INTO rbac_permissions VALUES ('566', 'Command: modify speed swim');
INSERT INTO rbac_permissions VALUES ('567', 'Command: modify spell');
INSERT INTO rbac_permissions VALUES ('568', 'Command: modify standstate');
INSERT INTO rbac_permissions VALUES ('569', 'Command: modify talentpoints');
INSERT INTO rbac_permissions VALUES ('570', 'Command: npc');
INSERT INTO rbac_permissions VALUES ('571', 'Command: npc add');
INSERT INTO rbac_permissions VALUES ('572', 'Command: npc add formation');
INSERT INTO rbac_permissions VALUES ('573', 'Command: npc add item');
INSERT INTO rbac_permissions VALUES ('574', 'Command: npc add move');
INSERT INTO rbac_permissions VALUES ('575', 'Command: npc add temp');
INSERT INTO rbac_permissions VALUES ('576', 'Command: npc add delete');
INSERT INTO rbac_permissions VALUES ('577', 'Command: npc add delete item');
INSERT INTO rbac_permissions VALUES ('578', 'Command: npc add follow');
INSERT INTO rbac_permissions VALUES ('579', 'Command: npc add follow stop');
INSERT INTO rbac_permissions VALUES ('580', 'Command: npc set');
INSERT INTO rbac_permissions VALUES ('581', 'Command: npc set allowmove');
INSERT INTO rbac_permissions VALUES ('582', 'Command: npc set entry');
INSERT INTO rbac_permissions VALUES ('583', 'Command: npc set factionid');
INSERT INTO rbac_permissions VALUES ('584', 'Command: npc set flag');
INSERT INTO rbac_permissions VALUES ('585', 'Command: npc set level');
INSERT INTO rbac_permissions VALUES ('586', 'Command: npc set link');
INSERT INTO rbac_permissions VALUES ('587', 'Command: npc set model');
INSERT INTO rbac_permissions VALUES ('588', 'Command: npc set movetype');
INSERT INTO rbac_permissions VALUES ('589', 'Command: npc set phase');
INSERT INTO rbac_permissions VALUES ('590', 'Command: npc set spawndist');
INSERT INTO rbac_permissions VALUES ('591', 'Command: npc set spawntime');
INSERT INTO rbac_permissions VALUES ('592', 'Command: npc set data');
INSERT INTO rbac_permissions VALUES ('593', 'Command: npc info');
INSERT INTO rbac_permissions VALUES ('594', 'Command: npc near');
INSERT INTO rbac_permissions VALUES ('595', 'Command: npc move');
INSERT INTO rbac_permissions VALUES ('596', 'Command: npc playemote');
INSERT INTO rbac_permissions VALUES ('597', 'Command: npc say');
INSERT INTO rbac_permissions VALUES ('598', 'Command: npc textemote');
INSERT INTO rbac_permissions VALUES ('599', 'Command: npc whisper');
INSERT INTO rbac_permissions VALUES ('600', 'Command: npc yell');
INSERT INTO rbac_permissions VALUES ('601', 'Command: npc tame');
INSERT INTO rbac_permissions VALUES ('602', 'Command: quest');
INSERT INTO rbac_permissions VALUES ('603', 'Command: quest add');
INSERT INTO rbac_permissions VALUES ('604', 'Command: quest complete');
INSERT INTO rbac_permissions VALUES ('605', 'Command: quest remove');
INSERT INTO rbac_permissions VALUES ('606', 'Command: quest reward');
INSERT INTO rbac_permissions VALUES ('607', 'Command: reload');
INSERT INTO rbac_permissions VALUES ('608', 'Command: reload access_requirement');
INSERT INTO rbac_permissions VALUES ('609', 'Command: reload achievement_criteria_data');
INSERT INTO rbac_permissions VALUES ('610', 'Command: reload achievement_reward');
INSERT INTO rbac_permissions VALUES ('611', 'Command: reload all');
INSERT INTO rbac_permissions VALUES ('612', 'Command: reload all achievement');
INSERT INTO rbac_permissions VALUES ('613', 'Command: reload all area');
INSERT INTO rbac_permissions VALUES ('615', 'Command: reload all gossips');
INSERT INTO rbac_permissions VALUES ('616', 'Command: reload all item');
INSERT INTO rbac_permissions VALUES ('617', 'Command: reload all locales');
INSERT INTO rbac_permissions VALUES ('618', 'Command: reload all loot');
INSERT INTO rbac_permissions VALUES ('619', 'Command: reload all npc');
INSERT INTO rbac_permissions VALUES ('620', 'Command: reload all quest');
INSERT INTO rbac_permissions VALUES ('621', 'Command: reload all scripts');
INSERT INTO rbac_permissions VALUES ('622', 'Command: reload all spell');
INSERT INTO rbac_permissions VALUES ('623', 'Command: reload areatrigger_involvedrelation');
INSERT INTO rbac_permissions VALUES ('624', 'Command: reload areatrigger_tavern');
INSERT INTO rbac_permissions VALUES ('625', 'Command: reload areatrigger_teleport');
INSERT INTO rbac_permissions VALUES ('626', 'Command: reload auctions');
INSERT INTO rbac_permissions VALUES ('627', 'Command: reload autobroadcast');
INSERT INTO rbac_permissions VALUES ('628', 'Command: reload command');
INSERT INTO rbac_permissions VALUES ('629', 'Command: reload conditions');
INSERT INTO rbac_permissions VALUES ('630', 'Command: reload config');
INSERT INTO rbac_permissions VALUES ('633', 'Command: reload creature_ai_texts');
INSERT INTO rbac_permissions VALUES ('634', 'Command: reload creature_questender');
INSERT INTO rbac_permissions VALUES ('635', 'Command: reload creature_linked_respawn');
INSERT INTO rbac_permissions VALUES ('636', 'Command: reload creature_loot_template');
INSERT INTO rbac_permissions VALUES ('637', 'Command: reload creature_onkill_reputation');
INSERT INTO rbac_permissions VALUES ('638', 'Command: reload creature_queststarter');
INSERT INTO rbac_permissions VALUES ('639', 'Command: reload creature_summon_groups');
INSERT INTO rbac_permissions VALUES ('640', 'Command: reload creature_template');
INSERT INTO rbac_permissions VALUES ('641', 'Command: reload disables');
INSERT INTO rbac_permissions VALUES ('642', 'Command: reload disenchant_loot_template');
INSERT INTO rbac_permissions VALUES ('643', 'Command: reload event_scripts');
INSERT INTO rbac_permissions VALUES ('644', 'Command: reload fishing_loot_template');
INSERT INTO rbac_permissions VALUES ('645', 'Command: reload game_graveyard_zone');
INSERT INTO rbac_permissions VALUES ('646', 'Command: reload game_tele');
INSERT INTO rbac_permissions VALUES ('647', 'Command: reload gameobject_questender');
INSERT INTO rbac_permissions VALUES ('648', 'Command: reload gameobject_loot_template');
INSERT INTO rbac_permissions VALUES ('649', 'Command: reload gameobject_queststarter');
INSERT INTO rbac_permissions VALUES ('650', 'Command: reload gm_tickets');
INSERT INTO rbac_permissions VALUES ('651', 'Command: reload gossip_menu');
INSERT INTO rbac_permissions VALUES ('652', 'Command: reload gossip_menu_option');
INSERT INTO rbac_permissions VALUES ('653', 'Command: reload item_enchantment_template');
INSERT INTO rbac_permissions VALUES ('654', 'Command: reload item_loot_template');
INSERT INTO rbac_permissions VALUES ('655', 'Command: reload item_set_names');
INSERT INTO rbac_permissions VALUES ('656', 'Command: reload lfg_dungeon_rewards');
INSERT INTO rbac_permissions VALUES ('657', 'Command: reload locales_achievement_reward');
INSERT INTO rbac_permissions VALUES ('658', 'Command: reload locales_creature');
INSERT INTO rbac_permissions VALUES ('659', 'Command: reload locales_creature_text');
INSERT INTO rbac_permissions VALUES ('660', 'Command: reload locales_gameobject');
INSERT INTO rbac_permissions VALUES ('661', 'Command: reload locales_gossip_menu_option');
INSERT INTO rbac_permissions VALUES ('662', 'Command: reload locales_item');
INSERT INTO rbac_permissions VALUES ('663', 'Command: reload locales_item_set_name');
INSERT INTO rbac_permissions VALUES ('664', 'Command: reload locales_npc_text');
INSERT INTO rbac_permissions VALUES ('665', 'Command: reload locales_page_text');
INSERT INTO rbac_permissions VALUES ('666', 'Command: reload locales_points_of_interest');
INSERT INTO rbac_permissions VALUES ('667', 'Command: reload locales_quest');
INSERT INTO rbac_permissions VALUES ('668', 'Command: reload mail_level_reward');
INSERT INTO rbac_permissions VALUES ('669', 'Command: reload mail_loot_template');
INSERT INTO rbac_permissions VALUES ('670', 'Command: reload milling_loot_template');
INSERT INTO rbac_permissions VALUES ('671', 'Command: reload npc_spellclick_spells');
INSERT INTO rbac_permissions VALUES ('672', 'Command: reload npc_trainer');
INSERT INTO rbac_permissions VALUES ('673', 'Command: reload npc_vendor');
INSERT INTO rbac_permissions VALUES ('674', 'Command: reload page_text');
INSERT INTO rbac_permissions VALUES ('675', 'Command: reload pickpocketing_loot_template');
INSERT INTO rbac_permissions VALUES ('676', 'Command: reload points_of_interest');
INSERT INTO rbac_permissions VALUES ('677', 'Command: reload prospecting_loot_template');
INSERT INTO rbac_permissions VALUES ('678', 'Command: reload quest_poi');
INSERT INTO rbac_permissions VALUES ('679', 'Command: reload quest_template');
INSERT INTO rbac_permissions VALUES ('680', 'Command: reload rbac');
INSERT INTO rbac_permissions VALUES ('681', 'Command: reload reference_loot_template');
INSERT INTO rbac_permissions VALUES ('682', 'Command: reload reserved_name');
INSERT INTO rbac_permissions VALUES ('683', 'Command: reload reputation_reward_rate');
INSERT INTO rbac_permissions VALUES ('684', 'Command: reload reputation_spillover_template');
INSERT INTO rbac_permissions VALUES ('685', 'Command: reload skill_discovery_template');
INSERT INTO rbac_permissions VALUES ('686', 'Command: reload skill_extra_item_template');
INSERT INTO rbac_permissions VALUES ('687', 'Command: reload skill_fishing_base_level');
INSERT INTO rbac_permissions VALUES ('688', 'Command: reload skinning_loot_template');
INSERT INTO rbac_permissions VALUES ('689', 'Command: reload smart_scripts');
INSERT INTO rbac_permissions VALUES ('690', 'Command: reload spell_required');
INSERT INTO rbac_permissions VALUES ('691', 'Command: reload spell_area');
INSERT INTO rbac_permissions VALUES ('692', 'Command: reload spell_bonus_data');
INSERT INTO rbac_permissions VALUES ('693', 'Command: reload spell_group');
INSERT INTO rbac_permissions VALUES ('694', 'Command: reload spell_learn_spell');
INSERT INTO rbac_permissions VALUES ('695', 'Command: reload spell_loot_template');
INSERT INTO rbac_permissions VALUES ('696', 'Command: reload spell_linked_spell');
INSERT INTO rbac_permissions VALUES ('697', 'Command: reload spell_pet_auras');
INSERT INTO rbac_permissions VALUES ('698', 'Command: reload spell_proc_event');
INSERT INTO rbac_permissions VALUES ('699', 'Command: reload spell_proc');
INSERT INTO rbac_permissions VALUES ('700', 'Command: reload spell_scripts');
INSERT INTO rbac_permissions VALUES ('701', 'Command: reload spell_target_position');
INSERT INTO rbac_permissions VALUES ('702', 'Command: reload spell_threats');
INSERT INTO rbac_permissions VALUES ('703', 'Command: reload spell_group_stack_rules');
INSERT INTO rbac_permissions VALUES ('704', 'Command: reload trinity_string');
INSERT INTO rbac_permissions VALUES ('705', 'Command: reload warden_action');
INSERT INTO rbac_permissions VALUES ('706', 'Command: reload waypoint_scripts');
INSERT INTO rbac_permissions VALUES ('707', 'Command: reload waypoint_data');
INSERT INTO rbac_permissions VALUES ('708', 'Command: reload vehicle_accessory');
INSERT INTO rbac_permissions VALUES ('709', 'Command: reload vehicle_template_accessory');
INSERT INTO rbac_permissions VALUES ('710', 'Command: reset');
INSERT INTO rbac_permissions VALUES ('711', 'Command: reset achievements');
INSERT INTO rbac_permissions VALUES ('712', 'Command: reset honor');
INSERT INTO rbac_permissions VALUES ('713', 'Command: reset level');
INSERT INTO rbac_permissions VALUES ('714', 'Command: reset spells');
INSERT INTO rbac_permissions VALUES ('715', 'Command: reset stats');
INSERT INTO rbac_permissions VALUES ('716', 'Command: reset talents');
INSERT INTO rbac_permissions VALUES ('717', 'Command: reset all');
INSERT INTO rbac_permissions VALUES ('718', 'Command: server');
INSERT INTO rbac_permissions VALUES ('719', 'Command: server corpses');
INSERT INTO rbac_permissions VALUES ('720', 'Command: server exit');
INSERT INTO rbac_permissions VALUES ('721', 'Command: server idlerestart');
INSERT INTO rbac_permissions VALUES ('722', 'Command: server idlerestart cancel');
INSERT INTO rbac_permissions VALUES ('723', 'Command: server idleshutdown');
INSERT INTO rbac_permissions VALUES ('724', 'Command: server idleshutdown cancel');
INSERT INTO rbac_permissions VALUES ('725', 'Command: server info');
INSERT INTO rbac_permissions VALUES ('726', 'Command: server plimit');
INSERT INTO rbac_permissions VALUES ('727', 'Command: server restart');
INSERT INTO rbac_permissions VALUES ('728', 'Command: server restart cancel');
INSERT INTO rbac_permissions VALUES ('729', 'Command: server set');
INSERT INTO rbac_permissions VALUES ('730', 'Command: server set closed');
INSERT INTO rbac_permissions VALUES ('731', 'Command: server set difftime');
INSERT INTO rbac_permissions VALUES ('732', 'Command: server set loglevel');
INSERT INTO rbac_permissions VALUES ('733', 'Command: server set motd');
INSERT INTO rbac_permissions VALUES ('734', 'Command: server shutdown');
INSERT INTO rbac_permissions VALUES ('735', 'Command: server shutdown cancel');
INSERT INTO rbac_permissions VALUES ('736', 'Command: server motd');
INSERT INTO rbac_permissions VALUES ('737', 'Command: tele');
INSERT INTO rbac_permissions VALUES ('738', 'Command: tele add');
INSERT INTO rbac_permissions VALUES ('739', 'Command: tele del');
INSERT INTO rbac_permissions VALUES ('740', 'Command: tele name');
INSERT INTO rbac_permissions VALUES ('741', 'Command: tele group');
INSERT INTO rbac_permissions VALUES ('742', 'Command: ticket');
INSERT INTO rbac_permissions VALUES ('743', 'Command: ticket assign');
INSERT INTO rbac_permissions VALUES ('744', 'Command: ticket close');
INSERT INTO rbac_permissions VALUES ('745', 'Command: ticket closedlist');
INSERT INTO rbac_permissions VALUES ('746', 'Command: ticket comment');
INSERT INTO rbac_permissions VALUES ('747', 'Command: ticket complete');
INSERT INTO rbac_permissions VALUES ('748', 'Command: ticket delete');
INSERT INTO rbac_permissions VALUES ('749', 'Command: ticket escalate');
INSERT INTO rbac_permissions VALUES ('750', 'Command: ticket escalatedlist');
INSERT INTO rbac_permissions VALUES ('751', 'Command: ticket list');
INSERT INTO rbac_permissions VALUES ('752', 'Command: ticket onlinelist');
INSERT INTO rbac_permissions VALUES ('753', 'Command: ticket reset');
INSERT INTO rbac_permissions VALUES ('754', 'Command: ticket response');
INSERT INTO rbac_permissions VALUES ('755', 'Command: ticket response append');
INSERT INTO rbac_permissions VALUES ('756', 'Command: ticket response appendln');
INSERT INTO rbac_permissions VALUES ('757', 'Command: ticket togglesystem');
INSERT INTO rbac_permissions VALUES ('758', 'Command: ticket unassign');
INSERT INTO rbac_permissions VALUES ('759', 'Command: ticket viewid');
INSERT INTO rbac_permissions VALUES ('760', 'Command: ticket viewname');
INSERT INTO rbac_permissions VALUES ('761', 'Command: titles');
INSERT INTO rbac_permissions VALUES ('762', 'Command: titles add');
INSERT INTO rbac_permissions VALUES ('763', 'Command: titles current');
INSERT INTO rbac_permissions VALUES ('764', 'Command: titles remove');
INSERT INTO rbac_permissions VALUES ('765', 'Command: titles set');
INSERT INTO rbac_permissions VALUES ('766', 'Command: titles set mask');
INSERT INTO rbac_permissions VALUES ('767', 'Command: wp');
INSERT INTO rbac_permissions VALUES ('768', 'Command: wp add');
INSERT INTO rbac_permissions VALUES ('769', 'Command: wp event');
INSERT INTO rbac_permissions VALUES ('770', 'Command: wp load');
INSERT INTO rbac_permissions VALUES ('771', 'Command: wp modify');
INSERT INTO rbac_permissions VALUES ('772', 'Command: wp unload');
INSERT INTO rbac_permissions VALUES ('773', 'Command: wp reload');
INSERT INTO rbac_permissions VALUES ('774', 'Command: wp show');

-- ----------------------------
-- Table structure for `realmcharacters`
-- ----------------------------
DROP TABLE IF EXISTS `realmcharacters`;
CREATE TABLE `realmcharacters` (
  `realmid` int(10) unsigned NOT NULL DEFAULT '0',
  `acctid` int(10) unsigned NOT NULL,
  `numchars` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`realmid`,`acctid`),
  KEY `acctid` (`acctid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Realm Character Tracker';

-- ----------------------------
-- Records of realmcharacters
-- ----------------------------

-- ----------------------------
-- Table structure for `realmlist`
-- ----------------------------
DROP TABLE IF EXISTS `realmlist`;
CREATE TABLE `realmlist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '',
  `address` varchar(255) NOT NULL DEFAULT '127.0.0.1',
  `localAddress` varchar(255) NOT NULL DEFAULT '127.0.0.1',
  `localSubnetMask` varchar(255) NOT NULL DEFAULT '255.255.255.0',
  `port` smallint(5) unsigned NOT NULL DEFAULT '8085',
  `icon` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `flag` tinyint(3) unsigned NOT NULL DEFAULT '2',
  `timezone` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `allowedSecurityLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `population` float unsigned NOT NULL DEFAULT '0',
  `gamebuild` int(10) unsigned NOT NULL DEFAULT '12340',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Realm System';

-- ----------------------------
-- Records of realmlist
-- ----------------------------
INSERT INTO realmlist VALUES ('1', 'Trinity', '127.0.0.1', '127.0.0.1', '255.255.255.0', '8085', '1', '0', '1', '0', '0', '12340');

-- ----------------------------
-- Table structure for `uptime`
-- ----------------------------
DROP TABLE IF EXISTS `uptime`;
CREATE TABLE `uptime` (
  `realmid` int(10) unsigned NOT NULL,
  `starttime` int(10) unsigned NOT NULL DEFAULT '0',
  `uptime` int(10) unsigned NOT NULL DEFAULT '0',
  `maxplayers` smallint(5) unsigned NOT NULL DEFAULT '0',
  `revision` varchar(255) NOT NULL DEFAULT 'Trinitycore',
  PRIMARY KEY (`realmid`,`starttime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Uptime system';

-- ----------------------------
-- Records of uptime
-- ----------------------------
