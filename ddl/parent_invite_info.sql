CREATE TABLE parent_invite_info (
    parent_email VARCHAR(255) NOT NULL,
    invite_id INT NOT NULL AUTO_INCREMENT,
    admin BOOLEAN,
    parent_name VARCHAR(255),
    child_full_name VARCHAR(255),
    invite_status VARCHAR(50),
    password VARCHAR(255),
    temp_password VARCHAR(255),
    PRIMARY KEY (invite_id),
    FOREIGN KEY (parent_email) REFERENCES parent_info(parent_email)
);
----------Store Procedure-----------

----------Insert-----------

DELIMITER //

CREATE PROCEDURE spCreateParentInviteInfo (
    IN p_parent_email VARCHAR(255),
    IN p_admin BOOLEAN,
    IN p_parent_name VARCHAR(255),
    IN p_child_full_name VARCHAR(255),
    IN p_invite_status VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_temp_password VARCHAR(255)
)
BEGIN
    INSERT INTO parent_invite_info (parent_email, admin, parent_name, child_full_name, invite_status, password, temp_password)
    VALUES (p_parent_email, p_admin, p_parent_name, p_child_full_name, p_invite_status, p_password, p_temp_password);
END //

DELIMITER ;

----------Update-----------

DELIMITER //

CREATE PROCEDURE spUpdateParentInviteInfo (
    IN p_invite_id INT,
    IN p_parent_email VARCHAR(255),
    IN p_admin BOOLEAN,
    IN p_parent_name VARCHAR(255),
    IN p_child_full_name VARCHAR(255),
    IN p_invite_status VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_temp_password VARCHAR(255)
)
BEGIN
    UPDATE parent_invite_info
    SET 
        parent_email = p_parent_email,
        admin = p_admin,
        parent_name = p_parent_name,
        child_full_name = p_child_full_name,
        invite_status = p_invite_status,
        password = p_password,
        temp_password = p_temp_password
    WHERE invite_id = p_invite_id;
END //

DELIMITER ;

----------Delete-----------

DELIMITER //

CREATE PROCEDURE spDeleteParentInviteInfo (
    IN p_invite_id INT
)
BEGIN
    DELETE FROM parent_invite_info WHERE invite_id = p_invite_id;
END //

DELIMITER ;

----------Get-----------
DELIMITER //

CREATE PROCEDURE spGetParentInviteInfo (
    IN p_invite_id INT
)
BEGIN
    SELECT * FROM parent_invite_info
    WHERE invite_id = p_invite_id;
END //

DELIMITER ;