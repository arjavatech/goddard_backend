CREATE TABLE class_details (
    class_id INT NOT NULL AUTO_INCREMENT,
    class_name VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (class_id)
);



-------------------- STORED PROCEDURE-------------------------

-- ------------------CREATE---------------- 


DELIMITER //

CREATE PROCEDURE spCreateClass(
    IN p_className VARCHAR(255)
)
BEGIN
    INSERT INTO class_details (class_name, is_active)
    VALUES (p_className, TRUE);
END //

DELIMITER ;



-- ------------- GET -----------------


DELIMITER //

CREATE PROCEDURE spGetClass(
    IN p_classId INT
)
BEGIN
    SELECT * FROM class_details
    WHERE 
        class_id = p_classId AND is_active = TRUE;
END //

DELIMITER ;



-- ------------- GET ALL ----------------


 DELIMITER //

CREATE PROCEDURE spGetAllClass()
BEGIN
    SELECT * FROM class_details
    WHERE 
        is_active = TRUE;
END //

DELIMITER ;

 

-- ------------- UPDATE ----------------


DELIMITER //

CREATE PROCEDURE spUpdateClass(
    IN p_classId INT,
    IN p_className VARCHAR(255)
)
BEGIN
    UPDATE class_details
    SET 
        class_name = p_className
    WHERE 
        class_id = p_classId AND is_active = TRUE;
END //

DELIMITER ;



-- ------------- DELETE ----------------


DELIMITER //

CREATE PROCEDURE spDeleteClass(
    IN p_classId INT
)
BEGIN
    UPDATE class_details
    SET is_active = FALSE
    WHERE 
        class_id = p_classId;
END //

DELIMITER ;

