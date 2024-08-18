
CREATE TABLE enrollment_form (
    form_id INT NOT NULL AUTO_INCREMENT,
    child_id INT NOT NULL,
    enrollment_name VARCHAR(255),
    point_one_field VARCHAR(255),
    point_two_init VARCHAR(255),
    point_three_ini VARCHAR(255),
    point_four_init VARCHAR(255),
    point_five_init VARCHAR(255),
    point_six_init VARCHAR(255),
    point_seven_init VARCHAR(255),
    point_eight_init VARCHAR(255),
    point_nine_init VARCHAR(255),
    point_ten_init VARCHAR(255),
    point_eleven_init VARCHAR(255),
    point_twelve_init VARCHAR(255),
    point_thirteen_init VARCHAR(255),
    point_fourteen_init VARCHAR(255),
    point_fifteen_initi VARCHAR(255),
    point_sixteen_init VARCHAR(255),
    point_seventeen_init VARCHAR(255),
    point_eighteen_init VARCHAR(255),
    start_date DATE,
    schedule_date VARCHAR(255),  -- Changed to VARCHAR to accommodate string values
    full_day BOOLEAN,
    half_day BOOLEAN,
    parent_sign VARCHAR(255),
    parent_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    admin_sign VARCHAR(255),
    admin_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (form_id),
    FOREIGN KEY (child_id) REFERENCES admission_form(child_id)
);


-------------------- STORED PROCEDURE-------------------------

-- ------------------CREATE---------------- 


DELIMITER //

CREATE PROCEDURE spCreateEnrollmentForm(
    IN p_childId INT,
    IN p_enrollmentName VARCHAR(255),
    IN p_pointOneField VARCHAR(255),
    IN p_pointTwoInit VARCHAR(255),
    IN p_pointThreeIni VARCHAR(255),
    IN p_pointFourInit VARCHAR(255),
    IN p_pointFiveInit VARCHAR(255),
    IN p_pointSixInit VARCHAR(255),
    IN p_pointSevenInit VARCHAR(255),
    IN p_pointEightInit VARCHAR(255),
    IN p_pointNineInit VARCHAR(255),
    IN p_pointTenInit VARCHAR(255),
    IN p_pointElevenInit VARCHAR(255),
    IN p_pointTwelveInit VARCHAR(255),
    IN p_pointThirteenInit VARCHAR(255),
    IN p_pointFourteenInit VARCHAR(255),
    IN p_pointFifteenIniti VARCHAR(255),
    IN p_pointSixteenInit VARCHAR(255),
    IN p_pointSeventeenInit VARCHAR(255),
    IN p_pointEighteenInit VARCHAR(255),
    IN p_startDate DATE,
    IN p_scheduleDate VARCHAR(255),
    IN p_fullDay BOOLEAN,
    IN p_halfDay BOOLEAN,
    IN p_parentSign VARCHAR(255),
    IN p_adminSign VARCHAR(255)
)
BEGIN
    INSERT INTO enrollment_form (
        child_id,
        enrollment_name,
        point_one_field,
        point_two_init,
        point_three_ini,
        point_four_init,
        point_five_init,
        point_six_init,
        point_seven_init,
        point_eight_init,
        point_nine_init,
        point_ten_init,
        point_eleven_init,
        point_twelve_init,
        point_thirteen_init,
        point_fourteen_init,
        point_fifteen_initi,
        point_sixteen_init,
        point_seventeen_init,
        point_eighteen_init,
        start_date,
        schedule_date,
        full_day,
        half_day,
        parent_sign,
        admin_sign,
        is_active
    )
    VALUES (
        p_childId,
        p_enrollmentName,
        p_pointOneField,
        p_pointTwoInit,
        p_pointThreeIni,
        p_pointFourInit,
        p_pointFiveInit,
        p_pointSixInit,
        p_pointSevenInit,
        p_pointEightInit,
        p_pointNineInit,
        p_pointTenInit,
        p_pointElevenInit,
        p_pointTwelveInit,
        p_pointThirteenInit,
        p_pointFourteenInit,
        p_pointFifteenIniti,
        p_pointSixteenInit,
        p_pointSeventeenInit,
        p_pointEighteenInit,
        p_startDate,
        p_scheduleDate,
        p_fullDay,
        p_halfDay,
        p_parentSign,
        p_adminSign,
        TRUE
    );
END //

DELIMITER ;


-- ------------------ GET ---------------- 


DELIMITER //

CREATE PROCEDURE spGetEnrollmentForm(
    IN p_formId INT
)
BEGIN
    SELECT * FROM enrollment_form
    WHERE form_id = p_formId AND is_active = TRUE;
END //

DELIMITER ;


-- ------------------ GET ALL --------------- 

DELIMITER //

CREATE PROCEDURE spGetAllEnrollmentForms()
BEGIN
    SELECT * FROM enrollment_form
    WHERE is_active = TRUE;
END //

DELIMITER ;


-- ------------------ UPDATE ---------------- 


DELIMITER //

CREATE PROCEDURE spUpdateEnrollmentForm(
    IN p_formId INT,
    IN p_childId INT,
    IN p_enrollmentName VARCHAR(255),
    IN p_pointOneField VARCHAR(255),
    IN p_pointTwoInit VARCHAR(255),
    IN p_pointThreeIni VARCHAR(255),
    IN p_pointFourInit VARCHAR(255),
    IN p_pointFiveInit VARCHAR(255),
    IN p_pointSixInit VARCHAR(255),
    IN p_pointSevenInit VARCHAR(255),
    IN p_pointEightInit VARCHAR(255),
    IN p_pointNineInit VARCHAR(255),
    IN p_pointTenInit VARCHAR(255),
    IN p_pointElevenInit VARCHAR(255),
    IN p_pointTwelveInit VARCHAR(255),
    IN p_pointThirteenInit VARCHAR(255),
    IN p_pointFourteenInit VARCHAR(255),
    IN p_pointFifteenIniti VARCHAR(255),
    IN p_pointSixteenInit VARCHAR(255),
    IN p_pointSeventeenInit VARCHAR(255),
    IN p_pointEighteenInit VARCHAR(255),
    IN p_startDate DATE,
    IN p_scheduleDate VARCHAR(255),
    IN p_fullDay BOOLEAN,
    IN p_halfDay BOOLEAN,
    IN p_parentSign VARCHAR(255),
    IN p_adminSign VARCHAR(255)
)
BEGIN
    UPDATE enrollment_form
    SET 
        form_id = p_formId,
        child_id = p_childId,
        enrollment_name = p_enrollmentName,
        point_one_field = p_pointOneField,
        point_two_init = p_pointTwoInit,
        point_three_ini = p_pointThreeIni,
        point_four_init = p_pointFourInit,
        point_five_init = p_pointFiveInit,
        point_six_init = p_pointSixInit,
        point_seven_init = p_pointSevenInit,
        point_eight_init = p_pointEightInit,
        point_nine_init = p_pointNineInit,
        point_ten_init = p_pointTenInit,
        point_eleven_init = p_pointElevenInit,
        point_twelve_init = p_pointTwelveInit,
        point_thirteen_init = p_pointThirteenInit,
        point_fourteen_init = p_pointFourteenInit,
        point_fifteen_initi = p_pointFifteenIniti,
        point_sixteen_init = p_pointSixteenInit,
        point_seventeen_init = p_pointSeventeenInit,
        point_eighteen_init = p_pointEighteenInit,
        start_date = p_startDate,
        schedule_date = p_scheduleDate,
        full_day = p_fullDay,
        half_day = p_halfDay,
        parent_sign = p_parentSign,
        admin_sign = p_adminSign
    WHERE 
        form_id = p_formId AND is_active = TRUE;
END //

DELIMITER ;


-- ------------------ DELETE ---------------- 

DELIMITER //

CREATE PROCEDURE spDeleteEnrollmentForm(
    IN p_formId INT
)
BEGIN
    UPDATE enrollment_form
    SET is_active = FALSE
    WHERE form_id = p_formId;
END //

DELIMITER ;
