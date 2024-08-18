
CREATE TABLE signup_info (
    email_id VARCHAR(255) NOT NULL PRIMARY KEY,
    invite_id VARCHAR(255),
    password VARCHAR(255),
    admin BOOLEAN DEFAULT FALSE,
    temp_password BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE
);

-- ------------------ CREATE ----------------

DELIMITER //

CREATE PROCEDURE spCreateSignUpInfo(
    IN p_email_id VARCHAR(255),
    IN p_invite_id VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_admin BOOLEAN,
    IN p_temp_password BOOLEAN
)
BEGIN
    INSERT INTO signup_info (email_id, invite_id, password, admin, temp_password, is_active)
    VALUES (p_email_id, p_invite_id, p_password, p_admin, p_temp_password, TRUE);
END //

DELIMITER ;

-- ------------------ GET ----------------

DELIMITER //

CREATE PROCEDURE spGetSignUpInfo(
    IN p_email_id VARCHAR(255)
)
BEGIN
    SELECT * FROM signup_info
    WHERE email_id = p_email_id AND is_active = TRUE;
END //

DELIMITER ;

-- ------------------ GET ALL ----------------

DELIMITER //

CREATE PROCEDURE spGetAllSignUpInfo()
BEGIN
    SELECT * FROM signup_info
    WHERE is_active = TRUE;
END //

DELIMITER ;

-- ------------------ UPDATE ----------------

DELIMITER //

CREATE PROCEDURE spUpdateSignUpInfo(
    IN p_email_id VARCHAR(255),
    IN p_invite_id VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_admin BOOLEAN,
    IN p_temp_password BOOLEAN
)
BEGIN
    UPDATE signup_info
    SET 
        invite_id = p_invite_id,
        password = p_password,
        admin = p_admin,
        temp_password = p_temp_password
    WHERE 
        email_id = p_email_id AND is_active = TRUE;
END //

DELIMITER ;

-- ------------------ DELETE (Soft Delete) ----------------

DELIMITER //

CREATE PROCEDURE spDeleteSignUpInfo(
    IN p_email_id VARCHAR(255)
)
BEGIN
    UPDATE signup_info
    SET is_active = FALSE
    WHERE 
        email_id = p_email_id;
END //

DELIMITER ;