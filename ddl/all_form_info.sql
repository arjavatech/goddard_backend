CREATE TABLE all_form_info (
    form_id INT NOT NULL AUTO_INCREMENT,
    main_topic VARCHAR(255),
    sub_topic_one VARCHAR(255),
    sub_topic_two VARCHAR(255),
    sub_topic_three VARCHAR(255),
    sub_topic_four VARCHAR(255),
    sub_topic_five VARCHAR(255),
    sub_topic_six VARCHAR(255),
    sub_topic_seven VARCHAR(255),
    sub_topic_eight VARCHAR(255),
    sub_topic_nine VARCHAR(255),
    sub_topic_ten VARCHAR(255),
    sub_topic_eleven VARCHAR(255),
    sub_topic_twelve VARCHAR(255),
    sub_topic_thirteen VARCHAR(255),
    sub_topic_fourteen VARCHAR(255),
    sub_topic_fifteen VARCHAR(255),
    sub_topic_sixteen VARCHAR(255),
    sub_topic_seventeen VARCHAR(255),
    sub_topic_eighteen VARCHAR(255),
    form_type VARCHAR(255),
    form_status VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (form_id)
);



-- ------------------CREATE---------------- 

DELIMITER //

CREATE PROCEDURE spCreateFormInfo(
    IN p_main_topic VARCHAR(255),
    IN p_sub_topic_one VARCHAR(255),
    IN p_sub_topic_two VARCHAR(255),
    IN p_sub_topic_three VARCHAR(255),
    IN p_sub_topic_four VARCHAR(255),
    IN p_sub_topic_five VARCHAR(255),
    IN p_sub_topic_six VARCHAR(255),
    IN p_sub_topic_seven VARCHAR(255),
    IN p_sub_topic_eight VARCHAR(255),
    IN p_sub_topic_nine VARCHAR(255),
    IN p_sub_topic_ten VARCHAR(255),
    IN p_sub_topic_eleven VARCHAR(255),
    IN p_sub_topic_twelve VARCHAR(255),
    IN p_sub_topic_thirteen VARCHAR(255),
    IN p_sub_topic_fourteen VARCHAR(255),
    IN p_sub_topic_fifteen VARCHAR(255),
    IN p_sub_topic_sixteen VARCHAR(255),
    IN p_sub_topic_seventeen VARCHAR(255),
    IN p_sub_topic_eighteen VARCHAR(255),
    IN p_form_type VARCHAR(255),
    IN p_form_status VARCHAR(255)
)
BEGIN
    INSERT INTO all_form_info (
        main_topic, sub_topic_one, sub_topic_two, sub_topic_three,
        sub_topic_four, sub_topic_five, sub_topic_six, sub_topic_seven,
        sub_topic_eight, sub_topic_nine, sub_topic_ten, sub_topic_eleven,
        sub_topic_twelve, sub_topic_thirteen, sub_topic_fourteen, sub_topic_fifteen,
        sub_topic_sixteen, sub_topic_seventeen, sub_topic_eighteen,
        form_type, form_status, is_active
    )
    VALUES (
        p_main_topic, p_sub_topic_one, p_sub_topic_two, p_sub_topic_three,
        p_sub_topic_four, p_sub_topic_five, p_sub_topic_six, p_sub_topic_seven,
        p_sub_topic_eight, p_sub_topic_nine, p_sub_topic_ten, p_sub_topic_eleven,
        p_sub_topic_twelve, p_sub_topic_thirteen, p_sub_topic_fourteen, p_sub_topic_fifteen,
        p_sub_topic_sixteen, p_sub_topic_seventeen, p_sub_topic_eighteen,
        p_form_type, p_form_status, TRUE
    );
END //

DELIMITER ;


-- ------------- GET -----------------

DELIMITER //

CREATE PROCEDURE spGetFormInfo(
    IN p_form_id INT
)
BEGIN
    SELECT * FROM all_form_info
    WHERE 
        form_id = p_form_id AND is_active = TRUE;
END //

DELIMITER ;


-- ------------- GET ALL ----------------

DELIMITER //

CREATE PROCEDURE spGetAllFormInfo()
BEGIN
    SELECT * FROM all_form_info
    WHERE 
        is_active = TRUE;
END //

DELIMITER ;


-- ------------- UPDATE ----------------

DELIMITER //

CREATE PROCEDURE spUpdateFormInfo(
    IN p_form_id INT,
    IN p_main_topic VARCHAR(255),
    IN p_sub_topic_one VARCHAR(255),
    IN p_sub_topic_two VARCHAR(255),
    IN p_sub_topic_three VARCHAR(255),
    IN p_sub_topic_four VARCHAR(255),
    IN p_sub_topic_five VARCHAR(255),
    IN p_sub_topic_six VARCHAR(255),
    IN p_sub_topic_seven VARCHAR(255),
    IN p_sub_topic_eight VARCHAR(255),
    IN p_sub_topic_nine VARCHAR(255),
    IN p_sub_topic_ten VARCHAR(255),
    IN p_sub_topic_eleven VARCHAR(255),
    IN p_sub_topic_twelve VARCHAR(255),
    IN p_sub_topic_thirteen VARCHAR(255),
    IN p_sub_topic_fourteen VARCHAR(255),
    IN p_sub_topic_fifteen VARCHAR(255),
    IN p_sub_topic_sixteen VARCHAR(255),
    IN p_sub_topic_seventeen VARCHAR(255),
    IN p_sub_topic_eighteen VARCHAR(255),
    IN p_form_type VARCHAR(255),
    IN p_form_status VARCHAR(255)
)
BEGIN
    UPDATE all_form_info
    SET 
        main_topic = p_main_topic,
        sub_topic_one = p_sub_topic_one,
        sub_topic_two = p_sub_topic_two,
        sub_topic_three = p_sub_topic_three,
        sub_topic_four = p_sub_topic_four,
        sub_topic_five = p_sub_topic_five,
        sub_topic_six = p_sub_topic_six,
        sub_topic_seven = p_sub_topic_seven,
        sub_topic_eight = p_sub_topic_eight,
        sub_topic_nine = p_sub_topic_nine,
        sub_topic_ten = p_sub_topic_ten,
        sub_topic_eleven = p_sub_topic_eleven,
        sub_topic_twelve = p_sub_topic_twelve,
        sub_topic_thirteen = p_sub_topic_thirteen,
        sub_topic_fourteen = p_sub_topic_fourteen,
        sub_topic_fifteen = p_sub_topic_fifteen,
        sub_topic_sixteen = p_sub_topic_sixteen,
        sub_topic_seventeen = p_sub_topic_seventeen,
        sub_topic_eighteen = p_sub_topic_eighteen,
        form_type = p_form_type,
        form_status = p_form_status
    WHERE 
        form_id = p_form_id AND is_active = TRUE;
END //

DELIMITER ;


-- ------------- DELETE ----------------

DELIMITER //

CREATE PROCEDURE spDeleteFormInfo(
    IN p_form_id INT
)
BEGIN
    UPDATE all_form_info
    SET is_active = FALSE
    WHERE 
        form_id = p_form_id;
END //

DELIMITER ;
