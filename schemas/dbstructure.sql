/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `Account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Account` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `userGroupId` smallint(5) unsigned NOT NULL,
  `userId` smallint(5) unsigned NOT NULL,
  `userEditId` smallint(5) unsigned NOT NULL,
  `clientId` mediumint(8) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `categoryId` mediumint(8) unsigned NOT NULL,
  `login` varchar(50) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `pass` varbinary(1000) NOT NULL,
  `key` varbinary(1000) NOT NULL,
  `notes` text DEFAULT NULL,
  `countView` int(10) unsigned NOT NULL DEFAULT 0,
  `countDecrypt` int(10) unsigned NOT NULL DEFAULT 0,
  `dateAdd` datetime NOT NULL,
  `dateEdit` datetime DEFAULT NULL,
  `otherUserGroupEdit` tinyint(1) DEFAULT 0,
  `otherUserEdit` tinyint(1) DEFAULT 0,
  `isPrivate` tinyint(1) DEFAULT 0,
  `isPrivateGroup` tinyint(1) DEFAULT 0,
  `passDate` int(11) unsigned DEFAULT NULL,
  `passDateChange` int(11) unsigned DEFAULT NULL,
  `parentId` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_categoryId` (`categoryId`),
  KEY `IDX_userId` (`userGroupId`,`userId`),
  KEY `IDX_customerId` (`clientId`),
  KEY `fk_Account_userId` (`userId`),
  KEY `fk_Account_userEditId` (`userEditId`),
  CONSTRAINT `fk_Account_categoryId` FOREIGN KEY (`categoryId`) REFERENCES `Category` (`id`),
  CONSTRAINT `fk_Account_clientId` FOREIGN KEY (`clientId`) REFERENCES `Client` (`id`),
  CONSTRAINT `fk_Account_userEditId` FOREIGN KEY (`userEditId`) REFERENCES `User` (`id`),
  CONSTRAINT `fk_Account_userGroupId` FOREIGN KEY (`userGroupId`) REFERENCES `UserGroup` (`id`),
  CONSTRAINT `fk_Account_userId` FOREIGN KEY (`userId`) REFERENCES `User` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `AccountFile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AccountFile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountId` mediumint(8) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `size` int(11) NOT NULL,
  `content` mediumblob NOT NULL,
  `extension` varchar(10) NOT NULL,
  `thumb` mediumblob DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_accountId` (`accountId`),
  CONSTRAINT `fk_AccountFile_accountId` FOREIGN KEY (`accountId`) REFERENCES `Account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `AccountHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AccountHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountId` mediumint(8) unsigned NOT NULL,
  `userGroupId` smallint(5) unsigned NOT NULL,
  `userId` smallint(5) unsigned NOT NULL,
  `userEditId` smallint(5) unsigned NOT NULL,
  `clientId` mediumint(8) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `categoryId` mediumint(8) unsigned NOT NULL,
  `login` varchar(50) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `pass` varbinary(1000) NOT NULL,
  `key` varbinary(1000) NOT NULL,
  `notes` text NOT NULL,
  `countView` int(10) unsigned NOT NULL DEFAULT 0,
  `countDecrypt` int(10) unsigned NOT NULL DEFAULT 0,
  `dateAdd` datetime NOT NULL,
  `dateEdit` datetime DEFAULT NULL,
  `isModify` tinyint(1) DEFAULT 0,
  `isDeleted` tinyint(1) DEFAULT 0,
  `mPassHash` varbinary(255) NOT NULL,
  `otherUserEdit` tinyint(1) DEFAULT 0,
  `otherUserGroupEdit` tinyint(1) DEFAULT 0,
  `passDate` int(10) unsigned DEFAULT NULL,
  `passDateChange` int(10) unsigned DEFAULT NULL,
  `parentId` mediumint(8) unsigned DEFAULT NULL,
  `isPrivate` tinyint(1) DEFAULT 0,
  `isPrivateGroup` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `IDX_accountId` (`accountId`),
  KEY `fk_AccountHistory_userGroupId` (`userGroupId`),
  KEY `fk_AccountHistory_userId` (`userId`),
  KEY `fk_AccountHistory_userEditId` (`userEditId`),
  KEY `fk_AccountHistory_clientId` (`clientId`),
  KEY `fk_AccountHistory_categoryId` (`categoryId`),
  CONSTRAINT `fk_AccountHistory_categoryId` FOREIGN KEY (`categoryId`) REFERENCES `Category` (`id`),
  CONSTRAINT `fk_AccountHistory_clientId` FOREIGN KEY (`clientId`) REFERENCES `Client` (`id`),
  CONSTRAINT `fk_AccountHistory_userEditId` FOREIGN KEY (`userEditId`) REFERENCES `User` (`id`),
  CONSTRAINT `fk_AccountHistory_userGroupId` FOREIGN KEY (`userGroupId`) REFERENCES `UserGroup` (`id`),
  CONSTRAINT `fk_AccountHistory_userId` FOREIGN KEY (`userId`) REFERENCES `User` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `AccountToFavorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AccountToFavorite` (
  `accountId` mediumint(8) unsigned NOT NULL,
  `userId` smallint(5) unsigned NOT NULL,
  KEY `search_idx` (`accountId`,`userId`),
  KEY `fk_AccountToFavorite_userId` (`userId`),
  CONSTRAINT `fk_AccountToFavorite_accountId` FOREIGN KEY (`accountId`) REFERENCES `Account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_AccountToFavorite_userId` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS AccountToUserGroup;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AccountToUserGroup` (
  `accountId` mediumint(8) unsigned NOT NULL,
  `userGroupId` smallint(5) unsigned NOT NULL,
  KEY `IDX_accountId` (`accountId`),
  KEY `fk_AccountToGroup_userGroupId` (`userGroupId`),
  CONSTRAINT `fk_AccountToUserGroup_accountId` FOREIGN KEY (`accountId`) REFERENCES `Account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_AccountToUserGroup_userGroupId` FOREIGN KEY (`userGroupId`) REFERENCES `UserGroup` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `AccountToTag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AccountToTag` (
  `accountId` mediumint(8) unsigned NOT NULL,
  `tagId` int(10) unsigned NOT NULL,
  KEY `fk_AccountToTag_accountId` (`accountId`),
  KEY `fk_AccountToTag_tagId` (`tagId`),
  CONSTRAINT `fk_AccountToTag_accountId` FOREIGN KEY (`accountId`) REFERENCES `Account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_AccountToTag_tagId` FOREIGN KEY (`tagId`) REFERENCES `Tag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `AccountToUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AccountToUser` (
  `accountId` mediumint(8) unsigned NOT NULL,
  `userId` smallint(5) unsigned NOT NULL,
  KEY `idx_account` (`accountId`),
  KEY `fk_AccountToUser_userId` (`userId`),
  CONSTRAINT `fk_AccountToUser_accountId` FOREIGN KEY (`accountId`) REFERENCES `Account` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_AccountToUser_userId` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `Action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Action` (
  `id` smallint(5) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `text` varchar(100) NOT NULL,
  `route` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `AuthToken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuthToken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` smallint(5) unsigned NOT NULL,
  `token` varbinary(100) NOT NULL,
  `actionId` smallint(5) unsigned NOT NULL,
  `createdBy` smallint(5) unsigned NOT NULL,
  `startDate` int(10) unsigned NOT NULL,
  `vault` varbinary(2000) DEFAULT NULL,
  `hash` varbinary(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_authtoken_id` (`id`),
  KEY `IDX_checkToken` (`userId`,`actionId`,`token`),
  KEY `fk_AuthToken_actionId` (`actionId`),
  CONSTRAINT `fk_AuthToken_actionId` FOREIGN KEY (`actionId`) REFERENCES `Action` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_AuthToken_userId` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Category` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `hash` varbinary(40) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `Client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Client` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `hash` varbinary(40) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isGlobal` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `IDX_name` (`name`,`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `Config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Config` (
  `parameter` varchar(50) NOT NULL,
  `value` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`parameter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `CustomFieldData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomFieldData` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `moduleId` smallint(5) unsigned NOT NULL,
  `itemId` int(10) unsigned NOT NULL,
  `definitionId` int(10) unsigned NOT NULL,
  `data` longblob DEFAULT NULL,
  `key` varbinary(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_DEFID` (`definitionId`),
  KEY `IDX_DELETE` (`itemId`,`moduleId`),
  KEY `IDX_UPDATE` (`moduleId`,`itemId`,`definitionId`),
  KEY `IDX_ITEM` (`itemId`),
  KEY `IDX_MODULE` (`moduleId`),
  CONSTRAINT `fk_CustomFieldData_definitionId` FOREIGN KEY (`definitionId`) REFERENCES `CustomFieldDefinition` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `CustomFieldDefinition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomFieldDefinition` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `moduleId` smallint(5) unsigned NOT NULL,
  `field` blob DEFAULT NULL,
  `required` tinyint(1) unsigned DEFAULT NULL,
  `help` varchar(255) DEFAULT NULL,
  `showInList` tinyint(1) unsigned DEFAULT NULL,
  `typeId` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_CustomFieldDefinition_typeId` (`typeId`),
  CONSTRAINT `fk_CustomFieldDefinition_typeId` FOREIGN KEY (`typeId`) REFERENCES `CustomFieldType` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `CustomFieldType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomFieldType` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `text` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `EventLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EventLog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` int(10) unsigned NOT NULL,
  `login` varchar(25) NOT NULL,
  `userId` smallint(5) unsigned NOT NULL,
  `ipAddress` varchar(45) NOT NULL,
  `action` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `level` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `Notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Notice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  `component` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `date` int(10) unsigned NOT NULL,
  `checked` tinyint(1) DEFAULT 0,
  `userId` smallint(5) unsigned DEFAULT NULL,
  `sticky` tinyint(1) DEFAULT 0,
  `onlyAdmin` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `IDX_userId` (`userId`,`checked`,`date`),
  KEY `IDX_component` (`component`,`date`,`checked`,`userId`),
  CONSTRAINT `fk_Notice_userId` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `Plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Plugin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `data` varbinary(5000) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `available` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugin_name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `PublicLink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PublicLink` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemId` int(10) unsigned NOT NULL,
  `hash` varbinary(100) NOT NULL,
  `data` longblob DEFAULT NULL,
  `userId` smallint(5) unsigned NOT NULL,
  `typeId` int(10) unsigned NOT NULL,
  `notify` tinyint(1) unsigned NOT NULL,
  `dateAdd` int(10) unsigned NOT NULL,
  `dateExpire` int(10) unsigned NOT NULL,
  `countViews` smallint(5) unsigned DEFAULT 0,
  `totalCountViews` smallint(5) unsigned DEFAULT 0,
  `maxCountViews` smallint(5) unsigned NOT NULL,
  `useInfo` blob DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_hash` (`hash`),
  UNIQUE KEY `unique_publicLink_hash` (`hash`),
  UNIQUE KEY `unique_publicLink_accountId` (`itemId`),
  KEY `IDX_itemId` (`itemId`),
  KEY `fk_PublicLink_userId` (`userId`),
  CONSTRAINT `fk_PublicLink_userId` FOREIGN KEY (`userId`) REFERENCES `User` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `Tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `hash` binary(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag_hash_UNIQUE` (`hash`),
  KEY `IDX_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `Track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Track` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` smallint(5) unsigned DEFAULT NULL,
  `source` varchar(100) NOT NULL,
  `time` int(10) unsigned NOT NULL,
  `ipv4` binary(4) NOT NULL,
  `ipv6` binary(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_userId` (`userId`),
  KEY `IDX_time-ip-source` (`time`,`ipv4`,`ipv6`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `userGroupId` smallint(5) unsigned NOT NULL,
  `login` varchar(50) NOT NULL,
  `ssoLogin` varchar(100) DEFAULT NULL,
  `pass` varbinary(1000) NOT NULL,
  `mPass` varbinary(1000) DEFAULT NULL,
  `mKey` varbinary(1000) DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `loginCount` int(10) unsigned NOT NULL DEFAULT 0,
  `userProfileId` smallint(5) unsigned NOT NULL,
  `lastLogin` datetime DEFAULT NULL,
  `lastUpdate` datetime DEFAULT NULL,
  `lastUpdateMPass` int(11) unsigned NOT NULL DEFAULT 0,
  `isAdminApp` tinyint(1) DEFAULT 0,
  `isAdminAcc` tinyint(1) DEFAULT 0,
  `isLdap` tinyint(1) DEFAULT 0,
  `isDisabled` tinyint(1) DEFAULT 0,
  `hashSalt` varbinary(128) NOT NULL,
  `isMigrate` tinyint(1) DEFAULT 0,
  `isChangePass` tinyint(1) DEFAULT 0,
  `isChangedPass` tinyint(1) DEFAULT 0,
  `preferences` blob DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_login` (`login`,`ssoLogin`),
  KEY `IDX_pass` (`pass`(767)),
  KEY `fk_User_userGroupId` (`userGroupId`),
  KEY `fk_User_userProfileId` (`userProfileId`),
  CONSTRAINT `fk_User_userGroupId` FOREIGN KEY (`userGroupId`) REFERENCES `UserGroup` (`id`),
  CONSTRAINT `fk_User_userProfileId` FOREIGN KEY (`userProfileId`) REFERENCES `UserProfile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `UserGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserGroup` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `UserPassRecover`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserPassRecover` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` smallint(5) unsigned NOT NULL,
  `hash` varbinary(128) NOT NULL,
  `date` int(10) unsigned NOT NULL,
  `used` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `IDX_userId` (`userId`,`date`),
  CONSTRAINT `fk_UserPassRecover_userId` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `UserProfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserProfile` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `profile` blob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS UserToUserGroup;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserToUserGroup` (
  `userId` smallint(5) unsigned NOT NULL,
  `userGroupId` smallint(5) unsigned NOT NULL,
  KEY `IDX_usertogroup_userId` (`userId`),
  KEY `fk_UserToGroup_userGroupId` (`userGroupId`),
  CONSTRAINT `fk_UserToUserGroup_userGroupId` FOREIGN KEY (`userGroupId`) REFERENCES `UserGroup` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_UserToUserGroup_userId` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `account_data_v`;
/*!50001 DROP VIEW IF EXISTS `account_data_v`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `account_data_v` (
  `id` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `categoryId` tinyint NOT NULL,
  `userId` tinyint NOT NULL,
  `clientId` tinyint NOT NULL,
  `userGroupId` tinyint NOT NULL,
  `userEditId` tinyint NOT NULL,
  `login` tinyint NOT NULL,
  `url` tinyint NOT NULL,
  `notes` tinyint NOT NULL,
  `countView` tinyint NOT NULL,
  `countDecrypt` tinyint NOT NULL,
  `dateAdd` tinyint NOT NULL,
  `dateEdit` tinyint NOT NULL,
  `otherUserEdit` tinyint NOT NULL,
  `otherUserGroupEdit` tinyint NOT NULL,
  `isPrivate` tinyint NOT NULL,
  `isPrivateGroup` tinyint NOT NULL,
  `passDate` tinyint NOT NULL,
  `passDateChange` tinyint NOT NULL,
  `parentId` tinyint NOT NULL,
  `categoryName` tinyint NOT NULL,
  `clientName` tinyint NOT NULL,
  `userGroupName` tinyint NOT NULL,
  `userName` tinyint NOT NULL,
  `userLogin` tinyint NOT NULL,
  `userEditName` tinyint NOT NULL,
  `userEditLogin` tinyint NOT NULL,
  `publicLinkHash` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

DROP TABLE IF EXISTS `account_search_v`;
/*!50001 DROP VIEW IF EXISTS `account_search_v`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `account_search_v` (
  `id` tinyint NOT NULL,
  `clientId` tinyint NOT NULL,
  `categoryId` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `login` tinyint NOT NULL,
  `url` tinyint NOT NULL,
  `notes` tinyint NOT NULL,
  `userId` tinyint NOT NULL,
  `userGroupId` tinyint NOT NULL,
  `otherUserEdit` tinyint NOT NULL,
  `otherUserGroupEdit` tinyint NOT NULL,
  `isPrivate` tinyint NOT NULL,
  `isPrivateGroup` tinyint NOT NULL,
  `passDate` tinyint NOT NULL,
  `passDateChange` tinyint NOT NULL,
  `parentId` tinyint NOT NULL,
  `countView` tinyint NOT NULL,
  `userGroupName` tinyint NOT NULL,
  `categoryName` tinyint NOT NULL,
  `customerName` tinyint NOT NULL,
  `num_files` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

/*!50001 DROP TABLE IF EXISTS `account_data_v`*/;
/*!50001 DROP VIEW IF EXISTS `account_data_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `account_data_v` AS select `Account`.`id` AS `id`,`Account`.`name` AS `name`,`Account`.`categoryId` AS `categoryId`,`Account`.`userId` AS `userId`,`Account`.`clientId` AS `clientId`,`Account`.`userGroupId` AS `userGroupId`,`Account`.`userEditId` AS `userEditId`,`Account`.`login` AS `login`,`Account`.`url` AS `url`,`Account`.`notes` AS `notes`,`Account`.`countView` AS `countView`,`Account`.`countDecrypt` AS `countDecrypt`,`Account`.`dateAdd` AS `dateAdd`,`Account`.`dateEdit` AS `dateEdit`,conv(`Account`.`otherUserEdit`,10,2) AS `otherUserEdit`,conv(`Account`.`otherUserGroupEdit`,10,2) AS `otherUserGroupEdit`,conv(`Account`.`isPrivate`,10,2) AS `isPrivate`,conv(`Account`.`isPrivateGroup`,10,2) AS `isPrivateGroup`,`Account`.`passDate` AS `passDate`,`Account`.`passDateChange` AS `passDateChange`,`Account`.`parentId` AS `parentId`,`Category`.`name` AS `categoryName`,`Client`.`name` AS `clientName`,`ug`.`name` AS `userGroupName`,`u1`.`name` AS `userName`,`u1`.`login` AS `userLogin`,`u2`.`name` AS `userEditName`,`u2`.`login` AS `userEditLogin`,`PublicLink`.`hash` AS `publicLinkHash` from ((((((`Account` left join `Category` on(`Account`.`categoryId` = `Category`.`id`)) join `UserGroup` `ug` on(`Account`.`userGroupId` = `ug`.`id`)) join `User` `u1` on(`Account`.`userId` = `u1`.`id`)) join `User` `u2` on(`Account`.`userEditId` = `u2`.`id`)) left join `Client` on(`Account`.`clientId` = `Client`.`id`)) left join `PublicLink` on(`Account`.`id` = `PublicLink`.`itemId`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

/*!50001 DROP TABLE IF EXISTS `account_search_v`*/;
/*!50001 DROP VIEW IF EXISTS `account_search_v`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `account_search_v` AS select distinct `Account`.`id` AS `id`,`Account`.`clientId` AS `clientId`,`Account`.`categoryId` AS `categoryId`,`Account`.`name` AS `name`,`Account`.`login` AS `login`,`Account`.`url` AS `url`,`Account`.`notes` AS `notes`,`Account`.`userId` AS `userId`,`Account`.`userGroupId` AS `userGroupId`,`Account`.`otherUserEdit` AS `otherUserEdit`,`Account`.`otherUserGroupEdit` AS `otherUserGroupEdit`,`Account`.`isPrivate` AS `isPrivate`,`Account`.`isPrivateGroup` AS `isPrivateGroup`,`Account`.`passDate` AS `passDate`,`Account`.`passDateChange` AS `passDateChange`,`Account`.`parentId` AS `parentId`,`Account`.`countView` AS `countView`,`ug`.`name` AS `userGroupName`,`Category`.`name` AS `categoryName`,`Client`.`name` AS `customerName`,(select count(0) from `AccountFile` where `AccountFile`.`accountId` = `Account`.`id`) AS `num_files` from (((`Account` join `Category` on(`Account`.`categoryId` = `Category`.`id`)) join `UserGroup` `ug` on(`Account`.`userGroupId` = `ug`.`id`)) join `Client` on(`Client`.`id` = `Account`.`clientId`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
