CREATE TABLE emergency_details (
    emergency_id INT NOT NULL AUTO_INCREMENT,
    contact_name VARCHAR(255) NOT NULL,
    contact_relationship VARCHAR(255) NOT NULL,
    street_address VARCHAR(255) NOT NULL,
    city_address VARCHAR(255) NOT NULL,
    state_address VARCHAR(255) NOT NULL,
    zip_address VARCHAR(20) NOT NULL,
    contact_telephone_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (emergency_id)
);

 DELIMITER //

-- Procedure to insert a new emergency contact
CREATE PROCEDURE spCreateEmergencyContact(
    IN p_contact_name VARCHAR(255),
    IN p_contact_relationship VARCHAR(255),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(255),
    IN p_state_address VARCHAR(255),
    IN p_zip_address VARCHAR(20),
    IN p_contact_telephone_number VARCHAR(20)
)
BEGIN
    INSERT INTO emergency_details (
        contact_name, contact_relationship, street_address, city_address, state_address, zip_address, contact_telephone_number
    ) VALUES (
        p_contact_name, p_contact_relationship, p_street_address, p_city_address, p_state_address, p_zip_address, p_contact_telephone_number
    );
END //

DELIMITER ;


DELIMITER //

-- Procedure to update an existing emergency contact
CREATE PROCEDURE spUpdateEmergencyContact(
    IN p_emergency_id INT,
    IN p_contact_name VARCHAR(255),
    IN p_contact_relationship VARCHAR(255),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(255),
    IN p_state_address VARCHAR(255),
    IN p_zip_address VARCHAR(20),
    IN p_contact_telephone_number VARCHAR(20)
)
BEGIN
    UPDATE emergency_details
    SET 
        contact_name = p_contact_name,
        contact_relationship = p_contact_relationship,
        street_address = p_street_address,
        city_address = p_city_address,
        state_address = p_state_address,
        zip_address = p_zip_address,
        contact_telephone_number = p_contact_telephone_number
    WHERE 
        emergency_id = p_emergency_id;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE spDeleteEmergencyContact(
    IN p_emergency_id INT
)
BEGIN
    DELETE FROM emergency_details
    WHERE 
        emergency_id = p_emergency_id;
END //

DELIMITER ;