USE book_club_web_data;
--
### INSERT ---- INSERT CATEGORIES INTO TABLE categories ----- ###

INSERT INTO categories(cat_name)
SELECT DISTINCT category
	FROM
		scraped
ON DUPLICATE KEY UPDATE cat_name = cat_name;

##################################################################
--
--
### INSERT ---- INSERT TITLES INTO TABLE titles ----- ###

INSERT INTO titles(title,cat_id,stars,no_in_stock)
SELECT
	scr.title, cat.cat_id, scr.stars, COUNT(scr.title)
FROM
	scraped AS scr
		JOIN
	categories cat ON scr.category=cat.cat_name
GROUP BY scr.title
ON DUPLICATE KEY UPDATE title = title, cat_id = cat_id, stars=stars;

###########################################################
--
--
### TRIGGER ---- AFTER INSERT INTO TABLE books ----- ###

DROP TRIGGER IF EXISTS after_books_insert;

DELIMITER $$

CREATE TRIGGER after_books_insert
AFTER INSERT ON books
FOR EACH ROW
BEGIN 
	DECLARE v_no_stock SMALLINT;
	
    SELECT
		COUNT(title_id)
	INTO v_no_stock FROM
		books b
	WHERE
		b.title_id=NEW.title_id
	GROUP BY b.title_id;
					
	UPDATE
		titles t
	SET
		t.no_in_stock = v_no_stock
	WHERE
		t.title_id=NEW.title_id;
END $$

DELIMITER ;
#########################################################
--
--
### INSERT ---- INSERT BOOKS INTO TABLE books ----- ###

CREATE TABLE IF NOT EXISTS temp_titles(
	title_id		INT NOT NULL AUTO_INCREMENT,
    title			VARCHAR(255) NOT NULL,
PRIMARY KEY (title_id),
UNIQUE KEY title (title)
);

INSERT INTO temp_titles
SELECT
	title_id,
    title
FROM
	titles;
    
INSERT INTO books(price,title_id)
SELECT
	scr.price, t.title_id
FROM
	scraped AS scr
		JOIN
	temp_titles t ON scr.title=t.title;
    
DROP TABLE IF EXISTS temp_titles;

########################################################
--
--
### DROP ---- DROP TABLE scraped ---- ##################

DROP TABLE scraped;

COMMIT;
########################################################


