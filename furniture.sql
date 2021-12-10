USE furniture;

INSERT INTO locations
	VALUES (DEFAULT, "living room");
    SET @livingroom = last_insert_id();
INSERT INTO locations
	VALUES (DEFAULT, "dining room");
    SET @diningroom = last_insert_id();
INSERT INTO locations
	VALUES (DEFAULT, "sun room");
    SET @sunroom = last_insert_id();
INSERT INTO locations
	VALUES (DEFAULT, "office");
    SET @office = last_insert_id();

    
INSERT INTO furniture_items VALUES
	(DEFAULT, "large couch", "Three-cushioned leather couch", @livingroom);
    SET @largecouch = last_insert_id();
INSERT INTO furniture_items VALUES
	(DEFAULT, "small couch", "Two-cushioned leather couch", @livingroom);
    SET @smallcouch = last_insert_id();
INSERT INTO furniture_items VALUES
	(DEFAULT, "armchair", "Leather armchair", @livingroom);
    SET @armchair = last_insert_id();
INSERT INTO furniture_items VALUES
	(DEFAULT, "coffee table", NULL, @livingroom);
    SET @coffeetable = last_insert_id();
INSERT INTO furniture_items VALUES
	(DEFAULT, "dining table", "Seats about six people", @diningroom);
    SET @diningtable = last_insert_id();
INSERT INTO furniture_items VALUES
	(DEFAULT, "china cabinet", NULL, @diningroom);
    SET @chinacabinet = last_insert_id();
INSERT INTO furniture_items VALUES
	(DEFAULT, "desk", NULL, @sunroom);
    SET @desk = last_insert_id();
INSERT INTO furniture_items VALUES
	(DEFAULT, "standing desk", NULL, @office);
    SET @standingdesk = last_insert_id();

INSERT INTO accessories VALUES
	(DEFAULT, "red pillow 1");
    SET @redpillow1 = last_insert_id();
INSERT INTO accessories VALUES
	(DEFAULT, "red pillow 2");
    SET @redpillow2 = last_insert_id();
INSERT INTO accessories VALUES
	(DEFAULT, "red pillow 3");
    SET @redpillow3 = last_insert_id();
INSERT INTO accessories VALUES
	(DEFAULT, "white pillow");
    SET @whitepillow = last_insert_id();
INSERT INTO accessories VALUES
	(DEFAULT, "fruit bowl");
    SET @fruitbowl = last_insert_id();
INSERT INTO accessories VALUES
	(DEFAULT, "blanket");
    SET @blanket = last_insert_id();
    
INSERT INTO accessories_has_furniture_items VALUES
	(@redpillow1, @largecouch),
    (@redpillow2, @largecouch),
    (@whitepillow, @largecouch),
    (@redpillow3, @smallcouch),
    (@blanket, @armchair),
    (@fruitbowl, @diningtable);

INSERT INTO materials VALUES
	(DEFAULT, "wood");
    SET @wood = last_insert_id();
INSERT INTO materials VALUES
	(DEFAULT, "leather");
    SET @leather = last_insert_id();
INSERT INTO materials VALUES
	(DEFAULT, "metal");
    SET @metal = last_insert_id();
INSERT INTO materials VALUES
	(DEFAULT, "plastic");
    SET @plastic = last_insert_id();
INSERT INTO materials VALUES
	(DEFAULT, "glass");
    SET @glass = last_insert_id();
    
INSERT INTO materials_has_furniture_items VALUES
	(@leather, @largecouch),
    (@wood, @largecouch),
    (@leather, @smallcouch),
    (@wood, @smallcouch),
	(@leather, @armchair),
    (@wood, @armchair),
    (@plastic, @standingdesk),
    (@metal, @standingdesk),
    (@wood, @diningtable),
    (@wood, @desk),
    (@wood, @chinacabinet),
    (@glass, @chinacabinet),
    (@metal, @chinacabinet),
    (@wood, @coffeetable);

INSERT INTO colors VALUES
	(DEFAULT, "gray");
    SET @gray = last_insert_id();
INSERT INTO colors VALUES
	(DEFAULT, "black");
    SET @black = last_insert_id();
INSERT INTO colors VALUES
	(DEFAULT, "silver");
    SET @silver = last_insert_id();
INSERT INTO colors VALUES
	(DEFAULT, "brown");
    SET @brown = last_insert_id();

INSERT INTO colors_has_furniture_items VALUES
	(@gray, @largecouch),
    (@brown, @largecouch),
    (@gray, @smallcouch),
    (@brown, @smallcouch),
	(@gray, @armchair),
    (@brown, @armchair),
    (@black, @standingdesk),
    (@silver, @standingdesk),
    (@brown, @diningtable),
    (@brown, @desk),
    (@brown, @chinacabinet),
    (@brown, @coffeetable);