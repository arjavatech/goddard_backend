CREATE TABLE class_details (
    class_id INT NOT NULL AUTO_INCREMENT,
    class_name VARCHAR(255),
    PRIMARY KEY (class_id)
);


------------ CREATE ------------


DELIMITER //

CREATE PROCEDURE spCreateClass(
    IN p_className VARCHAR(255)
)
BEGIN
    INSERT INTO class_details (class_name)
    VALUES (p_className);
END //

 DELIMITER ;

------------ READ ------------

DELIMITER //

 CREATE PROCEDURE spGetClass(
    IN p_classId INT
)
BEGIN
    SELECT * FROM class_details
    WHERE 
        class_id = p_classId;
END //

DELIMITER ;


------------ READALL ------------

DELIMITER //

 CREATE PROCEDURE spGetAllClass(
)
BEGIN
    SELECT * FROM class_details;
   
END //

DELIMITER ;

------------ UPDATE ------------
 
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
        class_id = p_classId;
END//

DELIMITER ;

------------ DELETE ------------

DELIMITER //

CREATE PROCEDURE spDeleteClass(
    IN p_classId INT
)
BEGIN
    DELETE FROM class_details
    WHERE 
        class_id = p_classId;
END //

DELIMITER ;

