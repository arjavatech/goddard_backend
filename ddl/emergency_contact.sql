CREATE TABLE emergency_contact (
    emergency_id INT NOT NULL,
    child_id INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (emergency_id, child_id),
    FOREIGN KEY (emergency_id) REFERENCES emergency_details(emergency_id),
    FOREIGN KEY (child_id) REFERENCES admission_form(child_id)
);


-------------------- STORED PROCEDURE-------------------------

--- ------------------CREATE---------------- 
DELIMITER //

CREATE PROCEDURE spCreateEmergencyContact(
    IN p_emergencyId INT,
    IN p_childId INT
)
BEGIN
    INSERT INTO emergency_contact (emergency_id, child_id, is_active)
    VALUES (p_emergencyId, p_childId, TRUE);
END //

DELIMITER ;


-- ------------- GET -----------------
DELIMITER //

CREATE PROCEDURE spGetEmergencyContact(
    IN p_emergencyId INT,
    IN p_childId INT
)
BEGIN
    SELECT * FROM emergency_contact
    WHERE 
        emergency_id = p_emergencyId 
        AND child_id = p_childId 
        AND is_active = TRUE;
END //

DELIMITER ;


-- ------------- GET ALL ----------------
DELIMITER //

CREATE PROCEDURE spGetAllEmergencyContact()
BEGIN
    SELECT * FROM emergency_contact
    WHERE 
        is_active = TRUE;
END //

DELIMITER ;


-- ------------- UPDATE ----------------
DELIMITER //

CREATE PROCEDURE spUpdateEmergencyContact(
    IN p_old_emergency_id INT,
    IN p_old_child_id INT,
    IN p_new_emergency_id INT,
    IN p_new_child_id INT
)
BEGIN
    UPDATE emergency_contact
    SET 
        emergency_id = p_new_emergency_id,
        child_id = p_new_child_id
    WHERE 
        emergency_id = p_old_emergency_id 
        AND child_id = p_old_child_id 
        AND is_active = TRUE;
END //

DELIMITER ;


-- ------------- DELETE ----------------
DELIMITER //

CREATE PROCEDURE spDeleteEmergencyContact(
    IN p_emergencyId INT,
    IN p_childId INT
)
BEGIN
    UPDATE emergency_contact
    SET is_active = FALSE
    WHERE 
        emergency_id = p_emergencyId 
        AND child_id = p_childId;
END //

DELIMITER ;
