/*
Navicat MySQL Data Transfer

Source Server         : mysql57
Source Server Version : 50727
Source Host           : localhost:3306
Source Database       : monitorsys

Target Server Type    : MYSQL
Target Server Version : 50727
File Encoding         : 65001

Date: 2021-04-19 20:29:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for address_forward
-- ----------------------------
DROP TABLE IF EXISTS `address_forward`;
CREATE TABLE `address_forward` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(255) DEFAULT NULL,
  `port` varchar(255) DEFAULT NULL,
  `mac` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=675 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for algorithm
-- ----------------------------
DROP TABLE IF EXISTS `algorithm`;
CREATE TABLE `algorithm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `zhname` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for arp
-- ----------------------------
DROP TABLE IF EXISTS `arp`;
CREATE TABLE `arp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `localIp` varchar(100) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `mac` varchar(100) DEFAULT NULL,
  `time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=422 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for attable
-- ----------------------------
DROP TABLE IF EXISTS `attable`;
CREATE TABLE `attable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(100) DEFAULT NULL,
  `atIfIndex` varchar(100) DEFAULT NULL,
  `atPhysAddress` varchar(100) DEFAULT NULL,
  `atNetAddress` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for connectively
-- ----------------------------
DROP TABLE IF EXISTS `connectively`;
CREATE TABLE `connectively` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sip` varchar(255) DEFAULT NULL,
  `dip` varchar(255) DEFAULT NULL,
  `sifindex` varchar(255) DEFAULT NULL,
  `difindex` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for cpu
-- ----------------------------
DROP TABLE IF EXISTS `cpu`;
CREATE TABLE `cpu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(100) DEFAULT NULL,
  `cpuRate` double(20,0) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17542 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for devicetype
-- ----------------------------
DROP TABLE IF EXISTS `devicetype`;
CREATE TABLE `devicetype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceIp` varchar(100) DEFAULT NULL,
  `ip` varchar(100) NOT NULL,
  `typeName` varchar(20) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=978 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for diagnosis
-- ----------------------------
DROP TABLE IF EXISTS `diagnosis`;
CREATE TABLE `diagnosis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(100) DEFAULT NULL COMMENT '设备ip',
  `pid` int(11) DEFAULT NULL COMMENT '监测点',
  `time` datetime DEFAULT NULL,
  `cause` text COMMENT '故障原因',
  `remark` text COMMENT '备注',
  `status` int(11) DEFAULT NULL COMMENT '未处理已处理已忽略',
  `rank` varchar(100) DEFAULT NULL,
  `rankClass` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `p_d_fk` (`pid`),
  CONSTRAINT `p_d_fk` FOREIGN KEY (`pid`) REFERENCES `point` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1140 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for disk
-- ----------------------------
DROP TABLE IF EXISTS `disk`;
CREATE TABLE `disk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(100) DEFAULT NULL,
  `disk_name` varchar(100) DEFAULT NULL,
  `disk_capacity` varchar(20) DEFAULT NULL,
  `disk_rate` varchar(20) DEFAULT NULL,
  `get_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dot1dtpfdtable
-- ----------------------------
DROP TABLE IF EXISTS `dot1dtpfdtable`;
CREATE TABLE `dot1dtpfdtable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(100) NOT NULL,
  `dot1dTpFdbAddress` varchar(255) DEFAULT NULL,
  `dot1dTpFdbPort` varchar(255) DEFAULT NULL,
  `dot1dTpFdbStatus` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for edge
-- ----------------------------
DROP TABLE IF EXISTS `edge`;
CREATE TABLE `edge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` varchar(100) DEFAULT NULL,
  `target` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for index_relation_port
-- ----------------------------
DROP TABLE IF EXISTS `index_relation_port`;
CREATE TABLE `index_relation_port` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(255) DEFAULT NULL,
  `port` varchar(255) DEFAULT NULL,
  `ifindex` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=793 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for instances
-- ----------------------------
DROP TABLE IF EXISTS `instances`;
CREATE TABLE `instances` (
  `attr0` double DEFAULT NULL,
  `attr1` double DEFAULT NULL,
  `attr2` double DEFAULT NULL,
  `attr3` double DEFAULT NULL,
  `attr4` double DEFAULT NULL,
  `attr5` double DEFAULT NULL,
  `attr6` double DEFAULT NULL,
  `attr7` double DEFAULT NULL,
  `attr8` double DEFAULT NULL,
  `attr9` double DEFAULT NULL,
  `attr10` double DEFAULT NULL,
  `attr11` double DEFAULT NULL,
  `attr12` double DEFAULT NULL,
  `attr13` double DEFAULT NULL,
  `attr14` double DEFAULT NULL,
  `attr15` double DEFAULT NULL,
  `attr16` double DEFAULT NULL,
  `attr17` double DEFAULT NULL,
  `attr18` double DEFAULT NULL,
  `attr19` double DEFAULT NULL,
  `attr20` double DEFAULT NULL,
  `attr21` double DEFAULT NULL,
  `attr22` double DEFAULT NULL,
  `attr23` double DEFAULT NULL,
  `attr24` double DEFAULT NULL,
  `attr25` double DEFAULT NULL,
  `attr26` double DEFAULT NULL,
  `attr27` double DEFAULT NULL,
  `attr28` double DEFAULT NULL,
  `attr29` double DEFAULT NULL,
  `attr30` double DEFAULT NULL,
  `attr31` double DEFAULT NULL,
  `attr32` double DEFAULT NULL,
  `attr33` double DEFAULT NULL,
  `attr34` double DEFAULT NULL,
  `attr35` double DEFAULT NULL,
  `attr36` double DEFAULT NULL,
  `attr37` double DEFAULT NULL,
  `attr38` double DEFAULT NULL,
  `attr39` double DEFAULT NULL,
  `attr40` double DEFAULT NULL,
  `attr41` double DEFAULT NULL,
  `attr42` double DEFAULT NULL,
  `attr43` double DEFAULT NULL,
  `attr44` double DEFAULT NULL,
  `attr45` double DEFAULT NULL,
  `attr46` double DEFAULT NULL,
  `attr47` double DEFAULT NULL,
  `attr48` double DEFAULT NULL,
  `attr49` double DEFAULT NULL,
  `attr50` double DEFAULT NULL,
  `attr51` double DEFAULT NULL,
  `attr52` double DEFAULT NULL,
  `attr53` double DEFAULT NULL,
  `attr54` double DEFAULT NULL,
  `attr55` double DEFAULT NULL,
  `attr56` double DEFAULT NULL,
  `attr57` double DEFAULT NULL,
  `attr58` double DEFAULT NULL,
  `attr59` double DEFAULT NULL,
  `attr60` double DEFAULT NULL,
  `attr61` double DEFAULT NULL,
  `attr62` double DEFAULT NULL,
  `attr63` double DEFAULT NULL,
  `attr64` double DEFAULT NULL,
  `attr65` double DEFAULT NULL,
  `attr66` double DEFAULT NULL,
  `attr67` double DEFAULT NULL,
  `attr68` double DEFAULT NULL,
  `attr69` double DEFAULT NULL,
  `attr70` double DEFAULT NULL,
  `attr71` double DEFAULT NULL,
  `attr72` double DEFAULT NULL,
  `attr73` double DEFAULT NULL,
  `attr74` double DEFAULT NULL,
  `attr75` double DEFAULT NULL,
  `attr76` double DEFAULT NULL,
  `attr77` double DEFAULT NULL,
  `attr78` double DEFAULT NULL,
  `attr79` double DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for interface
-- ----------------------------
DROP TABLE IF EXISTS `interface`;
CREATE TABLE `interface` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Ifindex` varchar(20) DEFAULT NULL,
  `ip` varchar(100) NOT NULL,
  `IfDescr` varchar(255) DEFAULT NULL,
  `IfType` varchar(50) DEFAULT NULL,
  `IfOperStatus` varchar(10) DEFAULT NULL,
  `IfAdminStatus` varchar(10) DEFAULT NULL,
  `IfSpeed` varchar(100) DEFAULT NULL,
  `IfMtu` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1911 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for interface_mac
-- ----------------------------
DROP TABLE IF EXISTS `interface_mac`;
CREATE TABLE `interface_mac` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(255) DEFAULT NULL,
  `ifindex` varchar(255) DEFAULT NULL,
  `ifmac` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for interflow
-- ----------------------------
DROP TABLE IF EXISTS `interflow`;
CREATE TABLE `interflow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(100) NOT NULL,
  `ifindex` varchar(20) DEFAULT NULL,
  `interDescr` varchar(255) DEFAULT NULL,
  `inFlow` varchar(20) DEFAULT NULL,
  `outFlow` varchar(20) DEFAULT NULL,
  `inLoss` varchar(20) DEFAULT NULL,
  `outLoss` varchar(20) DEFAULT NULL,
  `inRate` varchar(20) DEFAULT NULL,
  `outRate` varchar(20) DEFAULT NULL,
  `inErrorRate` varchar(20) DEFAULT NULL,
  `outErrorRate` varchar(20) DEFAULT NULL,
  `time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=189013 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ipaddrtable
-- ----------------------------
DROP TABLE IF EXISTS `ipaddrtable`;
CREATE TABLE `ipaddrtable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(100) DEFAULT NULL,
  `ipAdEntAddr` varchar(100) NOT NULL,
  `ipAdEntIfIndex` varchar(20) DEFAULT NULL,
  `ipAdEntNetMask` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1322 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for iproutetable
-- ----------------------------
DROP TABLE IF EXISTS `iproutetable`;
CREATE TABLE `iproutetable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(100) NOT NULL,
  `ipRouteDest` varchar(100) DEFAULT NULL,
  `ipRouteIfIndex` varchar(100) DEFAULT NULL,
  `ipRouteNextHop` varchar(100) DEFAULT NULL,
  `ipRouteType` varchar(100) DEFAULT NULL,
  `ipRouteMask` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1570 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for memory
-- ----------------------------
DROP TABLE IF EXISTS `memory`;
CREATE TABLE `memory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(100) DEFAULT NULL,
  `memTotalReal` varchar(20) DEFAULT NULL,
  `memAvailReal` varchar(20) DEFAULT NULL,
  `memRate` varchar(20) DEFAULT NULL,
  `time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13720 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mibs
-- ----------------------------
DROP TABLE IF EXISTS `mibs`;
CREATE TABLE `mibs` (
  `oid` varchar(255) NOT NULL,
  `pid` int(11) DEFAULT NULL,
  `val` text,
  `zhval` text,
  PRIMARY KEY (`oid`),
  KEY `p_m_fk` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for model
-- ----------------------------
DROP TABLE IF EXISTS `model`;
CREATE TABLE `model` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for neighbor_mac
-- ----------------------------
DROP TABLE IF EXISTS `neighbor_mac`;
CREATE TABLE `neighbor_mac` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(255) DEFAULT NULL,
  `remmac` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for node
-- ----------------------------
DROP TABLE IF EXISTS `node`;
CREATE TABLE `node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(100) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ping
-- ----------------------------
DROP TABLE IF EXISTS `ping`;
CREATE TABLE `ping` (
  `ip` varchar(255) NOT NULL,
  `segment` varchar(255) DEFAULT NULL,
  `netmask` varchar(255) DEFAULT NULL,
  `isSnmp` tinyint(4) DEFAULT NULL,
  `time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for point
-- ----------------------------
DROP TABLE IF EXISTS `point`;
CREATE TABLE `point` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `zhtype` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ruleset
-- ----------------------------
DROP TABLE IF EXISTS `ruleset`;
CREATE TABLE `ruleset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sysip` varchar(255) NOT NULL,
  `pointid` int(11) NOT NULL,
  `cron` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `r_p_fk` (`pointid`),
  CONSTRAINT `r_p_fk` FOREIGN KEY (`pointid`) REFERENCES `point` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for snmptrap
-- ----------------------------
DROP TABLE IF EXISTS `snmptrap`;
CREATE TABLE `snmptrap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(100) DEFAULT NULL,
  `community` varchar(20) DEFAULT NULL,
  `version` varchar(20) DEFAULT NULL,
  `value` text,
  `zhpoint` varchar(100) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `rank` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for system
-- ----------------------------
DROP TABLE IF EXISTS `system`;
CREATE TABLE `system` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(50) NOT NULL,
  `sysDecsr` varchar(255) DEFAULT NULL,
  `sysObjectID` varchar(100) DEFAULT NULL,
  `sysUpTime` varchar(100) DEFAULT NULL,
  `sysContact` varchar(255) DEFAULT NULL,
  `sysName` varchar(100) DEFAULT NULL,
  `sysLocation` varchar(100) DEFAULT NULL,
  `sysService` varchar(100) DEFAULT NULL,
  `selfDecs` varchar(255) DEFAULT NULL,
  `typeName` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `time` varchar(100) DEFAULT NULL,
  `community` varchar(100) DEFAULT NULL,
  `version` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
