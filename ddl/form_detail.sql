CREATE TABLE form_detail (
    form_id INT NOT NULL AUTO_INCREMENT,
    form_name VARCHAR(255),
    PRIMARY KEY (form_id)
);


------------ CREATE ------------

DELIMITER //

CREATE PROCEDURE spCreateFormDetail (
    IN p_form_name VARCHAR(255)
)
BEGIN
    INSERT INTO form_detail (form_name)
    VALUES (p_form_name);
END //

DELIMITER ;


------------ READ ------------

DELIMITER //

CREATE PROCEDURE spGetFormDetail (
    IN p_form_id INT
)
BEGIN
    SELECT * FROM form_detail;
END //

DELIMITER ;

------------ UPDATE ------------

DELIMITER //

CREATE PROCEDURE spUpdateFormDetail (
    IN p_form_id INT,
    IN p_form_name VARCHAR(255)
)
BEGIN
    UPDATE form_detail
    SET form_name = p_form_name
    WHERE form_id = p_form_id;
END //

DELIMITER ;




------------ DELETE ------------

DELIMITER //

CREATE PROCEDURE spDeleteFormDetail (
    IN p_form_id INT
)
BEGIN
    DELETE FROM form_detail WHERE form_id = p_form_id;
END //

DELIMITER ;