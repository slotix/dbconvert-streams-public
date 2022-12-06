CREATE database src;
CREATE schema private;
SET schema 'private';
CREATE TABLE IF NOT EXISTS private.products (
	id BIGINT NOT NULL,
	name VARCHAR(255) NOT NULL,
	price DECIMAL(12,2) NOT NULL,
	weight FLOAT NOT NULL,
	created TIMESTAMP NOT NULL,
	PRIMARY KEY (id)
)
