CREATE DATABASE goddardTest;
USE goddardTest;

CREATE TABLE care_provider (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    telephone_number VARCHAR(20) NOT NULL,
    hospital_affiliation VARCHAR(255),
    street_address VARCHAR(255),
    city_address VARCHAR(100),
    state_address VARCHAR(50),
    zip_address VARCHAR(12),
    PRIMARY KEY (id)
);

------------ STORED PROCEDURE ------------

------------ CREATE ------------
DELIMITER //

CREATE PROCEDURE ⁠spCreateCareProvider⁠(
    IN p_name VARCHAR(255),
    IN p_telephone_number VARCHAR(20),
    IN p_hospital_affiliation VARCHAR(255),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(100),
    IN p_state_address VARCHAR(50),
    IN p_zip_address VARCHAR(12)
)
BEGIN
    INSERT INTO care_provider (name, telephone_number, hospital_affiliation, street_address, city_address, state_address, zip_address)
    VALUES (p_name, p_telephone_number, p_hospital_affiliation, p_street_address, p_city_address, p_state_address, p_zip_address);
END //

DELIMITER ;


------------ READ ------------


DELIMITER //

CREATE PROCEDURE ⁠ spGetCareProvider ⁠(
    IN p_care_provider_id INT
)
BEGIN
    SELECT * FROM care_provider
    WHERE id = p_care_provider_id;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE ⁠ spGetAllCareProvider ⁠()
BEGIN
    SELECT * FROM care_provider;
END //

DELIMITER ;

------------ UPDATE ------------

DELIMITER //

CREATE PROCEDURE ⁠ spUpdateCareProvider⁠(
    IN p_care_provider_id INT,
    IN p_name VARCHAR(255),
    IN p_telephone_number VARCHAR(20),
    IN p_hospital_affiliation VARCHAR(255),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(100),
    IN p_state_address VARCHAR(50),
    IN p_zip_address VARCHAR(12)
)
BEGIN
    UPDATE care_provider
    SET name = p_name, telephone_number = p_telephone_number, hospital_affiliation = p_hospital_affiliation, street_address = p_street_address, city_address = p_city_address, state_address = p_state_address, zip_address = p_zip_address
    WHERE id = p_care_provider_id;
END //

DELIMITER ;

------------ DELETE ------------

DELIMITER //

CREATE PROCEDURE ⁠ spDeleteCareProvider ⁠(
    IN p_care_provider_id INT
)
BEGIN
    DELETE FROM care_provider
    WHERE id = p_care_provider_id;
END //

DELIMITER ;
