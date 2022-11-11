/*******************************************************************
* CREATE table for storing stocks exchanges data
********************************************************************/
CREATE TABLE mst_stock_exchanges
(

	exchange_id		INT AUTO_INCREMENT PRIMARY KEY,
	exchange_name	VARCHAR(200),
	exchange_code	VARCHAR(100),
	#exchange_country	VARCHAR(50) -- Can add in future versions
	created_date	DATETIME DEFAULT CURRENT_TIMESTAMP,
	modified_date	DATETIME ON UPDATE CURRENT_TIMESTAMP
);

/*******************************************************************
* CREATE table for storing list of stocks and related data
* from any stock exchange
*
* Adding required foreign keys
* 1. exchange_id foreign key to mst_stock_exchanges table
********************************************************************/

CREATE TABLE mst_stocks
(
	stock_id			INT AUTO_INCREMENT PRIMARY KEY,
	company_name	VARCHAR(200),
	stock_symbol	VARCHAR(100),
	company_description 	TEXT,
	exchange_id				INT,
	created_date			DATETIME DEFAULT CURRENT_TIMESTAMP,
	modified_date			DATETIME ON UPDATE CURRENT_TIMESTAMP
);


ALTER TABLE mst_stocks
ADD CONSTRAINT FK_stocks_exchange_id
FOREIGN KEY (exchange_id) REFERENCES mst_stock_exchanges(exchange_id);

/*******************************************************************
* CREATE table for storing list of sectors and related data
********************************************************************/

CREATE TABLE mst_stock_sectors
(
	sector_id		INT AUTO_INCREMENT PRIMARY KEY,
	sector_name		VARCHAR(500),
	`description`	TEXT,
	created_date	DATETIME DEFAULT CURRENT_TIMESTAMP,
	modified_date	DATETIME ON UPDATE CURRENT_TIMESTAMP
);


/*******************************************************************
* CREATE table for storing list of industries and related data
********************************************************************/
CREATE TABLE mst_stock_indutry
(
	industry_id		INT AUTO_INCREMENT PRIMARY KEY,
	industry_name		VARCHAR(500),
	`description`	TEXT,
	created_date	DATETIME DEFAULT CURRENT_TIMESTAMP,
	modified_date	DATETIME ON UPDATE CURRENT_TIMESTAMP
);


/*******************************************************************
* CREATE table for mapping the stocks to their respective sectors
*
* Adding required foreign keys
* 1. stock_id foreign key to mst_stocks table
* 2. sector_id foreign key to mst_stock_sectors table
********************************************************************/

CREATE TABLE map_stock_sectors
(
	stock_id		INT,
	sector_id	INT,
	created_date	DATETIME DEFAULT CURRENT_TIMESTAMP,
	modified_date	DATETIME ON UPDATE CURRENT_TIMESTAMP	
);

ALTER TABLE map_stock_sectors
ADD CONSTRAINT FK_map_sectors_stock_id
FOREIGN KEY (stock_id) REFERENCES mst_stocks(stock_id);

ALTER TABLE map_stock_sectors
ADD CONSTRAINT FK_map_sectors_sector_id
FOREIGN KEY (sector_id) REFERENCES mst_stock_sectors(sector_id);


/*******************************************************************
* CREATE table for mapping the stocks to their respective industries
*
* Adding required foreign keys
* 1. stock_id foreign key to mst_stocks table
* 2. industry_id foreign key to mst_stock_indutry table
********************************************************************/

CREATE TABLE map_stock_industry
(
	stock_id		INT,
	industry_id	INT,
	created_date	DATETIME DEFAULT CURRENT_TIMESTAMP,
	modified_date	DATETIME ON UPDATE CURRENT_TIMESTAMP	
);

ALTER TABLE map_stock_industry
ADD CONSTRAINT FK_map_industry_stock_id
FOREIGN KEY (stock_id) REFERENCES mst_stocks(stock_id);

ALTER TABLE map_stock_industry
ADD CONSTRAINT FK_map_industry_industry_id
FOREIGN KEY (industry_id) REFERENCES mst_stock_indutry(industry_id);


/*******************************************************************
* CREATE table for storing daily OHLCV data of the stocks
*
* Adding required foreign keys
* 1. stock_id foreign key to mst_stocks table
********************************************************************/

CREATE TABLE trn_stocks_daily_data
(
	stock_id			INT,
	`date`			DATE,
	high				DECIMAL(20,6),
	low				DECIMAL(20,6),
	`open`			DECIMAL(20,6),
	`close`			DECIMAL(20,6),
	adjusted_close	DECIMAL(20,6),
	volume			BIGINT,
	created_date	DATETIME DEFAULT CURRENT_TIMESTAMP,
	modified_date	DATETIME ON UPDATE CURRENT_TIMESTAMP
);

ALTER TABLE trn_stocks_daily_data
ADD CONSTRAINT FK_stock_daily_data_stock_id
FOREIGN KEY (stock_id) REFERENCES mst_stocks(stock_id);


/*******************************************************************
* CREATE table for storing daily bulk deals of different stocks
*
* Adding required foreign keys
* 1. stock_id foreign key to mst_stocks table
********************************************************************/

CREATE TABLE trn_stocks_bulk_deals
(
	stock_id		INT,
	`date`		DATE,
	deal_type	VARCHAR(200),
	buy_sell		VARCHAR(200),
	buy_sell_amount	DECIMAL(20,6),
	buy_sell_quantity	BIGINT,
	created_date	DATETIME DEFAULT CURRENT_TIMESTAMP,
	modified_date	DATETIME ON UPDATE CURRENT_TIMESTAMP
);

ALTER TABLE trn_stocks_bulk_deals
ADD CONSTRAINT FK_stock_bulk_deals_stock_id
FOREIGN KEY (stock_id) REFERENCES mst_stocks(stock_id);


/*******************************************************************
* CREATE table for storing daily annoucements of different stocks
*
* Adding required foreign keys
* 1. stock_id foreign key to mst_stocks table
********************************************************************/

CREATE TABLE trn_stocks_announcements
(
	stock_id				INT,
	`date`				DATE,
	announcement_type	VARCHAR(200),
	announcement		TEXT,
	file_url				VARCHAR(3000),
	created_date	DATETIME DEFAULT CURRENT_TIMESTAMP,
	modified_date	DATETIME ON UPDATE CURRENT_TIMESTAMP
);

ALTER TABLE trn_stocks_announcements
ADD CONSTRAINT FK_stock_announcements_stock_id
FOREIGN KEY (stock_id) REFERENCES mst_stocks(stock_id);

