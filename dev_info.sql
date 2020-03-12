DROP TABLE IF EXISTS `dev_info`;
CREATE TABLE dev_info(
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`dev_id` int(11) DEFAULT NULL,
	`temp` int(4) DEFAULT NULL,
	`info` varchar(1024) COLLATE utf8_bin NOT NULL,
	PRIMARY KEY(`id`),
	KEY `dev_id`(`dev_id`)
) DEFAULT CHARSET=utf8;

-- DROP TABLE IF EXISTS `dev_info`;
CREATE TABLE dev_info(
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`dev_id` int(11) DEFAULT NULL,
	`temp` int(11) DEFAULT NULL,
	`info` varchar(1024) COLLATE utf8_bin NOT NULL,
	PRIMARY KEY(`id`),
	KEY `dev_id`(`dev_id`)
) DEFAULT CHARSET=utf8;

SHOW TABLES;

INSERT INTO dev_info(dev_id, temp, info) VALUES(1, 23, '这台设备很不错');

SELECT COUNT(*) FROM dev_info;

-- 0.3ms
SELECT * FROM `dev_info` LIMIT 20;

-- 2.3ms
SELECT * FROM `dev_info` LIMIT 10000, 20;

-- 110ms
EXPLAIN SELECT * FROM `dev_info` LIMIT 511900, 20;

-- 0.5ms
EXPLAIN SELECT * FROM `dev_info` WHERE id > 51190 LIMIT 20;

-- 6.5ms 覆盖索引子查询
EXPLAIN SELECT * FROM dev_info WHERE id >= (SELECT id FROM dev_info LIMIT 51190, 1) LIMIT 20;


-- 0.4ms
SELECT id
FROM
(
	SELECT id FROM dev_info
	WHERE id < 51190 ORDER BY id DESC
	LIMIT 20
) AS dev_info_res
ORDER BY id
LIMIT 1;

-- 0.5ms
EXPLAIN
SELECT * FROM dev_info WHERE id > (
SELECT id
FROM
(
	SELECT id FROM dev_info
	WHERE id < 51190 ORDER BY id DESC
	LIMIT 20
) AS dev_info_res
ORDER BY id
LIMIT 1
) LIMIT 20;

