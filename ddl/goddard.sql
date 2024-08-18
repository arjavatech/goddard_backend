
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





CREATE TABLE parent_info (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,
    name VARCHAR(255),
    street_address VARCHAR(255),
    city_address VARCHAR(255),
    state_address VARCHAR(50),
    zip_address VARCHAR(10),
    home_telephone_number VARCHAR(20),
    home_cellphone_number VARCHAR(20),
    business_name VARCHAR(255),
    work_hours_from VARCHAR(50),
    work_hours_to VARCHAR(50),
    business_telephone_number VARCHAR(20),
    business_street_address VARCHAR(255),
    business_city_address VARCHAR(100),
    business_state_address VARCHAR(50),
    business_zip_address VARCHAR(12),
    business_cell_number VARCHAR(20),
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id)
);



---------------- STORED PROCEDURE----------------------

----------------CREATE---------------- 


DELIMITER //

CREATE PROCEDURE spCreateParentInfo (
    IN p_email VARCHAR(255),
    IN p_name VARCHAR(255),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(255),
    IN p_state_address VARCHAR(50),
    IN p_zip_address VARCHAR(10),
    IN p_home_telephone_number VARCHAR(20),
    IN p_home_cellphone_number VARCHAR(20),
    IN p_business_name VARCHAR(255),
    IN p_work_hours_from VARCHAR(50),
    IN p_work_hours_to VARCHAR(50),
    IN p_business_telephone_number VARCHAR(20),
    IN p_business_street_address VARCHAR(255),
    IN p_business_city_address VARCHAR(100),
    IN p_business_state_address VARCHAR(50),
    IN p_business_zip_address VARCHAR(12),
    IN p_business_cell_number VARCHAR(20)
)
BEGIN
    INSERT INTO parent_info (
        email, name, street_address, city_address, state_address, zip_address, home_telephone_number, home_cellphone_number, business_name, work_hours_from, work_hours_to, business_telephone_number, business_street_address, business_city_address, business_state_address, business_zip_address, business_cell_number, is_active
    ) VALUES (
        p_email, p_name, p_street_address, p_city_address, p_state_address, p_zip_address, p_home_telephone_number, p_home_cellphone_number, p_business_name, p_work_hours_from, p_work_hours_to, p_business_telephone_number, p_business_street_address, p_business_city_address, p_business_state_address, p_business_zip_address, p_business_cell_number, TRUE
    );
END //

DELIMITER ;


------------- GET -----------------


DELIMITER //

CREATE PROCEDURE spGetParentInfo (
    IN p_id INT
)
BEGIN
    SELECT * 
    FROM parent_info 
    WHERE id = p_id AND is_active = TRUE;
END //

DELIMITER ;


------------ GET ALL ----------------


DELIMITER //

CREATE PROCEDURE spGetAllParentInfo ()
BEGIN
    SELECT * 
    FROM parent_info 
    WHERE is_active = TRUE;
END //

DELIMITER ;
 

------------- UPDATE ----------------


DELIMITER //

CREATE PROCEDURE spUpdateParentInfo (
    IN p_id INT,
    IN p_email VARCHAR(255),
    IN p_name VARCHAR(255),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(255),
    IN p_state_address VARCHAR(50),
    IN p_zip_address VARCHAR(10),
    IN p_home_telephone_number VARCHAR(20),
    IN p_home_cellphone_number VARCHAR(20),
    IN p_business_name VARCHAR(255),
    IN p_work_hours_from VARCHAR(50),
    IN p_work_hours_to VARCHAR(50),
    IN p_business_telephone_number VARCHAR(20),
    IN p_business_street_address VARCHAR(255),
    IN p_business_city_address VARCHAR(100),
    IN p_business_state_address VARCHAR(50),
    IN p_business_zip_address VARCHAR(12),
    IN p_business_cell_number VARCHAR(20)
)
BEGIN
    UPDATE parent_info
    SET 
        email = p_email,
        name = p_name,
        street_address = p_street_address,
        city_address = p_city_address,
        state_address = p_state_address,
        zip_address = p_zip_address,
        home_telephone_number = p_home_telephone_number,
        home_cellphone_number = p_home_cellphone_number,
        business_name = p_business_name,
        work_hours_from = p_work_hours_from,
        work_hours_to = p_work_hours_to,
        business_telephone_number = p_business_telephone_number,
        business_street_address = p_business_street_address,
        business_city_address = p_business_city_address,
        business_state_address = p_business_state_address,
        business_zip_address = p_business_zip_address,
        business_cell_number = p_business_cell_number
    WHERE id = p_id AND is_active = TRUE;
END //

DELIMITER ;



------------- DELETE ----------------


DELIMITER //

CREATE PROCEDURE spDeleteParentInfo (
    IN p_id INT
)
BEGIN
    UPDATE parent_info
    SET is_active = FALSE
    WHERE id = p_id;
END //

DELIMITER ;



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




CREATE TABLE care_provider (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    telephone_number VARCHAR(20) NOT NULL,
    hospital_affiliation VARCHAR(255),
    street_address VARCHAR(255),
    city_address VARCHAR(100),
    state_address VARCHAR(50),
    zip_address VARCHAR(12),
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id)
);


-------------------- STORED PROCEDURE-------------------------

-- ------------------CREATE---------------- 


DELIMITER //

CREATE PROCEDURE spCreateCareProvider(
    IN p_name VARCHAR(255),
    IN p_telephone_number VARCHAR(20),
    IN p_hospital_affiliation VARCHAR(255),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(100),
    IN p_state_address VARCHAR(50),
    IN p_zip_address VARCHAR(12)
)
BEGIN
    INSERT INTO care_provider (
        name,
        telephone_number,
        hospital_affiliation,
        street_address,
        city_address,
        state_address,
        zip_address,
        is_active
    )
    VALUES (
        p_name,
        p_telephone_number,
        p_hospital_affiliation,
        p_street_address,
        p_city_address,
        p_state_address,
        p_zip_address,
        TRUE
    );
END //

DELIMITER ;




-- ------------- GET -----------------


DELIMITER //

CREATE PROCEDURE spGetCareProvider(
    IN p_id INT
)
BEGIN
    SELECT * FROM care_provider
    WHERE id = p_id AND is_active = TRUE;
END //

DELIMITER ;




-- ------------- GET ALL ----------------


DELIMITER //

CREATE PROCEDURE spGetAllCareProviders()
BEGIN
    SELECT * FROM care_provider
    WHERE is_active = TRUE;
END //

DELIMITER ;


 

-- ------------- UPDATE ----------------


DELIMITER //

CREATE PROCEDURE spUpdateCareProvider(
    IN p_id INT,
    IN p_name VARCHAR(255),
    IN p_telephone_number VARCHAR(20),
    IN p_hospital_affiliation VARCHAR(255),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(100),
    IN p_state_address VARCHAR(50),
    IN p_zip_address VARCHAR(12)
)
BEGIN
    UPDATE care_provider
    SET 
        name = p_name,
        telephone_number = p_telephone_number,
        hospital_affiliation = p_hospital_affiliation,
        street_address = p_street_address,
        city_address = p_city_address,
        state_address = p_state_address,
        zip_address = p_zip_address
    WHERE 
        id = p_id AND is_active = TRUE;
END //

DELIMITER ;




-- ------------- DELETE ----------------


DELIMITER //

CREATE PROCEDURE spDeleteCareProvider(
    IN p_id INT
)
BEGIN
    UPDATE care_provider
    SET is_active = FALSE
    WHERE id = p_id;
END //

DELIMITER ;


CREATE TABLE dentist (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    telephone_number VARCHAR(20),
    street_address VARCHAR(255),
    city_address VARCHAR(100),
    state_address VARCHAR(50),
    zip_address VARCHAR(12),
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (id)
);
-------------------- STORED PROCEDURE-------------------------

-- ------------------CREATE---------------- 


DELIMITER //

CREATE PROCEDURE spCreateDentist(
    IN p_name VARCHAR(255),
    IN p_telephone_number VARCHAR(20),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(100),
    IN p_state_address VARCHAR(50),
    IN p_zip_address VARCHAR(12)
)
BEGIN
    INSERT INTO dentist (
        name, 
        telephone_number, 
        street_address, 
        city_address, 
        state_address, 
        zip_address, 
        is_active
    )
    VALUES (
        p_name, 
        p_telephone_number, 
        p_street_address, 
        p_city_address, 
        p_state_address, 
        p_zip_address, 
        TRUE
    );
END //

DELIMITER ;




-- ------------- GET -----------------


DELIMITER //

CREATE PROCEDURE spGetDentist(
    IN p_id INT
)
BEGIN
    SELECT * FROM dentist
    WHERE id = p_id AND is_active = TRUE;
END //

DELIMITER ;




-- ------------- GET ALL ----------------


 DELIMITER //

CREATE PROCEDURE spGetAllDentists()
BEGIN
    SELECT * FROM dentist
    WHERE is_active = TRUE;
END //

DELIMITER ;


 

-- ------------- UPDATE ----------------


DELIMITER //

CREATE PROCEDURE spUpdateDentist(
    IN p_id INT,
    IN p_name VARCHAR(255),
    IN p_telephone_number VARCHAR(20),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(100),
    IN p_state_address VARCHAR(50),
    IN p_zip_address VARCHAR(12)
)
BEGIN
    UPDATE dentist
    SET 
        name = p_name,
        telephone_number = p_telephone_number,
        street_address = p_street_address,
        city_address = p_city_address,
        state_address = p_state_address,
        zip_address = p_zip_address
    WHERE 
        id = p_id AND is_active = TRUE;
END //

DELIMITER ;



-- ------------- DELETE ----------------


DELIMITER //

CREATE PROCEDURE spDeleteDentist(
    IN p_id INT
)
BEGIN
    UPDATE dentist
    SET is_active = FALSE
    WHERE id = p_id;
END //

DELIMITER ;


CREATE TABLE admission_form (
    child_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    parent_id INT,
    additional_parent_id INT,
    classId INT,
    care_provider_id INT,
    dentist_id INT,
    child_first_name VARCHAR(100),
    child_last_name VARCHAR(100),
    nick_name VARCHAR(100),
    dob DATE,
    primary_language VARCHAR(50),
    school_age_child_school VARCHAR(100),
    custody_papers_apply BOOLEAN,
    gender VARCHAR(10),
    special_diabilities TEXT,
    allergies_reaction TEXT,
    additional_info TEXT,
    medication TEXT,
    health_insurance TEXT,
    policy_number VARCHAR(100),
    emergency_medical_care TEXT,
    first_aid_procedures TEXT,
    above_info_is_correct BOOLEAN,
    physical_exam_last_date DATE,
    dental_exam_last_date DATE,
    allergies TEXT,
    asthma TEXT,
    bleeding_problems TEXT,
    diabetes TEXT,
    epilepsy TEXT,
    frequent_ear_infections TEXT,
    frequent_illnesses TEXT,
    hearing_problems TEXT,
    high_fevers TEXT,
    hospitalization TEXT,
    rheumatic_fever TEXT,
    seizures_convulsions TEXT,
    serious_injuries_accidents TEXT,
    surgeries TEXT,
    vision_problems TEXT,
    medical_other TEXT,
    illness_in_pregnancy TEXT,
    condition_of_newborn TEXT,
    duration_of_pregnancy TEXT,
    birth_weight_lbs VARCHAR(50),
    birth_weight_oz VARCHAR(50),
    complications TEXT,
    bottle_fed BOOLEAN,
    breast_fed BOOLEAN,
    other_siblings_name VARCHAR(100),
    other_siblings_age VARCHAR(50),
    fam_hist_allergies BOOLEAN,
    fam_hist_heart_problems BOOLEAN,
    fam_hist_tuberculosis BOOLEAN,
    fam_hist_asthma BOOLEAN,
    fam_hist_high_blood_pressure BOOLEAN,
    fam_hist_vision_problems BOOLEAN,
    fam_hist_diabetes BOOLEAN,
    fam_hist_hyperactivity BOOLEAN,
    fam_hist_epilepsy BOOLEAN,
    fam_hist_no_illness BOOLEAN,
    age_group_friends VARCHAR(100),
    neighborhood_friends VARCHAR(100),
    relationship_with_mom VARCHAR(100),
    relationship_with_dad VARCHAR(100),
    relationship_with_sib VARCHAR(100),
    relationship_extended_family VARCHAR(100),
    fears_conflicts TEXT,
    c_response_frustration TEXT,
    favorite_activities TEXT,
    last_five_years_moved BOOLEAN,
    things_used_home VARCHAR(100),
    hours_of_television_daily VARCHAR(50),
    language_at_home VARCHAR(50),
    changes_home_situation BOOLEAN,
    educational_expectations_of_child TEXT,
    fam_his_instructions BOOLEAN,
    immunization_instructions BOOLEAN,
    important_fam_members VARCHAR(100),
    fam_celebrations VARCHAR(100),
    childcare_before BOOLEAN,
    reason_for_childcare_before TEXT,
    what_child_interests TEXT,
    drop_off_time TIME,
    pick_up_time TIME,
    restricted_diet BOOLEAN,
    restricted_diet_reason TEXT,
    eat_own BOOLEAN,
    eat_own_reason TEXT,
    favorite_foods TEXT,
    rest_middle_day BOOLEAN,
    reason_rest_middle_day TEXT,
    rest_routine TEXT,
    toilet_trained BOOLEAN,
    reason_for_toilet_trained TEXT,
    existing_illness_allergy BOOLEAN,
    explain_illness_allergy TEXT,
    functioning_at_age BOOLEAN,
    explain_functioning_at_age TEXT,
    able_to_walk BOOLEAN,
    explain_able_to_walk TEXT,
    communicate_their_needs BOOLEAN,
    explain_communicate_their_needs TEXT,
    any_medication BOOLEAN,
    explain_for_any_medication TEXT,
    special_equipment BOOLEAN,
    explain_special_equipment TEXT,
    significant_periods BOOLEAN,
    explain_significant_periods TEXT,
    accommodations BOOLEAN,
    explain_for_accommodations TEXT,
    additional_information TEXT,
    child_info_is_correct BOOLEAN,
    child_pick_up_password VARCHAR(100),
    pick_up_password_form BOOLEAN,
    photo_video_permission_form TEXT,
    photo_permission_electronic BOOLEAN,
    photo_permission_post BOOLEAN,
    security_release_policy_form BOOLEAN,
    med_technicians_med_transportation_waiver TEXT,
    medical_transportation_waiver BOOLEAN,
    health_policies BOOLEAN,
    parent_sign_outside_waiver BOOLEAN,
    approve_social_media_post BOOLEAN,
    printed_social_media_post VARCHAR(100),
    social_media_post BOOLEAN,
    parent_sign VARCHAR(100),
    parent_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    admin_sign VARCHAR(100),
    admin_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (parent_id) REFERENCES parent_info(id),
    FOREIGN KEY (additional_parent_id) REFERENCES parent_info(id),
    FOREIGN KEY (classId) REFERENCES class_details(class_id),
    FOREIGN KEY (care_provider_id) REFERENCES care_provider(id),
    FOREIGN KEY (dentist_id) REFERENCES dentist(id)
);



-------------------- STORED PROCEDURE--------------------------- 

------------------CREATE------------------

DELIMITER //

CREATE PROCEDURE spCreateAdmissionForm (
    IN p_child_first_name VARCHAR(255),
    IN p_child_last_name VARCHAR(255),
    IN p_nick_name VARCHAR(255),
    IN p_dob DATE,
    IN p_primary_language VARCHAR(100),
    IN p_school_age_child_school VARCHAR(255),
    IN p_custody_papers_apply BOOLEAN,
    IN p_gender VARCHAR(10)
)
BEGIN
    INSERT INTO admission_form (
        child_first_name,
        child_last_name,
        nick_name,
        dob,
        primary_language,
        school_age_child_school,
        custody_papers_apply,
        gender
    ) VALUES (
        p_child_first_name,
        p_child_last_name,
        p_nick_name,
        p_dob,
        p_primary_language,
        p_school_age_child_school,
        p_custody_papers_apply,
        p_gender
    );
END //

DELIMITER ;


------------------ GET -------------------

DELIMITER //

CREATE PROCEDURE spGetAdmissionForm(
    IN p_childId INT
)
BEGIN
    SELECT * 
    FROM admission_form 
    WHERE child_id = p_childId AND is_active = TRUE;
END //

DELIMITER ;


------------------ GET ALL ---------------

DELIMITER //

CREATE PROCEDURE spGetAllAdmissionForms()
BEGIN
    SELECT * 
    FROM admission_form 
    WHERE is_active = TRUE;
END //

DELIMITER ;




------------------ UPDATE ---------------- 
DELIMITER //

CREATE PROCEDURE spUpdateAdmissionForm(
    IN p_child_id INT,
    IN p_parent_id INT,
    IN p_additional_parent_id INT,
    IN p_classId INT,
    IN p_care_provider_id INT,
    IN p_dentist_id INT,
    IN p_child_first_name VARCHAR(255),
    IN p_child_last_name VARCHAR(255),
    IN p_nick_name VARCHAR(255),
    IN p_dob DATE,
    IN p_primary_language VARCHAR(100),
    IN p_school_age_child_school VARCHAR(255),
    IN p_custody_papers_apply BOOLEAN,
    IN p_gender VARCHAR(10),
    IN p_special_diabilities VARCHAR(255),
    IN p_allergies_reaction VARCHAR(255),
    IN p_additional_info VARCHAR(255),
    IN p_medication VARCHAR(255),
    IN p_health_insurance VARCHAR(255),
    IN p_policy_number VARCHAR(255),
    IN p_emergency_medical_care VARCHAR(255),
    IN p_first_aid_procedures VARCHAR(255),
    IN p_above_info_is_correct BOOLEAN,
    IN p_physical_exam_last_date DATE,
    IN p_dental_exam_last_date DATE,
    IN p_allergies VARCHAR(255),
    IN p_asthma VARCHAR(255),
    IN p_bleeding_problems VARCHAR(255),
    IN p_diabetes VARCHAR(255),
    IN p_epilepsy VARCHAR(255),
    IN p_frequent_ear_infections VARCHAR(255),
    IN p_frequent_illnesses VARCHAR(255),
    IN p_hearing_problems VARCHAR(255),
    IN p_high_fevers VARCHAR(255),
    IN p_hospitalization VARCHAR(255),
    IN p_rheumatic_fever VARCHAR(255),
    IN p_seizures_convulsions VARCHAR(255),
    IN p_serious_injuries_accidents VARCHAR(255),
    IN p_surgeries VARCHAR(255),
    IN p_vision_problems VARCHAR(255),
    IN p_medical_other VARCHAR(255),
    IN p_illness_in_pregnancy VARCHAR(255),
    IN p_condition_of_newborn VARCHAR(255),
    IN p_duration_of_pregnancy VARCHAR(255),
    IN p_birth_weight_lbs VARCHAR(255),
    IN p_birth_weight_oz VARCHAR(255),
    IN p_complications VARCHAR(255),
    IN p_bottle_fed VARCHAR(255),
    IN p_breast_fed VARCHAR(255),
    IN p_other_siblings_name VARCHAR(255),
    IN p_other_siblings_age VARCHAR(255),
    IN p_fam_hist_allergies BOOLEAN,
    IN p_fam_hist_heart_problems BOOLEAN,
    IN p_fam_hist_tuberculosis BOOLEAN,
    IN p_fam_hist_asthma BOOLEAN,
    IN p_fam_hist_high_blood_pressure BOOLEAN,
    IN p_fam_hist_vision_problems BOOLEAN,
    IN p_fam_hist_diabetes BOOLEAN,
    IN p_fam_hist_hyperactivity BOOLEAN,
    IN p_fam_hist_epilepsy BOOLEAN,
    IN p_fam_hist_no_illness BOOLEAN,
    IN p_age_group_friends VARCHAR(255),
    IN p_neighborhood_friends VARCHAR(255),
    IN p_relationship_with_mom VARCHAR(255),
    IN p_relationship_with_dad VARCHAR(255),
    IN p_relationship_with_sib VARCHAR(255),
    IN p_relationship_extended_family VARCHAR(255),
    IN p_fears_conflicts VARCHAR(255),
    IN p_c_response_frustration VARCHAR(255),
    IN p_favorite_activities VARCHAR(255),
    IN p_last_five_years_moved BOOLEAN,
    IN p_things_used_home VARCHAR(255),
    IN p_hours_of_television_daily VARCHAR(255),
    IN p_language_at_home VARCHAR(100),
    IN p_changes_home_situation BOOLEAN,
    IN p_educational_expectations_of_child TEXT,
    IN p_fam_his_instructions BOOLEAN,
    IN p_immunization_instructions BOOLEAN,
    IN p_important_fam_members VARCHAR(255),
    IN p_fam_celebrations VARCHAR(255),
    IN p_childcare_before BOOLEAN,
    IN p_reason_for_childcare_before VARCHAR(255),
    IN p_what_child_interests VARCHAR(255),
    IN p_drop_off_time TIME,
    IN p_pick_up_time TIME,
    IN p_restricted_diet BOOLEAN,
    IN p_restricted_diet_reason VARCHAR(255),
    IN p_eat_own BOOLEAN,
    IN p_eat_own_reason VARCHAR(255),
    IN p_favorite_foods VARCHAR(255),
    IN p_rest_middle_day BOOLEAN,
    IN p_reason_rest_middle_day VARCHAR(255),
    IN p_rest_routine VARCHAR(255),
    IN p_toilet_trained BOOLEAN,
    IN p_reason_for_toilet_trained VARCHAR(255),
    IN p_existing_illness_allergy BOOLEAN,
    IN p_explain_illness_allergy VARCHAR(255),
    IN p_functioning_at_age BOOLEAN,
    IN p_explain_functioning_at_age VARCHAR(255),
    IN p_able_to_walk BOOLEAN,
    IN p_explain_able_to_walk VARCHAR(255),
    IN p_communicate_their_needs BOOLEAN,
    IN p_explain_communicate_their_needs VARCHAR(255),
    IN p_any_medication BOOLEAN,
    IN p_explain_for_any_medication VARCHAR(255),
    IN p_special_equipment BOOLEAN,
    IN p_explain_special_equipment VARCHAR(255),
    IN p_significant_periods BOOLEAN,
    IN p_explain_significant_periods VARCHAR(255),
    IN p_accommodations BOOLEAN,
    IN p_explain_for_accommodations VARCHAR(255),
    IN p_additional_information TEXT,
    IN p_child_info_is_correct BOOLEAN,
    IN p_child_pick_up_password VARCHAR(255),
    IN p_pick_up_password_form BOOLEAN,
    IN p_photo_video_permission_form VARCHAR(255),
    IN p_photo_permission_electronic BOOLEAN,
    IN p_photo_permission_post BOOLEAN,
    IN p_security_release_policy_form BOOLEAN,
    IN p_med_technicians_med_transportation_waiver VARCHAR(255),
    IN p_medical_transportation_waiver BOOLEAN,
    IN p_health_policies BOOLEAN,
    IN p_parent_sign_outside_waiver BOOLEAN,
    IN p_approve_social_media_post BOOLEAN,
    IN p_printed_social_media_post VARCHAR(255),
    IN p_social_media_post BOOLEAN,
    IN p_parent_sign VARCHAR(255),
    IN p_admin_sign VARCHAR(255)
)
BEGIN
    UPDATE admission_form
    SET 
        parent_id = p_parent_id,
        additional_parent_id = p_additional_parent_id,
        classId = p_classId,
        care_provider_id = p_care_provider_id,
        dentist_id = p_dentist_id,
        child_first_name = p_child_first_name,
        child_last_name = p_child_last_name,
        nick_name = p_nick_name,
        dob = p_dob,
        primary_language = p_primary_language,
        school_age_child_school = p_school_age_child_school,
        custody_papers_apply = p_custody_papers_apply,
        gender = p_gender,
        special_diabilities = p_special_diabilities,
        allergies_reaction = p_allergies_reaction,
        additional_info = p_additional_info,
        medication = p_medication,
        health_insurance = p_health_insurance,
        policy_number = p_policy_number,
        emergency_medical_care = p_emergency_medical_care,
        first_aid_procedures = p_first_aid_procedures,
        above_info_is_correct = p_above_info_is_correct,
        physical_exam_last_date = p_physical_exam_last_date,
        dental_exam_last_date = p_dental_exam_last_date,
        allergies = p_allergies,
        asthma = p_asthma,
        bleeding_problems = p_bleeding_problems,
        diabetes = p_diabetes,
        epilepsy = p_epilepsy,
        frequent_ear_infections = p_frequent_ear_infections,
        frequent_illnesses = p_frequent_illnesses,
        hearing_problems = p_hearing_problems,
        high_fevers = p_high_fevers,
        hospitalization = p_hospitalization,
        rheumatic_fever = p_rheumatic_fever,
        seizures_convulsions = p_seizures_convulsions,
        serious_injuries_accidents = p_serious_injuries_accidents,
        surgeries = p_surgeries,
        vision_problems = p_vision_problems,
        medical_other = p_medical_other,
        illness_in_pregnancy = p_illness_in_pregnancy,
        condition_of_newborn = p_condition_of_newborn,
        duration_of_pregnancy = p_duration_of_pregnancy,
        birth_weight_lbs = p_birth_weight_lbs,
        birth_weight_oz = p_birth_weight_oz,
        complications = p_complications,
        bottle_fed = p_bottle_fed,
        breast_fed = p_breast_fed,
        other_siblings_name = p_other_siblings_name,
        other_siblings_age = p_other_siblings_age,
        fam_hist_allergies = p_fam_hist_allergies,
        fam_hist_heart_problems = p_fam_hist_heart_problems,
        fam_hist_tuberculosis = p_fam_hist_tuberculosis,
        fam_hist_asthma = p_fam_hist_asthma,
        fam_hist_high_blood_pressure = p_fam_hist_high_blood_pressure,
        fam_hist_vision_problems = p_fam_hist_vision_problems,
        fam_hist_diabetes = p_fam_hist_diabetes,
        fam_hist_hyperactivity = p_fam_hist_hyperactivity,
        fam_hist_epilepsy = p_fam_hist_epilepsy,
        fam_hist_no_illness = p_fam_hist_no_illness,
        age_group_friends = p_age_group_friends,
        neighborhood_friends = p_neighborhood_friends,
        relationship_with_mom = p_relationship_with_mom,
        relationship_with_dad = p_relationship_with_dad,
        relationship_with_sib = p_relationship_with_sib,
        relationship_extended_family = p_relationship_extended_family,
        fears_conflicts = p_fears_conflicts,
        c_response_frustration = p_c_response_frustration,
        favorite_activities = p_favorite_activities,
        last_five_years_moved = p_last_five_years_moved,
        things_used_home = p_things_used_home,
        hours_of_television_daily = p_hours_of_television_daily,
        language_at_home = p_language_at_home,
        changes_home_situation = p_changes_home_situation,
        educational_expectations_of_child = p_educational_expectations_of_child,
        fam_his_instructions = p_fam_his_instructions,
        immunization_instructions = p_immunization_instructions,
        important_fam_members = p_important_fam_members,
        fam_celebrations = p_fam_celebrations,
        childcare_before = p_childcare_before,
        reason_for_childcare_before = p_reason_for_childcare_before,
        what_child_interests = p_what_child_interests,
        drop_off_time = p_drop_off_time,
        pick_up_time = p_pick_up_time,
        restricted_diet = p_restricted_diet,
        restricted_diet_reason = p_restricted_diet_reason,
        eat_own = p_eat_own,
        eat_own_reason = p_eat_own_reason,
        favorite_foods = p_favorite_foods,
        rest_middle_day = p_rest_middle_day,
        reason_rest_middle_day = p_reason_rest_middle_day,
        rest_routine = p_rest_routine,
        toilet_trained = p_toilet_trained,
        reason_for_toilet_trained = p_reason_for_toilet_trained,
        existing_illness_allergy = p_existing_illness_allergy,
        explain_illness_allergy = p_explain_illness_allergy,
        functioning_at_age = p_functioning_at_age,
        explain_functioning_at_age = p_explain_functioning_at_age,
        able_to_walk = p_able_to_walk,
        explain_able_to_walk = p_explain_able_to_walk,
        communicate_their_needs = p_communicate_their_needs,
        explain_communicate_their_needs = p_explain_communicate_their_needs,
        any_medication = p_any_medication,
        explain_for_any_medication = p_explain_for_any_medication,
        special_equipment = p_special_equipment,
        explain_special_equipment = p_explain_special_equipment,
        significant_periods = p_significant_periods,
        explain_significant_periods = p_explain_significant_periods,
        accommodations = p_accommodations,
        explain_for_accommodations = p_explain_for_accommodations,
        additional_information = p_additional_information,
        child_info_is_correct = p_child_info_is_correct,
        child_pick_up_password = p_child_pick_up_password,
        pick_up_password_form = p_pick_up_password_form,
        photo_video_permission_form = p_photo_video_permission_form,
        photo_permission_electronic = p_photo_permission_electronic,
        photo_permission_post = p_photo_permission_post,
        security_release_policy_form = p_security_release_policy_form,
        med_technicians_med_transportation_waiver = p_med_technicians_med_transportation_waiver,
        medical_transportation_waiver = p_medical_transportation_waiver,
        health_policies = p_health_policies,
        parent_sign_outside_waiver = p_parent_sign_outside_waiver,
        approve_social_media_post = p_approve_social_media_post,
        printed_social_media_post = p_printed_social_media_post,
        social_media_post = p_social_media_post,
        parent_sign = p_parent_sign,
        admin_sign = p_admin_sign
    WHERE 
        child_id = p_child_id AND is_active = TRUE;
END//

DELIMITER ;


------------------ DELETE ---------------- 

DELIMITER //

CREATE PROCEDURE spDeleteAdmissionForm(
    IN p_childId INT
)
BEGIN
    UPDATE admission_form
    SET is_active = FALSE
    WHERE child_id = p_childId;
END //

DELIMITER ;





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






CREATE TABLE parent_handbook (
    form_id INT NOT NULL AUTO_INCREMENT,
    child_id INT NOT NULL,
    welcome_goddard_agmt BOOLEAN,
    mission_statement_agmt BOOLEAN,
    general_information_agmt BOOLEAN,
    statement_confidentiality_agmt BOOLEAN,
    parent_access_agmt BOOLEAN,
    release_children_agmt BOOLEAN,
    registration_fees_agmt BOOLEAN,
    outside_engagements_agmt BOOLEAN,
    health_policies_agmt BOOLEAN,
    medication_procedures_agmt BOOLEAN,
    bring_school_agmt BOOLEAN,
    rest_time_agmt BOOLEAN,
    training_philosophy_agmt BOOLEAN,
    affiliation_policy_agmt BOOLEAN,
    security_issue_agmt BOOLEAN,
    expulsion_policy_agmt BOOLEAN,
    addressing_individual_child_agmt BOOLEAN,
    finalword_agmt BOOLEAN,
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

CREATE PROCEDURE spCreateParentHandbook(
    IN p_child_id INT,
    IN p_welcome_goddard_agmt BOOLEAN,
    IN p_mission_statement_agmt BOOLEAN,
    IN p_general_information_agmt BOOLEAN,
    IN p_statement_confidentiality_agmt BOOLEAN,
    IN p_parent_access_agmt BOOLEAN,
    IN p_release_children_agmt BOOLEAN,
    IN p_registration_fees_agmt BOOLEAN,
    IN p_outside_engagements_agmt BOOLEAN,
    IN p_health_policies_agmt BOOLEAN,
    IN p_medication_procedures_agmt BOOLEAN,
    IN p_bring_school_agmt BOOLEAN,
    IN p_rest_time_agmt BOOLEAN,
    IN p_training_philosophy_agmt BOOLEAN,
    IN p_affiliation_policy_agmt BOOLEAN,
    IN p_security_issue_agmt BOOLEAN,
    IN p_expulsion_policy_agmt BOOLEAN,
    IN p_addressing_individual_child_agmt BOOLEAN,
    IN p_finalword_agmt BOOLEAN,
    IN p_parent_sign VARCHAR(255),
    IN p_admin_sign VARCHAR(255)
)
BEGIN
    INSERT INTO parent_handbook (
        child_id, welcome_goddard_agmt, mission_statement_agmt, general_information_agmt,
        statement_confidentiality_agmt, parent_access_agmt, release_children_agmt,
        registration_fees_agmt, outside_engagements_agmt, health_policies_agmt,
        medication_procedures_agmt, bring_school_agmt, rest_time_agmt,
        training_philosophy_agmt, affiliation_policy_agmt, security_issue_agmt,
        expulsion_policy_agmt, addressing_individual_child_agmt, finalword_agmt,
        parent_sign, admin_sign, is_active
    ) VALUES (
        p_child_id, p_welcome_goddard_agmt, p_mission_statement_agmt, p_general_information_agmt,
        p_statement_confidentiality_agmt, p_parent_access_agmt, p_release_children_agmt,
        p_registration_fees_agmt, p_outside_engagements_agmt, p_health_policies_agmt,
        p_medication_procedures_agmt, p_bring_school_agmt, p_rest_time_agmt,
        p_training_philosophy_agmt, p_affiliation_policy_agmt, p_security_issue_agmt,
        p_expulsion_policy_agmt, p_addressing_individual_child_agmt, p_finalword_agmt,
        p_parent_sign, p_admin_sign, TRUE
    );
END //

DELIMITER ;



-- ------------- GET -----------------


DELIMITER //

CREATE PROCEDURE spGetParentHandbook(
    IN p_formId INT
)
BEGIN
    SELECT * FROM parent_handbook
    WHERE form_id = p_formId AND is_active = TRUE;
END //

DELIMITER ;




-- ------------- GET ALL ----------------


 DELIMITER //

CREATE PROCEDURE spGetAllParentHandbooks()
BEGIN
    SELECT * FROM parent_handbook
    WHERE is_active = TRUE;
END //

DELIMITER ;


 

-- ------------- UPDATE ----------------

DELIMITER //

CREATE PROCEDURE spUpdateParentHandbook(
    IN p_form_id INT,
    IN p_child_id INT,
    IN p_welcome_goddard_agmt BOOLEAN,
    IN p_mission_statement_agmt BOOLEAN,
    IN p_general_information_agmt BOOLEAN,
    IN p_statement_confidentiality_agmt BOOLEAN,
    IN p_parent_access_agmt BOOLEAN,
    IN p_release_children_agmt BOOLEAN,
    IN p_registration_fees_agmt BOOLEAN,
    IN p_outside_engagements_agmt BOOLEAN,
    IN p_health_policies_agmt BOOLEAN,
    IN p_medication_procedures_agmt BOOLEAN,
    IN p_bring_school_agmt BOOLEAN,
    IN p_rest_time_agmt BOOLEAN,
    IN p_training_philosophy_agmt BOOLEAN,
    IN p_affiliation_policy_agmt BOOLEAN,
    IN p_security_issue_agmt BOOLEAN,
    IN p_expulsion_policy_agmt BOOLEAN,
    IN p_addressing_individual_child_agmt BOOLEAN,
    IN p_finalword_agmt BOOLEAN,
    IN p_parent_sign VARCHAR(255),
    IN p_admin_sign VARCHAR(255)
)
BEGIN
    UPDATE parent_handbook
    SET 
        child_id = p_child_id,
        welcome_goddard_agmt = p_welcome_goddard_agmt,
        mission_statement_agmt = p_mission_statement_agmt,
        general_information_agmt = p_general_information_agmt,
        statement_confidentiality_agmt = p_statement_confidentiality_agmt,
        parent_access_agmt = p_parent_access_agmt,
        release_children_agmt = p_release_children_agmt,
        registration_fees_agmt = p_registration_fees_agmt,
        outside_engagements_agmt = p_outside_engagements_agmt,
        health_policies_agmt = p_health_policies_agmt,
        medication_procedures_agmt = p_medication_procedures_agmt,
        bring_school_agmt = p_bring_school_agmt,
        rest_time_agmt = p_rest_time_agmt,
        training_philosophy_agmt = p_training_philosophy_agmt,
        affiliation_policy_agmt = p_affiliation_policy_agmt,
        security_issue_agmt = p_security_issue_agmt,
        expulsion_policy_agmt = p_expulsion_policy_agmt,
        addressing_individual_child_agmt = p_addressing_individual_child_agmt,
        finalword_agmt = p_finalword_agmt,
        parent_sign = p_parent_sign,
        admin_sign = p_admin_sign
    WHERE 
        form_id = p_form_id AND is_active = TRUE;
END //

DELIMITER ;



-- ------------- DELETE ----------------


DELIMITER //

CREATE PROCEDURE spDeleteParentHandbook(
    IN p_formId INT
)
BEGIN
    UPDATE parent_handbook
    SET is_active = FALSE
    WHERE form_id = p_formId;
END //

DELIMITER ;






CREATE TABLE emergency_details (
    emergency_id INT NOT NULL AUTO_INCREMENT,
    contact_name VARCHAR(255) NOT NULL,
    contact_relationship VARCHAR(255) NOT NULL,
    street_address VARCHAR(255) NOT NULL,
    city_address VARCHAR(255) NOT NULL,
    state_address VARCHAR(255) NOT NULL,
    zip_address VARCHAR(20) NOT NULL,
    contact_telephone_number VARCHAR(20) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (emergency_id)
);


-------------------- STORED PROCEDURE-------------------------

-- ------------------CREATE---------------- 


DELIMITER //

CREATE PROCEDURE spCreateEmergencyDetail(
    IN p_contact_name VARCHAR(255),
    IN p_contact_relationship VARCHAR(255),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(255),
    IN p_state_address VARCHAR(255),
    IN p_zip_address VARCHAR(20),
    IN p_contact_telephone_number VARCHAR(20)
)
BEGIN
    INSERT INTO emergency_details (
        contact_name, 
        contact_relationship, 
        street_address, 
        city_address, 
        state_address, 
        zip_address, 
        contact_telephone_number, 
        is_active
    )
    VALUES (
        p_contact_name, 
        p_contact_relationship, 
        p_street_address, 
        p_city_address, 
        p_state_address, 
        p_zip_address, 
        p_contact_telephone_number, 
        TRUE
    );
END //

DELIMITER ;





-- ------------- GET -----------------


DELIMITER //

CREATE PROCEDURE spGetEmergencyDetail(
    IN p_emergency_id INT
)
BEGIN
    SELECT * FROM emergency_details
    WHERE emergency_id = p_emergency_id AND is_active = TRUE;
END //

DELIMITER ;





-- ------------- GET ALL ----------------


DELIMITER //

CREATE PROCEDURE spGetAllEmergencyDetails()
BEGIN
    SELECT * FROM emergency_details
    WHERE is_active = TRUE;
END //

DELIMITER ;



 

-- ------------- UPDATE ----------------


DELIMITER //

CREATE PROCEDURE spUpdateEmergencyDetail(
    IN p_emergency_id INT,
    IN p_contact_name VARCHAR(255),
    IN p_contact_relationship VARCHAR(255),
    IN p_street_address VARCHAR(255),
    IN p_city_address VARCHAR(255),
    IN p_state_address VARCHAR(255),
    IN p_zip_address VARCHAR(20),
    IN p_contact_telephone_number VARCHAR(20)
)
BEGIN
    UPDATE emergency_details
    SET 
        contact_name = p_contact_name,
        contact_relationship = p_contact_relationship,
        street_address = p_street_address,
        city_address = p_city_address,
        state_address = p_state_address,
        zip_address = p_zip_address,
        contact_telephone_number = p_contact_telephone_number
    WHERE 
        emergency_id = p_emergency_id AND is_active = TRUE;
END //

DELIMITER ;




-- ------------- DELETE ----------------


DELIMITER //

CREATE PROCEDURE spDeleteEmergencyDetail(
    IN p_emergency_id INT
)
BEGIN
    UPDATE emergency_details
    SET is_active = FALSE
    WHERE emergency_id = p_emergency_id;
END //

DELIMITER ;






CREATE TABLE emergency_contact (
    emergency_id INT NOT NULL,
    child_id INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (emergency_id, child_id),
    FOREIGN KEY (emergency_id) REFERENCES emergency_details(emergency_id),
    FOREIGN KEY (child_id) REFERENCES admission_form(child_id)
);


-------------------- STORED PROCEDURE-------------------------

--- ------------------CREATE---------------- 
DELIMITER //

CREATE PROCEDURE spCreateEmergencyContact(
    IN p_emergencyId INT,
    IN p_childId INT
)
BEGIN
    INSERT INTO emergency_contact (emergency_id, child_id, is_active)
    VALUES (p_emergencyId, p_childId, TRUE);
END //

DELIMITER ;


-- ------------- GET -----------------
DELIMITER //

CREATE PROCEDURE spGetEmergencyContact(
    IN p_emergencyId INT,
    IN p_childId INT
)
BEGIN
    SELECT * FROM emergency_contact
    WHERE 
        emergency_id = p_emergencyId 
        AND child_id = p_childId 
        AND is_active = TRUE;
END //

DELIMITER ;


-- ------------- GET ALL ----------------
DELIMITER //

CREATE PROCEDURE spGetAllEmergencyContact()
BEGIN
    SELECT * FROM emergency_contact
    WHERE 
        is_active = TRUE;
END //

DELIMITER ;


-- ------------- UPDATE ----------------
DELIMITER //

CREATE PROCEDURE spUpdateEmergencyContact(
    IN p_old_emergency_id INT,
    IN p_old_child_id INT,
    IN p_new_emergency_id INT,
    IN p_new_child_id INT
)
BEGIN
    UPDATE emergency_contact
    SET 
        emergency_id = p_new_emergency_id,
        child_id = p_new_child_id
    WHERE 
        emergency_id = p_old_emergency_id 
        AND child_id = p_old_child_id 
        AND is_active = TRUE;
END //

DELIMITER ;


-- ------------- DELETE ----------------
DELIMITER //

CREATE PROCEDURE spDeleteEmergencyContact(
    IN p_emergencyId INT,
    IN p_childId INT
)
BEGIN
    UPDATE emergency_contact
    SET is_active = FALSE
    WHERE 
        emergency_id = p_emergencyId 
        AND child_id = p_childId;
END //

DELIMITER ;




