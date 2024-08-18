CREATE TABLE dentist (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    telephone_number VARCHAR(20),
    street_address VARCHAR(255),
    city_address VARCHAR(100),
    state_address VARCHAR(50),
    zip_address VARCHAR(12),
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id)
);
-------------------- STORED PROCEDURE-------------------------

-- ------------------CREATE---------------- 


DELIMITER //

CREATE PROCEDURE spCreateDentist(
    IN p_name VARCHAR(255),
    IN p_telephone_number VARCHAR(20),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(100),
    IN p_state_address VARCHAR(50),
    IN p_zip_address VARCHAR(12)
)
BEGIN
    INSERT INTO dentist (
        name, 
        telephone_number, 
        street_address, 
        city_address, 
        state_address, 
        zip_address, 
        is_active
    )
    VALUES (
        p_name, 
        p_telephone_number, 
        p_street_address, 
        p_city_address, 
        p_state_address, 
        p_zip_address, 
        TRUE
    );
END //

DELIMITER ;




-- ------------- GET -----------------


DELIMITER //

CREATE PROCEDURE spGetDentist(
    IN p_id INT
)
BEGIN
    SELECT * FROM dentist
    WHERE id = p_id AND is_active = TRUE;
END //

DELIMITER ;




-- ------------- GET ALL ----------------


 DELIMITER //

CREATE PROCEDURE spGetAllDentists()
BEGIN
    SELECT * FROM dentist
    WHERE is_active = TRUE;
END //

DELIMITER ;


 

-- ------------- UPDATE ----------------


DELIMITER //

CREATE PROCEDURE spUpdateDentist(
    IN p_id INT,
    IN p_name VARCHAR(255),
    IN p_telephone_number VARCHAR(20),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(100),
    IN p_state_address VARCHAR(50),
    IN p_zip_address VARCHAR(12)
)
BEGIN
    UPDATE dentist
    SET 
        name = p_name,
        telephone_number = p_telephone_number,
        street_address = p_street_address,
        city_address = p_city_address,
        state_address = p_state_address,
        zip_address = p_zip_address
    WHERE 
        id = p_id AND is_active = TRUE;
END //

DELIMITER ;



-- ------------- DELETE ----------------


DELIMITER //

CREATE PROCEDURE spDeleteDentist(
    IN p_id INT
)
BEGIN
    UPDATE dentist
    SET is_active = FALSE
    WHERE id = p_id;
END //

DELIMITER ;