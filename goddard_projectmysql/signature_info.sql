CREATE TABLE signature_info (
    child_id INT,
    form_id INT,
    parent_sign VARCHAR(255),
    parent_date DATE,
    admin_sign VARCHAR(255),
    admin_date DATE,
    PRIMARY KEY (child_id, form_id),
    FOREIGN KEY (child_id) REFERENCES child_info(child_id),
    FOREIGN KEY (form_id) REFERENCES form_detail(form_id)
);





------------ CREATE ------------

DELIMITER //

CREATE PROCEDURE spCreateSignatureInfo (
    IN p_child_id INT,
    IN p_form_id INT,
    IN p_parent_sign VARCHAR(255),
    IN p_parent_date DATE,
    IN p_admin_sign VARCHAR(255),
    IN p_admin_date DATE
)
BEGIN
    INSERT INTO signature_info (child_id, form_id, parent_sign, parent_date, admin_sign, admin_date)
    VALUES (p_child_id, p_form_id, p_parent_sign, p_parent_date, p_admin_sign, p_admin_date);
END //

DELIMITER ;




------------ READ ------------

DELIMITER //

CREATE PROCEDURE spReadSignatureInfo (
    IN p_child_id INT,
    IN p_form_id INT
)
BEGIN
    SELECT * FROM signature_info
    WHERE child_id = p_child_id AND form_id = p_form_id;
END //

DELIMITER ;




------------ READ ALL ------------

DELIMITER //

CREATE PROCEDURE spGetAllSignatureInfo (
    IN p_child_id INT,
    IN p_form_id INT
)
BEGIN
    SELECT * FROM signature_info
    WHERE child_id = p_child_id ;
END //

DELIMITER ;



------------ UPDATE ------------

DELIMITER //

CREATE PROCEDURE spUpdateSignatureInfo (
    IN p_child_id INT,
    IN p_form_id INT,
    IN p_parent_sign VARCHAR(255),
    IN p_parent_date DATE,
    IN p_admin_sign VARCHAR(255),
    IN p_admin_date DATE
)
BEGIN
    UPDATE signature_info
    SET parent_sign = p_parent_sign,
        parent_date = p_parent_date,
        admin_sign = p_admin_sign,
        admin_date = p_admin_date
    WHERE child_id = p_child_id AND form_id = p_form_id;
END //

DELIMITER ;



------------ DELETE ------------



DELIMITER //

CREATE PROCEDURE spDeleteSignatureInfo (
    IN p_child_id INT,
    IN p_form_id INT
)
BEGIN
    DELETE FROM signature_info
    WHERE child_id = p_child_id AND form_id = p_form_id;
END //

DELIMITER ;