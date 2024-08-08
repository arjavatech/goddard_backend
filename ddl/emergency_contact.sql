CREATE TABLE emergency_contact (
    emergency_id INT NOT NULL,
    child_id INT NOT NULL,
    PRIMARY KEY (emergency_id, child_id),
    FOREIGN KEY (emergency_id) REFERENCES emergency_details(emergency_id),
    FOREIGN KEY (child_id) REFERENCES child_info(child_id)
);




------------ CREATE ------------


DELIMITER //

CREATE PROCEDURE spCreateEmergencyContact (
    IN p_emergency_id INT,
    IN p_child_id INT
)
BEGIN
    INSERT INTO emergency_contact (emergency_id, child_id)
    VALUES (p_emergency_id, p_child_id);
END //
DELIMITER ;





------------ READ ------------

DELIMITER //

CREATE PROCEDURE spGetEmergencyContact (
    IN p_emergency_id INT,
    IN p_child_id INT
)
BEGIN
    SELECT * FROM emergency_contact
    WHERE emergency_id = p_emergency_id AND child_id = p_child_id;
END //

DELIMITER ;



------------ READ ALL ------------

DELIMITER //

CREATE PROCEDURE spGetAllEmergencyContact ()
BEGIN
    SELECT * FROM emergency_contact;
END //

DELIMITER ;

------------ UPDATE ------------



DELIMITER //

CREATE PROCEDURE spUpdateEmergencyContact (
    IN p_old_emergency_id INT,
    IN p_child_id INT,
    IN p_new_emergency_id INT
)
BEGIN
    UPDATE emergency_contact
    SET emergency_id = p_new_emergency_id
    WHERE emergency_id = p_old_emergency_id AND child_id = p_child_id;
END //

DELIMITER ;





------------ DELETE ------------

DELIMITER //

CREATE PROCEDURE spDeleteEmergencyContact (
    IN p_emergency_id INT,
    IN p_child_id INT
)
BEGIN
    DELETE FROM emergency_contact
    WHERE emergency_id = p_emergency_id AND child_id = p_child_id;
END //

DELIMITER ;

