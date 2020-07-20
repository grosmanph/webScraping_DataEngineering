CREATE DATABASE IF NOT EXISTS book_club_web_data;

USE book_club_web_data;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

/*!50503 set default_storage_engine = InnoDB */;
/*!50503 select CONCAT('storage engine: ', @@default_storage_engine) as INFO */;  




#DROP TABLE IF EXISTS books;
#DROP TABLE IF EXISTS titles;
#DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS scraped;

CREATE TABLE IF NOT EXISTS categories(
	cat_id		SMALLINT NOT NULL AUTO_INCREMENT,
    cat_name	VARCHAR(50) NOT NULL,
    
PRIMARY KEY (cat_id),
UNIQUE KEY cat_name (cat_name)
);

CREATE TABLE IF NOT EXISTS titles(
	title_id		INT NOT NULL AUTO_INCREMENT,
    title			VARCHAR(255) NOT NULL,
    cat_id			SMALLINT NOT NULL,
    stars			TINYINT,
	no_in_stock		SMALLINT NOT NULL,
    
PRIMARY KEY (title_id),
UNIQUE KEY title (title),
CONSTRAINT cat_id_ibfk_1 FOREIGN KEY (cat_id) REFERENCES categories (cat_id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS books(
	book_id 		INT NOT NULL AUTO_INCREMENT,
    price			DECIMAL(5,2),
	title_id		INT NOT NULL,
    
PRIMARY KEY (book_id),
CONSTRAINT title_id_ibfk_1 FOREIGN KEY (title_id) REFERENCES titles (title_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS scraped;

CREATE TABLE IF NOT EXISTS scraped(
	title		VARCHAR(255),
    category	VARCHAR(50),
    stars		TINYINT NULL,
    price		DECIMAL(5,2),
    is_in_stock	ENUM ('Yes','No')
);

COMMIT;