CREATE TABLE parent_info (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    name VARCHAR(255),
    street_address VARCHAR(255),
    city_address VARCHAR(255),
    state_address VARCHAR(50),
    zip_address VARCHAR(10),
    home_telephone_number VARCHAR(20),
    home_cellphone_number VARCHAR(20),
    business_name VARCHAR(255),
    work_hours_from VARCHAR(50),
    work_hours_to VARCHAR(50),
    business_telephone_number VARCHAR(20),
    business_street_address VARCHAR(255),
    business_city_address VARCHAR(100),
    business_state_address VARCHAR(50),
    business_zip_address VARCHAR(12),
    business_cell_number VARCHAR(20),
    PRIMARY KEY (id)
);




------------ CREATE ------------

DELIMITER //

CREATE PROCEDURE spCreateParentInfo (
    IN p_email VARCHAR(255),
    IN p_name VARCHAR(255),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(255),
    IN p_state_address VARCHAR(50),
    IN p_zip_address VARCHAR(10),
    IN p_home_telephone_number VARCHAR(20),
    IN p_home_cellphone_number VARCHAR(20),
    IN p_business_name VARCHAR(255),
    IN p_work_hours_from VARCHAR(50),
    IN p_work_hours_to VARCHAR(50),
    IN p_business_telephone_number VARCHAR(20),
    IN p_business_street_address VARCHAR(255),
    IN p_business_city_address VARCHAR(100),
    IN p_business_state_address VARCHAR(50),
    IN p_business_zip_address VARCHAR(12),
    IN p_business_cell_number VARCHAR(20)
)
BEGIN
    INSERT INTO parent_info (
        email, name, street_address, city_address, state_address, zip_address, 
        home_telephone_number, home_cellphone_number, business_name, 
        work_hours_from, work_hours_to, business_telephone_number, 
        business_street_address, business_city_address, business_state_address, 
        business_zip_address, business_cell_number
    ) VALUES (
        p_email, p_name, p_street_address, p_city_address, p_state_address, p_zip_address, 
        p_home_telephone_number, p_home_cellphone_number, p_business_name, 
        p_work_hours_from, p_work_hours_to, p_business_telephone_number, 
        p_business_street_address, p_business_city_address, p_business_state_address, 
        p_business_zip_address, p_business_cell_number
    );
END //

DELIMITER ;

------------ READ ------------


DELIMITER //

CREATE PROCEDURE spGetParentInfo (
    IN p_id INT
)
BEGIN
    SELECT * FROM parent_info WHERE id = p_id;
END //

DELIMITER ;




------------ UPDATE ------------


DELIMITER //

CREATE PROCEDURE spUpdateParentInfo (
    IN p_id INT,
    IN p_email VARCHAR(255),
    IN p_name VARCHAR(255),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(255),
    IN p_state_address VARCHAR(50),
    IN p_zip_address VARCHAR(10),
    IN p_home_telephone_number VARCHAR(20),
    IN p_home_cellphone_number VARCHAR(20),
    IN p_business_name VARCHAR(255),
    IN p_work_hours_from VARCHAR(50),
    IN p_work_hours_to VARCHAR(50),
    IN p_business_telephone_number VARCHAR(20),
    IN p_business_street_address VARCHAR(255),
    IN p_business_city_address VARCHAR(100),
    IN p_business_state_address VARCHAR(50),
    IN p_business_zip_address VARCHAR(12),
    IN p_business_cell_number VARCHAR(20)
)
BEGIN
    UPDATE parent_info
    SET
        email = p_email,
        name = p_name,
        street_address = p_street_address,
        city_address = p_city_address,
        state_address = p_state_address,
        zip_address = p_zip_address,
        home_telephone_number = p_home_telephone_number,
        home_cellphone_number = p_home_cellphone_number,
        business_name = p_business_name,
        work_hours_from = p_work_hours_from,
        work_hours_to = p_work_hours_to,
        business_telephone_number = p_business_telephone_number,
        business_street_address = p_business_street_address,
        business_city_address = p_business_city_address,
        business_state_address = p_business_state_address,
        business_zip_address = p_business_zip_address,
        business_cell_number = p_business_cell_number
    WHERE id = p_id;
END //

DELIMITER ;




------------ DELETE ------------


DELIMITER //

CREATE PROCEDURE spDeleteParentInfo (
    IN p_id INT
)
BEGIN
    DELETE FROM parent_info WHERE id = p_id;
END //

DELIMITER ;