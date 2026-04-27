CREATE DATABASE IF NOT EXISTS `bench_complex`;
USE `bench_complex`;

CREATE TABLE IF NOT EXISTS `complex_types_bench` (
  `id`           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`         VARCHAR(255)    NOT NULL,
  `price`        DECIMAL(10,2)   NOT NULL,
  `created_at`   DATETIME        NOT NULL,
  `attributes`   JSON            DEFAULT NULL,   -- flat key/value object
  `tags`         JSON            DEFAULT NULL,   -- string array
  `measurements` JSON            DEFAULT NULL,   -- float array
  `metadata`     JSON            DEFAULT NULL,   -- nested object (dims, flags, …)
  `optional_json` JSON           DEFAULT NULL,   -- nullable JSON
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Populate 5 000 000 rows (runs in ~90 s on a modern laptop).
-- Uses a 10-level cross-join to avoid a stored procedure.
INSERT INTO complex_types_bench (name, price, created_at, attributes, tags, measurements, metadata, optional_json)
SELECT
  CONCAT(LPAD(HEX(FLOOR(RAND()*0xFFFFFF)), 6, '0'), '-', LPAD(HEX(FLOOR(RAND()*0xFFFFFF)), 6, '0')) AS name,
  ROUND(100 + RAND() * 2900, 2)                                                                        AS price,
  DATE_ADD('2018-01-01', INTERVAL FLOOR(RAND() * 2920) DAY)                                            AS created_at,

  JSON_OBJECT(
    'color',  ELT(1 + FLOOR(RAND()*5), 'red','blue','green','black','white'),
    'size',   ELT(1 + FLOOR(RAND()*5), 'XS','S','M','L','XL'),
    'origin', ELT(1 + FLOOR(RAND()*4), 'US','EU','AS','AU')
  ) AS attributes,

  JSON_ARRAY(
    ELT(1 + FLOOR(RAND()*4), 'sale','hot','clearance','limited'),
    ELT(1 + FLOOR(RAND()*4), 'sale','hot','clearance','limited'),
    ELT(1 + FLOOR(RAND()*4), 'sale','hot','clearance','limited')
  ) AS tags,

  JSON_ARRAY(
    ROUND(RAND()*100, 3),
    ROUND(RAND()*100, 3),
    ROUND(RAND()*100, 3),
    ROUND(RAND()*100, 3),
    ROUND(RAND()*100, 3)
  ) AS measurements,

  JSON_OBJECT(
    'sku',       CONCAT('SKU-', FLOOR(100000 + RAND()*900000)),
    'vendor_id', FLOOR(1000 + RAND()*9000),
    'warehouse', ELT(1 + FLOOR(RAND()*5), 'NYC','LAX','CHI','HOU','PHX'),
    'weight_kg', ROUND(0.1 + RAND()*50, 2),
    'score',     ROUND(1 + RAND()*4, 1),
    'reviews',   FLOOR(RAND()*5000),
    'reorder_pt',FLOOR(RAND()*1000),
    'last_audit',DATE_FORMAT(DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND()*730) DAY), '%Y-%m-%d'),
    'dims', JSON_OBJECT(
      'l', ROUND(5 + RAND()*100, 1),
      'w', ROUND(5 + RAND()*100, 1),
      'h', ROUND(5 + RAND()*100, 1)
    ),
    'flags', JSON_OBJECT(
      'fragile',  IF(RAND() > 0.5, TRUE, FALSE),
      'hazmat',   IF(RAND() > 0.8, TRUE, FALSE),
      'perishbl', IF(RAND() > 0.7, TRUE, FALSE)
    )
  ) AS metadata,

  IF(RAND() > 0.7,
    JSON_OBJECT('ts', UNIX_TIMESTAMP(), 'note', CONCAT('batch-', FLOOR(RAND()*10))),
    NULL
  ) AS optional_json

FROM
  (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
   UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) a,
  (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
   UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) b,
  (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
   UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) c,
  (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
   UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) d,
  (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
   UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) e
LIMIT 5000000;
