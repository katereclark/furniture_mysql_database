USE furniture;

-- Drop procedures if they already exist.
DROP PROCEDURE IF EXISTS sp_insert_furniture_item;
DROP PROCEDURE IF EXISTS sp_update_furniture_item;
DROP PROCEDURE IF EXISTS sp_delete_furniture_item;

-- Create procedure that inserts three sofas into certain rooms.
DELIMITER //
CREATE PROCEDURE sp_insert_furniture_item ()
BEGIN
	DECLARE sql_error TINYINT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = TRUE;
        
	START TRANSACTION;
		INSERT INTO furniture_items VALUES
			(DEFAULT, "large sofa", "Three-cushioned cloth sofa", (SELECT id FROM locations WHERE location LIKE "%living%"));
		INSERT INTO furniture_items VALUES
			(DEFAULT, "small sofa", "Two-cushioned cloth sofa", (SELECT id FROM locations WHERE location LIKE "%living%"));
		INSERT INTO furniture_items VALUES
			(DEFAULT, "old sofa", "Old cloth sofa", (SELECT id FROM locations WHERE location LIKE "%sun%"));

        IF sql_error = FALSE THEN
			COMMIT;
            SELECT 'Furniture item successfully inserted';
		ELSE
			ROLLBACK;
            SELECT 'ERROR: Furniture item cannot be inserted';
		END IF;
END //

-- Update all armchair descriptions.
DELIMITER //
CREATE PROCEDURE sp_update_furniture_item ()
BEGIN
	DECLARE sql_error TINYINT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = TRUE;
        
	START TRANSACTION;
		UPDATE furniture_items SET description = "Down-filled leather armchair"
		WHERE name LIKE "%armchair%";
        
        IF sql_error = FALSE THEN
			COMMIT;
            SELECT 'Furniture item successfully updated';
		ELSE
			ROLLBACK;
            SELECT 'ERROR: Furniture item cannot be updated';
		END IF;
END //

-- Delete all sofas in the database.
DELIMITER //
CREATE PROCEDURE sp_delete_furniture_item (
	IN furniture_name VARCHAR(45)
)
BEGIN
	DECLARE sql_error TINYINT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = TRUE;
        
	START TRANSACTION;
		CREATE TEMPORARY TABLE temp_furniture AS
        SELECT id FROM furniture_items 
		WHERE name LIKE CONCAT("%", @furniture_name, "%");
    
		DELETE FROM accessories_has_furniture_items 
        WHERE furniture_items_id IN (SELECT id FROM furniture_items 
								WHERE name LIKE CONCAT("%", furniture_name, "%"));
		
		DELETE FROM colors_has_furniture_items 
        WHERE furniture_items_id IN (SELECT id FROM furniture_items 
								WHERE name LIKE CONCAT("%", furniture_name, "%"));
        
		DELETE FROM materials_has_furniture_items 
        WHERE furniture_items_id IN (SELECT id FROM furniture_items 
								WHERE name LIKE CONCAT("%", furniture_name, "%"));
                                
		DELETE FROM furniture_items 
        WHERE id IN (SELECT id FROM temp_furniture);
		
        DROP TEMPORARY TABLE IF EXISTS temp_furniture;
        
        IF sql_error = FALSE THEN
			COMMIT;
            SELECT 'Furniture item successfully deleted';
		ELSE
			ROLLBACK;
            SELECT 'ERROR: Furniture item cannot be deleted';
		END IF;
END //

-- Execute all of the procedures.
SET @furniture_name = "sofa";
CALL sp_insert_furniture_item();
CALL sp_update_furniture_item();
CALL sp_delete_furniture_item(@furniture_name);

-- Select the name of each furniture item that has an accessory and show the accessory name.
SELECT fi.name, a.accessory FROM accessories a
JOIN accessories_has_furniture_items ahfi ON a.id = ahfi.accessories_id
JOIN furniture_items fi ON ahfi.furniture_items_id = fi.id
ORDER BY fi.name;

-- Show each color and how many times each color is used.
SELECT c.color, COUNT(chfi.colors_id) "instances" FROM colors c
JOIN colors_has_furniture_items chfi ON c.id = chfi.colors_id
GROUP BY c.color
ORDER BY "Number of Colors";

-- Select each furniture item and list its colors and materials.
SELECT DISTINCT fi.name, c.color, m.material FROM colors c
JOIN colors_has_furniture_items chfi ON c.id = chfi.colors_id
JOIN furniture_items fi ON chfi.furniture_items_id = fi.id
JOIN materials_has_furniture_items mhfi ON fi.id = mhfi.materials_id
JOIN materials m ON m.id = mhfi.materials_id
ORDER BY fi.name;

-- Select each location and count how many furniture items are in each location.
SELECT l.location, COUNT(fi.id) "Furniture Items per Room" FROM locations l
JOIN furniture_items fi ON fi.locations_id = l.id
GROUP BY l.location
ORDER BY l.location;

-- Show the name of each location that has an accessory and count how many accessories are in each room.
SELECT l.location, COUNT(a.id) "Accessories per Room" FROM locations l
JOIN furniture_items fi ON fi.locations_id = l.id
JOIN accessories_has_furniture_items ahfi ON fi.id = ahfi.furniture_items_id
JOIN accessories a ON ahfi.accessories_id = a.id
GROUP BY l.location
ORDER BY l.location;