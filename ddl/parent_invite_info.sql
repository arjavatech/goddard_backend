
CREATE TABLE parent_invite_info (
    email VARCHAR(255) NOT NULL,
    invite_id VARCHAR(255),
    parent_name VARCHAR(255),
    child_full_name VARCHAR(255),
    invite_status VARCHAR(100),
    signed_up_email VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (email)
);



-------------------- STORED PROCEDURE-------------------------

-- ------------------CREATE---------------- 


DELIMITER //

CREATE PROCEDURE spCreateParentInvite(
    IN p_email VARCHAR(255),
    IN p_invite_id VARCHAR(255),
    IN p_parent_name VARCHAR(255),
    IN p_child_full_name VARCHAR(255),
    IN p_invite_status VARCHAR(100),
    IN p_signed_up_email VARCHAR(255)
)
BEGIN
    INSERT INTO parent_invite_info (
        email, 
        invite_id, 
        parent_name, 
        child_full_name, 
        invite_status, 
        signed_up_email, 
        is_active
    )
    VALUES (
        p_email, 
        p_invite_id, 
        p_parent_name, 
        p_child_full_name, 
        p_invite_status, 
        p_signed_up_email, 
        TRUE
    );
END //

DELIMITER ;






-- ------------- GET -----------------


DELIMITER //

CREATE PROCEDURE spGetParentInvite(
    IN p_email VARCHAR(255)
)
BEGIN
    SELECT * FROM parent_invite_info
    WHERE email = p_email AND is_active = TRUE;
END //

DELIMITER ;






-- ------------- GET ALL ----------------


DELIMITER //

CREATE PROCEDURE spGetAllParentInvites()
BEGIN
    SELECT * FROM parent_invite_info
    WHERE is_active = TRUE;
END //

DELIMITER ;




 

-- ------------- UPDATE ----------------


DELIMITER //

CREATE PROCEDURE spUpdateParentInvite(
    IN p_email VARCHAR(255),
    IN p_invite_id VARCHAR(255),
    IN p_parent_name VARCHAR(255),
    IN p_child_full_name VARCHAR(255),
    IN p_invite_status VARCHAR(100),
    IN p_signed_up_email VARCHAR(255)
)
BEGIN
    UPDATE parent_invite_info
    SET 
        invite_id = p_invite_id,
        parent_name = p_parent_name,
        child_full_name = p_child_full_name,
        invite_status = p_invite_status,
        signed_up_email = p_signed_up_email
    WHERE 
        email = p_email AND is_active = TRUE;
END //

DELIMITER ;





-- ------------- DELETE ----------------


DELIMITER //

CREATE PROCEDURE spDeleteParentInvite(
    IN p_email VARCHAR(255)
)
BEGIN
    UPDATE parent_invite_info
    SET is_active = FALSE
    WHERE email = p_email;
END //

DELIMITER ;
