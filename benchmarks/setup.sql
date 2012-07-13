DROP TABLE IF EXISTS `cache_versions`;

CREATE TABLE `cache_versions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) DEFAULT NULL,
  `counter_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO cache_versions (shop_id,counter_id,value) VALUES(1, 1,0);

INSERT INTO cache_versions (shop_id,counter_id,value) VALUES(2, 1, 0);
INSERT INTO cache_versions (shop_id,counter_id,value) VALUES(2, 2, 0);
INSERT INTO cache_versions (shop_id,counter_id,value) VALUES(2, 3, 0);

INSERT INTO cache_versions (shop_id,counter_id,value) VALUES(3, 1, 0);
INSERT INTO cache_versions (shop_id,counter_id,value) VALUES(3, 2, 0);
INSERT INTO cache_versions (shop_id,counter_id,value) VALUES(3, 3, 0);
INSERT INTO cache_versions (shop_id,counter_id,value) VALUES(3, 4, 0);
INSERT INTO cache_versions (shop_id,counter_id,value) VALUES(3, 5, 0);
INSERT INTO cache_versions (shop_id,counter_id,value) VALUES(3, 6, 0);
INSERT INTO cache_versions (shop_id,counter_id,value) VALUES(3, 7, 0);
INSERT INTO cache_versions (shop_id,counter_id,value) VALUES(3, 8, 0);
INSERT INTO cache_versions (shop_id,counter_id,value) VALUES(3, 9, 0);
INSERT INTO cache_versions (shop_id,counter_id,value) VALUES(3, 10, 0);
