
CREATE TABLE authorization_form (
    form_id INT NOT NULL AUTO_INCREMENT,
    child_id INT NOT NULL,
    bank_routing VARCHAR(255),
    bank_account VARCHAR(255),
    driver_license VARCHAR(255),
    state VARCHAR(255),
    myself VARCHAR(255),
    parent_sign VARCHAR(255),
    parent_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    admin_sign VARCHAR(255),
    admin_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (form_id),
    FOREIGN KEY (child_id) REFERENCES admission_form(child_id)  -- Assumes child_info table has child_id
);


-------------------- STORED PROCEDURE--------------------------- 

------------------CREATE---------------- 

DELIMITER //

CREATE PROCEDURE spCreateAuthorizationForm(
    IN p_childId INT,
    IN p_bankRouting VARCHAR(255),
    IN p_bankAccount VARCHAR(255),
    IN p_driverLicense VARCHAR(255),
    IN p_state VARCHAR(255),
    IN p_myself VARCHAR(255),
    IN p_parentSign VARCHAR(255),
    IN p_adminSign VARCHAR(255)
)
BEGIN
    INSERT INTO authorization_form (
        child_id, bank_routing, bank_account, driver_license, state, 
        myself, parent_sign, admin_sign, is_active
    ) VALUES (
        p_childId, p_bankRouting, p_bankAccount, p_driverLicense, p_state, 
        p_myself, p_parentSign, p_adminSign, TRUE
    );
END //

DELIMITER ;




-- ------------------ GET ---------------- 

DELIMITER //

CREATE PROCEDURE spGetAuthorizationForm(
    IN p_formId INT
)
BEGIN
    SELECT * FROM authorization_form
    WHERE form_id = p_formId AND is_active = TRUE;
END //

DELIMITER ;





-- ------------------ GET ALL ---------------- 

DELIMITER //

CREATE PROCEDURE spGetAllAuthorizationForms()
BEGIN
    SELECT * FROM authorization_form
    WHERE is_active = TRUE;
END //

DELIMITER ;



-- ------------------ UPDATE ---------------- 

DELIMITER //

CREATE PROCEDURE spUpdateAuthorizationForm(
    IN p_formId INT,
    IN p_childId INT,
    IN p_bankRouting VARCHAR(255),
    IN p_bankAccount VARCHAR(255),
    IN p_driverLicense VARCHAR(255),
    IN p_state VARCHAR(255),
    IN p_myself VARCHAR(255),
    IN p_parentSign VARCHAR(255),
    IN p_adminSign VARCHAR(255)
)
BEGIN
    UPDATE authorization_form
    SET 
        form_id = p_formId,
        child_id = p_childId,
        bank_routing = p_bankRouting,
        bank_account = p_bankAccount,
        driver_license = p_driverLicense,
        state = p_state,
        myself = p_myself,
        parent_sign = p_parentSign,
        admin_sign = p_adminSign
    WHERE 
        form_id = p_formId AND is_active = TRUE;
END //

DELIMITER ;


-- ------------------ DELETE ---------------- 


DELIMITER //

CREATE PROCEDURE spDeleteAuthorizationForm(
    IN p_formId INT
)
BEGIN
    UPDATE authorization_form
    SET is_active = FALSE
    WHERE form_id = p_formId;
END //

DELIMITER ;

