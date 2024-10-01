


CREATE TABLE student_form_repository (
    child_id INT,
    form_id INT,
    form_status INT,
    is_active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (child_id, form_id),
    FOREIGN KEY (child_id) REFERENCES child_info(child_id),
    FOREIGN KEY (form_id) REFERENCES all_form_info(form_id)
);



-------------------- STORED PROCEDURE-------------------------

-- ------------------CREATE---------------- 


DELIMITER //

CREATE PROCEDURE spCreateStudentFormRepository(
    IN p_childId INT,
    IN p_formId INT,
    IN p_formstatus INT
)
BEGIN
    INSERT INTO student_form_repository (child_id, form_id, form_status, is_active)
    VALUES (p_childId, p_formId, p_formstatus, TRUE);
END //

DELIMITER ;






-- ------------- GET -----------------


DELIMITER //

CREATE PROCEDURE spGetStudentFormRepository(
    IN p_childId INT
)
BEGIN
    SELECT * FROM student_form_repository
    WHERE 
        child_id = p_childId 
        AND is_active = TRUE;
END //

DELIMITER ;






-- ------------- GET ALL ----------------


DELIMITER //

CREATE PROCEDURE spGetAllStudentFormRepository()
BEGIN
    SELECT * FROM student_form_repository
    WHERE is_active = TRUE;
END //

DELIMITER ;



 

-- ------------- UPDATE ----------------


DELIMITER //

CREATE PROCEDURE spUpdateStudentFormRepository(
    IN p_childId INT,
    IN p_oldFormId INT,
    IN p_newFormId INT,
    IN p_formstatus INT
)
BEGIN
    UPDATE student_form_repository
    SET 
        form_id = p_newFormId,
        form_status = p_formstatus
    WHERE 
        child_id = p_childId 
        AND form_id = p_oldFormId 
        AND is_active = TRUE;
END //

DELIMITER ;





-- ------------- DELETE ----------------


DELIMITER //

CREATE PROCEDURE spDeleteStudentFormRepository(
    IN p_childId INT,
    IN p_formId INT
)
BEGIN
    UPDATE student_form_repository
    SET is_active = FALSE
    WHERE 
        child_id = p_childId 
        AND form_id = p_formId;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE spDeleteStudentAllFormRepository(
    IN p_childId INT
)
BEGIN
    UPDATE student_form_repository
    SET is_active = FALSE
    WHERE 
        child_id = p_childId;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE `spGetClassFormRepositoryBasedClassID`(
    IN p_classId INT
)
BEGIN
    SELECT form_id FROM class_form_repository
    WHERE 
        class_id = p_classId 
        AND is_active = TRUE;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE `spCreateEmptyAuthorizationForm`(
    IN p_childId INT
)
BEGIN
    INSERT INTO authorization_form (
        child_id
    ) VALUES (
        p_childId
    );
END //

DELIMITER ;

DELIMITER //


CREATE PROCEDURE `spCreateEmptyAdmissionForm`(
    IN p_child_id INT
)
BEGIN
    INSERT INTO admission_form (
        child_id
    ) VALUES (
        p_child_id
    );
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateEmptyParentHandbook`(
    IN p_child_id INT
)
BEGIN
    INSERT INTO parent_handbook (
        child_id
    ) VALUES (
        p_child_id
    );
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateEmptyEnrollmentForm`(
    IN p_childId INT
)
BEGIN
    INSERT INTO enrollment_form (
        child_id
    )
    VALUES (
        p_childId
    );
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllClassRoomBasedChildDetails`(
    IN p_classId INT
)
BEGIN
    SELECT 
    c.child_id,
    c.child_first_name, 
    c.child_last_name, 
    cl.class_name,
    p.email AS primary_email,
    p2.email AS additional_parent_email,
    CASE
        WHEN MIN(fr.form_status) = 0 THEN 'Incomplete'
        WHEN MIN(fr.form_status) = 1 THEN 'Approval Pending'
        WHEN MIN(fr.form_status) = 2 THEN 'Completed'
        ELSE 'Unknown Status'
    END AS form_status
FROM 
    child_info c
JOIN 
    class_details cl ON c.class_id = cl.class_id
JOIN
    parent_info p ON c.parent_id = p.parent_id
JOIN
    admission_form adf ON adf.child_id = c.child_id
JOIN 
    parent_info p2 ON adf.additional_parent_id = p2.parent_id
JOIN 
    student_form_repository fr ON fr.child_id = c.child_id
WHERE 
    c.class_id = p_classId
    AND fr.is_active = 1 
GROUP BY 
    c.child_id, 
    c.child_first_name, 
    c.child_last_name, 
    cl.class_name, 
    p.email, 
    p2.email;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE `spGetAllFormBasedChildDetails`(
    IN p_formId INT
)
BEGIN
    SELECT 
    c.child_id,
    c.child_first_name, 
    c.child_last_name, 
    cl.class_name,
    p.email AS primary_email,
    p2.email AS additional_parent_email,
    CASE
        WHEN fr.form_status = 0 THEN 'Incomplete'
        WHEN fr.form_status = 1 THEN 'Approval Pending'
        WHEN fr.form_status = 2 THEN 'Completed'
        ELSE 'Unknown Status'
    END AS form_status
FROM 
    student_form_repository fr
JOIN 
	child_info c ON c.child_id = fr.child_id
JOIN 
    class_details cl ON c.class_id = cl.class_id
JOIN
    parent_info p ON c.parent_id = p.parent_id
JOIN
    admission_form adf ON adf.child_id = c.child_id
JOIN 
    parent_info p2 ON adf.additional_parent_id = p2.parent_id

WHERE 
    fr.form_id = p_formId
    AND fr.is_active = 1 
GROUP BY 
    c.child_id, 
    c.child_first_name, 
    c.child_last_name, 
    cl.class_name, 
    p.email, 
    p2.email;
END //

DELIMITER ;





DELIMITER //

CREATE PROCEDURE `spGetAllChildOverAllFormStatus`()
BEGIN
    SELECT 
    c.child_id,
    c.child_first_name, 
    c.child_last_name, 
    cl.class_name,
    p.email AS primary_email,
    p2.email AS additional_parent_email,
    CASE
        WHEN MIN(fr.form_status) = 0 THEN 'Incomplete'
        WHEN MIN(fr.form_status) = 1 THEN 'Approval Pending'
        WHEN MIN(fr.form_status) = 2 THEN 'Completed'
        ELSE 'Unknown Status'
    END AS form_status
FROM 
    student_form_repository fr
JOIN 
	child_info c ON c.child_id = fr.child_id
JOIN 
    class_details cl ON c.class_id = cl.class_id
JOIN
    parent_info p ON c.parent_id = p.parent_id
JOIN
    admission_form adf ON adf.child_id = c.child_id
JOIN 
    parent_info p2 ON adf.additional_parent_id = p2.parent_id

WHERE fr.is_active = 1 
GROUP BY 
    c.child_id, 
    c.child_first_name, 
    c.child_last_name, 
    cl.class_name, 
    p.email, 
    p2.email;
END //

DELIMITER ;

DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateDentist`(
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
        name = COALESCE(p_name, name),
        telephone_number = COALESCE(p_telephone_number, telephone_number),
        street_address = COALESCE(p_street_address, street_address),
        city_address = COALESCE(p_city_address, city_address),
        state_address = COALESCE(p_state_address, state_address),
        zip_address = COALESCE(p_zip_address, zip_address)
    WHERE 
        id = p_id AND is_active = TRUE;
END //

DELIMITER ;


DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateParentInvite`(
    IN p_email VARCHAR(255),
    IN p_invite_id VARCHAR(255),
    IN p_parent_id INT,
    IN p_time_stamp VARCHAR(255)
)
BEGIN
    UPDATE parent_invite_info
    SET 
        invite_id = COALESCE(p_invite_id, invite_id),
        parent_id = COALESCE(p_parent_id, parent_id),
        time_stamp = COALESCE(p_time_stamp, time_stamp)
    WHERE 
        invite_email = p_email;
END //

DELIMITER ;

DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateParentInfoPassword`(
    IN p_parent_id INT,
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    UPDATE parent_info
    SET 
        email = COALESCE(p_email, email),
        password = COALESCE(p_password, password)
    WHERE 
        parent_id = p_parent_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE spGetStudentAllDetails(
    IN p_childId INT
)
BEGIN
    
SELECT c.child_id,
    c.child_first_name,
    c.child_last_name,
    c.dob,
    cd.class_name,
    cp.id AS care_provider_id,
    cp.name AS care_provider_name,
    d.id AS dentist_id,
    d.name AS dentist_name,
    p1.parent_name,
    p1.email AS primary_parent_email,
    p1.street_address AS parent_street_address,
    p1.city_address AS parent_city_address,
    p1.state_address AS parent_state_address,
    p1.zip_address AS parent_zip_address,
    p1.home_telephone_number,
    p1.business_cell_number,
    p1.business_city_address,
    p1.business_name,
    p1.business_state_address,
    p1.business_street_address,
    p1.business_telephone_number,
    p1.business_zip_address,
    p1.home_cellphone_number,
    p1.work_hours_from,
    p1.work_hours_to,
    p2.parent_name AS parent_two_name,
    p2.email AS parent_email,
    p2.street_address AS parent_two_street_address,
    p2.city_address AS parent_two_city_address,
    p2.state_address AS parent_two_state_address,
    p2.zip_address AS parent_two_zip_address,
    p2.home_telephone_number AS parent_two_home_telephone_number,
    p2.business_cell_number AS parent_two_business_cell_number,
    p2.business_city_address AS parent_two_business_city_address,
    p2.business_name AS parent_two_business_name,
    p2.business_state_address AS parent_two_business_state_address,
    p2.business_street_address AS parent_two_business_street_address,
    p2.business_telephone_number AS parent_two_business_telephone_number,
    p2.business_zip_address AS parent_two_business_zip_address,
    p2.home_cellphone_number AS parent_two_home_cellphone_number,
    p2.work_hours_from AS parent_two_work_hours_from,
    p2.work_hours_to AS parent_two_work_hours_to,
    phb.welcome_goddard_agmt,
    phb.training_philosophy_agmt,
    phb.statement_confidentiality_agmt,
    phb.security_issue_agmt,
    phb.rest_time_agmt,
    phb.release_children_agmt,
    phb.registration_fees_agmt,
    phb.parent_sign parent_handbook_parent_sign,
    phb.parent_date parent_handbook_prent_date,
    phb.parent_access_agmt,
    phb.outside_engagements_agmt,
    phb.mission_statement_agmt,
    phb.medication_procedures_agmt,
    phb.health_policies_agmt,
    phb.general_information_agmt,
    phb.finalword_agmt,
    phb.expulsion_policy_agmt,
    phb.bring_school_agmt,
    phb.affiliation_policy_agmt,
    phb.admin_sign AS parent_handbook_admin_sign,
    phb.admin_date AS parent_handbook_admin_date,
    phb.addressing_individual_child_agmt,
    enf.admin_date AS enrollment_form_admin_date,
    enf.admin_sign AS enrollment_form_admin_sign,
    enf.enrollment_name,
    enf.full_day,
    enf.half_day,
    enf.parent_date AS enrollment_form_parent_date,
    enf.parent_sign AS enrollment_form_parent_sign,
    enf.point_eighteen_init,
    enf.point_eight_init,
    enf.point_eleven_init,
    enf.point_fifteen_initi,
    enf.point_five_init,
    enf.point_four_init,
    enf.point_fourteen_init,
    enf.point_nine_init,
    enf.point_one_field,
    enf.point_seven_init,
    enf.point_seventeen_init,
    enf.point_six_init,
    enf.point_sixteen_init,
    enf.point_ten_init,
    enf.point_thirteen_init,
    enf.point_three_ini,
    enf.point_twelve_init,
    enf.point_two_init,
    enf.schedule_date,
    enf.start_date,
    auf.admin_date AS auth_form_admin_date,
    auf.admin_sign AS auth_form_admin_sign,
    auf.bank_account,
    auf.bank_routing,
    auf.driver_license,
    auf.myself,
    auf.parent_date AS auth_form_parent_date,
    auf.parent_sign AS auth_form_parent_sign,
    auf.state,
    adf.able_to_walk,
    adf.above_info_is_correct,
    adf.accommodations,
    adf.additional_info,
    adf.additional_information,
    adf.admin_date,
    adf.admin_sign,
    adf.age_group_friends,
    adf.allergies,
    adf.allergies_reaction,
    adf.any_medication,
    adf.approve_social_media_post,
    adf.asthma,
    adf.birth_weight_lbs,
    adf.birth_weight_oz,
    adf.what_child_interests,
    adf.vision_problems,
    adf.toilet_trained,
    adf.things_used_home,
    adf.surgeries,
    adf.special_equipment,
    adf.special_diabilities,
    adf.social_media_post,
    adf.significant_periods,
    adf.serious_injuries_accidents,
    adf.seizures_convulsions,
    adf.security_release_policy_form,
    adf.school_age_child_school,
    adf.rheumatic_fever,
    adf.rest_routine,
    adf.restricted_diet_reason,
    adf.restricted_diet,
    adf.rest_middle_day,
    adf.relationship_with_sib,
    adf.relationship_with_mom,
    adf.relationship_with_dad,
    adf.relationship_extended_family,
    adf.reason_rest_middle_day,
    adf.reason_for_toilet_trained,
    adf.reason_for_childcare_before,
    adf.printed_social_media_post,
    adf.primary_language,
    adf.policy_number,
    adf.pick_up_time,
    adf.pick_up_password_form,
    adf.physical_exam_last_date,
    adf.photo_video_permission_form,
    adf.photo_permission_post,
    adf.photo_permission_electronic,
    adf.parent_sign_outside_waiver,
    adf.parent_sign,
    adf.parent_date,
    adf.other_siblings_name,
    adf.other_siblings_age,
    adf.nick_name,
    adf.neighborhood_friends,
    adf.med_technicians_med_transportation_waiver,
    adf.medical_other,
    adf.medical_transportation_waiver,
    adf.medication,
    adf.last_five_years_moved,
    adf.language_at_home,
    adf.important_fam_members,
    adf.immunization_instructions,
    adf.illness_in_pregnancy,
    adf.health_insurance,
    adf.health_policies,
    adf.hearing_problems,
    adf.high_fevers,
    adf.hospitalization,
    adf.hours_of_television_daily,
    adf.gender,
    adf.bleeding_problems,
    adf.bottle_fed,
    adf.breast_fed,
    adf.changes_home_situation,
    adf.childcare_before,
    adf.child_info_is_correct,
    adf.child_pick_up_password,
    adf.communicate_their_needs,
    adf.complications,
    adf.condition_of_newborn,
    adf.c_response_frustration,
    adf.custody_papers_apply,
    adf.dental_exam_last_date,
    adf.diabetes,
    adf.drop_off_time,
    adf.duration_of_pregnancy,
    adf.eat_own,
    adf.eat_own_reason,
    adf.educational_expectations_of_child,
    adf.emergency_medical_care,
    adf.epilepsy,
    adf.existing_illness_allergy,
    adf.explain_able_to_walk,
    adf.explain_communicate_their_needs,
    adf.explain_for_accommodations,
    adf.explain_for_any_medication,
    adf.explain_functioning_at_age,
    adf.explain_illness_allergy,
    adf.explain_significant_periods,
    adf.explain_special_equipment,
    adf.fam_celebrations,
    adf.fam_his_instructions,
    adf.fam_hist_allergies,
    adf.fam_hist_asthma,
    adf.fam_hist_diabetes,
    adf.fam_hist_epilepsy,
    adf.fam_hist_heart_problems,
    adf.fam_hist_high_blood_pressure,
    adf.fam_hist_hyperactivity,
    adf.fam_hist_no_illness,
    adf.fam_hist_tuberculosis,
    adf.fam_hist_vision_problems,
    adf.favorite_activities,
    adf.favorite_foods,
    adf.fears_conflicts,
    adf.first_aid_procedures,
    adf.frequent_ear_infections,
    adf.frequent_illnesses,
    adf.functioning_at_age,
    e1.emergency_id AS emergency_contact_one_id,
    e1.contact_name  AS emergency_contact_one_contact_name,
    e1.contact_relationship AS emergency_contact_one_contact_relationship,
    e1.contact_telephone_number AS emergency_contact_one_telephone_number,
    e1.street_address AS emergency_contact_one_street,
    e1.city_address AS emergency_contact_one_city,
    e1.state_address AS emergency_contact_one_state,
    e1.zip_address AS emergency_contact_one_zip,
    e2.emergency_id AS emergency_contact_two_id,
    e2.contact_name  AS emergency_contact_two_contact_name,
    e2.contact_relationship AS emergency_contact_two_contact_relationship,
    e2.contact_telephone_number AS emergency_contact_two_telephone_number,
    e2.street_address AS emergency_contact_two_street,
    e2.city_address AS emergency_contact_two_city,
    e2.state_address AS emergency_contact_two_state,
    e2.zip_address AS emergency_contact_two_zip,
    e3.emergency_id AS emergency_contact_three_id,
    e3.contact_name  AS emergency_contact_three_contact_name,
    e3.contact_relationship AS emergency_contact_three_contact_relationship,
    e3.contact_telephone_number AS emergency_contact_three_telephone_number,
    e3.street_address AS emergency_contact_three_street,
    e3.city_address AS emergency_contact_three_city,
    e3.state_address AS emergency_contact_three_state,
    e3.zip_address AS emergency_contact_three_zip
    
FROM child_info c
JOIN class_details cd ON c.class_id = cd.class_id
JOIN parent_info p1 ON c.parent_id = p1.parent_id
JOIN admission_form adf ON c.child_id = adf.child_id
JOIN parent_info p2 ON adf.additional_parent_id = p2.parent_id
JOIN dentist d ON adf.dentist_id = d.id
JOIN care_provider cp ON adf.care_provider_id = cp.id
JOIN emergency_details e1 ON adf.emergency_contact_first_id = e1.emergency_id
JOIN emergency_details e2 ON adf.emergency_contact_second_id = e2.emergency_id
JOIN emergency_details e3 ON adf.emergency_contact_third_id = e3.emergency_id
JOIN authorization_form auf ON c.child_id = auf.child_id
JOIN parent_handbook phb ON c.child_id = phb.child_id
JOIN enrollment_form enf ON c.child_id = enf.child_id
WHERE  c.child_id = p_childId AND c.is_active = 1;
END //

DELIMITER ;


ALTER TABLE `admission_form`
ADD COLUMN `emergency_contact_first_id` INT DEFAULT NULL,
ADD COLUMN `emergency_contact_second_id` INT DEFAULT NULL,
ADD COLUMN `emergency_contact_third_id` INT DEFAULT NULL,
ADD CONSTRAINT `emergency_contact_first`
    FOREIGN KEY (`emergency_contact_first_id`) REFERENCES `emergency_details` (`emergency_id`),
ADD CONSTRAINT `emergency_contact_second`
    FOREIGN KEY (`emergency_contact_second_id`) REFERENCES `emergency_details` (`emergency_id`),
ADD CONSTRAINT `fk_emergency_contact_third`
    FOREIGN KEY (`emergency_contact_third_id`) REFERENCES `emergency_details` (`emergency_id`);



DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateParentInfo`(
    IN p_parent_id INT,
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
    IN p_business_cell_number VARCHAR(20),
    IN p_password VARCHAR(255)
)
BEGIN
    UPDATE parent_info
    SET 
        parent_name = COALESCE(p_name,parent_name),
        email = COALESCE(p_email,email),
        street_address = COALESCE(p_street_address,street_address),
        city_address = COALESCE(p_city_address,city_address),
        state_address = COALESCE(p_state_address,state_address),
        zip_address = COALESCE(p_zip_address,zip_address),
        home_telephone_number = COALESCE(p_home_telephone_number,home_telephone_number),
        home_cellphone_number = COALESCE(p_home_cellphone_number,home_cellphone_number),
        business_name = COALESCE(p_business_name,business_name),
        work_hours_from = COALESCE(p_work_hours_from,work_hours_from),
        work_hours_to = COALESCE(p_work_hours_to,work_hours_to),
        business_telephone_number = COALESCE(p_business_telephone_number,business_telephone_number),
        business_street_address = COALESCE(p_business_street_address,business_street_address),
        business_city_address = COALESCE(p_business_city_address,business_city_address),
        business_state_address = COALESCE(p_business_state_address,business_state_address),
        business_zip_address = COALESCE(p_business_zip_address,business_zip_address),
        business_cell_number = COALESCE(p_business_cell_number,business_cell_number),
        password = COALESCE(p_password,password)
    WHERE parent_id = p_parent_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateParentHandbook`(
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
        welcome_goddard_agmt = COALESCE(p_welcome_goddard_agmt, welcome_goddard_agmt),
        mission_statement_agmt = COALESCE(p_mission_statement_agmt, mission_statement_agmt),
        general_information_agmt = COALESCE(p_general_information_agmt, general_information_agmt),
        statement_confidentiality_agmt = COALESCE(p_statement_confidentiality_agmt, statement_confidentiality_agmt),
        parent_access_agmt = COALESCE(p_parent_access_agmt, parent_access_agmt),
        release_children_agmt = COALESCE(p_release_children_agmt, release_children_agmt),
        registration_fees_agmt = COALESCE(p_registration_fees_agmt, registration_fees_agmt),
        outside_engagements_agmt = COALESCE(p_outside_engagements_agmt, outside_engagements_agmt),
        health_policies_agmt = COALESCE(p_health_policies_agmt, health_policies_agmt),
        medication_procedures_agmt = COALESCE(p_medication_procedures_agmt, medication_procedures_agmt),
        bring_school_agmt = COALESCE(p_bring_school_agmt, bring_school_agmt),
        rest_time_agmt = COALESCE(p_rest_time_agmt, rest_time_agmt),
        training_philosophy_agmt = COALESCE(p_training_philosophy_agmt, training_philosophy_agmt),
        affiliation_policy_agmt = COALESCE(p_affiliation_policy_agmt, affiliation_policy_agmt),
        security_issue_agmt = COALESCE(p_security_issue_agmt, security_issue_agmt),
        expulsion_policy_agmt = COALESCE(p_expulsion_policy_agmt, expulsion_policy_agmt),
        addressing_individual_child_agmt = COALESCE(p_addressing_individual_child_agmt, addressing_individual_child_agmt),
        finalword_agmt = COALESCE(p_finalword_agmt, finalword_agmt),
        parent_sign = COALESCE(p_parent_sign, parent_sign),
        admin_sign = COALESCE(p_admin_sign, admin_sign)
    WHERE 
        child_id = p_child_id AND is_active = TRUE;
END //

DELIMITER ;


DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateFormInfo`(
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
        main_topic = COALESCE(p_main_topic, main_topic),
        sub_topic_one = COALESCE(p_sub_topic_one, sub_topic_one),
        sub_topic_two = COALESCE(p_sub_topic_two, sub_topic_two),
        sub_topic_three = COALESCE(p_sub_topic_three, sub_topic_three),
        sub_topic_four = COALESCE(p_sub_topic_four, sub_topic_four),
        sub_topic_five = COALESCE(p_sub_topic_five, sub_topic_five),
        sub_topic_six = COALESCE(p_sub_topic_six, sub_topic_six),
        sub_topic_seven = COALESCE(p_sub_topic_seven, sub_topic_seven),
        sub_topic_eight = COALESCE(p_sub_topic_eight, sub_topic_eight),
        sub_topic_nine = COALESCE(p_sub_topic_nine, sub_topic_nine),
        sub_topic_ten = COALESCE(p_sub_topic_ten, sub_topic_ten),
        sub_topic_eleven = COALESCE(p_sub_topic_eleven, sub_topic_eleven),
        sub_topic_twelve = COALESCE(p_sub_topic_twelve, sub_topic_twelve),
        sub_topic_thirteen = COALESCE(p_sub_topic_thirteen, sub_topic_thirteen),
        sub_topic_fourteen = COALESCE(p_sub_topic_fourteen, sub_topic_fourteen),
        sub_topic_fifteen = COALESCE(p_sub_topic_fifteen, sub_topic_fifteen),
        sub_topic_sixteen = COALESCE(p_sub_topic_sixteen, sub_topic_sixteen),
        sub_topic_seventeen = COALESCE(p_sub_topic_seventeen, sub_topic_seventeen),
        sub_topic_eighteen = COALESCE(p_sub_topic_eighteen, sub_topic_eighteen),
        form_type = COALESCE(p_form_type, form_type),
        form_status = COALESCE(p_form_status, form_status)
    WHERE 
        form_id = p_form_id AND is_active = TRUE;
END //

DELIMITER ;


DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateEnrollmentForm`(
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
        enrollment_name = COALESCE(p_enrollmentName, enrollment_name),
        point_one_field = COALESCE(p_pointOneField, point_one_field),
        point_two_init = COALESCE(p_pointTwoInit, point_two_init),
        point_three_ini = COALESCE(p_pointThreeIni, point_three_ini),
        point_four_init = COALESCE(p_pointFourInit, point_four_init),
        point_five_init = COALESCE(p_pointFiveInit, point_five_init),
        point_six_init = COALESCE(p_pointSixInit, point_six_init),
        point_seven_init = COALESCE(p_pointSevenInit, point_seven_init),
        point_eight_init = COALESCE(p_pointEightInit, point_eight_init),
        point_nine_init = COALESCE(p_pointNineInit, point_nine_init),
        point_ten_init = COALESCE(p_pointTenInit, point_ten_init),
        point_eleven_init = COALESCE(p_pointElevenInit, point_eleven_init),
        point_twelve_init = COALESCE(p_pointTwelveInit, point_twelve_init),
        point_thirteen_init = COALESCE(p_pointThirteenInit, point_thirteen_init),
        point_fourteen_init = COALESCE(p_pointFourteenInit, point_fourteen_init),
        point_fifteen_initi = COALESCE(p_pointFifteenIniti, point_fifteen_initi),
        point_sixteen_init = COALESCE(p_pointSixteenInit, point_sixteen_init),
        point_seventeen_init = COALESCE(p_pointSeventeenInit, point_seventeen_init),
        point_eighteen_init = COALESCE(p_pointEighteenInit, point_eighteen_init),
        start_date = COALESCE(p_startDate, start_date),
        schedule_date = COALESCE(p_scheduleDate, schedule_date),
        full_day = COALESCE(p_fullDay, full_day),
        half_day = COALESCE(p_halfDay, half_day),
        parent_sign = COALESCE(p_parentSign, parent_sign),
        admin_sign = COALESCE(p_adminSign, admin_sign)
    WHERE 
        child_id = p_childId AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateEmergencyDetail`(
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
        contact_name = COALESCE(p_contact_name, contact_name),
        contact_relationship = COALESCE(p_contact_relationship, contact_relationship),
        street_address = COALESCE(p_street_address, street_address),
        city_address = COALESCE(p_city_address, city_address),
        state_address = COALESCE(p_state_address, state_address),
        zip_address = COALESCE(p_zip_address, zip_address),
        contact_telephone_number = COALESCE(p_contact_telephone_number, contact_telephone_number)
    WHERE 
        emergency_id = p_emergency_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateEmergencyContact`(
    IN p_old_emergency_id INT,
    IN p_old_child_id INT,
    IN p_new_emergency_id INT,
    IN p_new_child_id INT
)
BEGIN
    UPDATE emergency_contact
    SET 
        emergency_id = COALESCE(p_new_emergency_id, emergency_id),
        child_id = COALESCE(p_new_child_id, child_id)
    WHERE 
        emergency_id = p_old_emergency_id 
        AND child_id = p_old_child_id 
        AND is_active = TRUE;
END //

DELIMITER ;


DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateChildInfo`(
    IN p_child_id INT,
    IN p_parent_id VARCHAR(255),
    IN p_class_id INT,
    IN p_child_first_name VARCHAR(100),
    IN p_child_last_name VARCHAR(100),
    IN p_dob DATE
)
BEGIN
    UPDATE child_info
    SET 
        parent_id = COALESCE(p_parent_id, parent_id),
        class_id = COALESCE(p_class_id, class_id),
        child_first_name = COALESCE(p_child_first_name, child_first_name),
        child_last_name = COALESCE(p_child_last_name, child_last_name),
        dob = COALESCE(p_dob, dob)
    WHERE 
        child_id = p_child_id AND is_active = TRUE;
END //

DELIMITER ;



DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateCareProvider`(
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
        name = COALESCE(p_name, name),
        telephone_number = COALESCE(p_telephone_number, telephone_number),
        hospital_affiliation = COALESCE(p_hospital_affiliation, hospital_affiliation),
        street_address = COALESCE(p_street_address, street_address),
        city_address = COALESCE(p_city_address, city_address),
        state_address = COALESCE(p_state_address, state_address),
        zip_address = COALESCE(p_zip_address, zip_address)
    WHERE 
        id = p_id AND is_active = TRUE;
END //

DELIMITER ;



DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateAuthorizationForm`(
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
        bank_routing = COALESCE(p_bankRouting, bank_routing),
        bank_account = COALESCE(p_bankAccount, bank_account),
        driver_license = COALESCE(p_driverLicense, driver_license),
        state = COALESCE(p_state, state),
        myself = COALESCE(p_myself, myself),
        parent_sign = COALESCE(p_parentSign, parent_sign),
        admin_sign = COALESCE(p_adminSign, admin_sign)
    WHERE 
        child_id = p_childId AND is_active = TRUE;
END //

DELIMITER ;




DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateAdminInfo`(
    IN p_email_id VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_designation VARCHAR(255),
    IN p_apporved_by VARCHAR(255)
)
BEGIN
    UPDATE admin_info
    SET 
        password = COALESCE(p_password, password),
        designation = COALESCE(p_designation, designation),
        apporved_by = COALESCE(p_apporved_by, apporved_by)
    WHERE 
        email_id = p_email_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateAdmissionForm`(
    IN p_child_id INT,
    IN p_additional_parent_id INT,
    IN p_care_provider_id INT,
    IN p_dentist_id INT,
    IN p_nick_name VARCHAR(100),
    IN p_primary_language VARCHAR(50),
    IN p_school_age_child_school VARCHAR(100),
    IN p_custody_papers_apply BOOLEAN,
    IN p_gender VARCHAR(10),
    IN p_special_diabilities TEXT,
    IN p_allergies_reaction TEXT,
    IN p_additional_info TEXT,
    IN p_medication TEXT,
    IN p_health_insurance TEXT,
    IN p_policy_number VARCHAR(100),
    IN p_emergency_medical_care TEXT,
    IN p_first_aid_procedures TEXT,
    IN p_above_info_is_correct BOOLEAN,
    IN p_physical_exam_last_date DATE,
    IN p_dental_exam_last_date DATE,
    IN p_allergies TEXT,
    IN p_asthma TEXT,
    IN p_bleeding_problems TEXT,
    IN p_diabetes TEXT,
    IN p_epilepsy TEXT,
    IN p_frequent_ear_infections TEXT,
    IN p_frequent_illnesses TEXT,
    IN p_hearing_problems TEXT,
    IN p_high_fevers TEXT,
    IN p_hospitalization TEXT,
    IN p_rheumatic_fever TEXT,
    IN p_seizures_convulsions TEXT,
    IN p_serious_injuries_accidents TEXT,
    IN p_surgeries TEXT,
    IN p_vision_problems TEXT,
    IN p_medical_other TEXT,
    IN p_illness_in_pregnancy TEXT,
    IN p_condition_of_newborn TEXT,
    IN p_duration_of_pregnancy TEXT,
    IN p_birth_weight_lbs VARCHAR(50),
    IN p_birth_weight_oz VARCHAR(50),
    IN p_complications TEXT,
    IN p_bottle_fed VARCHAR(50),
    IN p_breast_fed VARCHAR(50),
    IN p_other_siblings_name VARCHAR(100),
    IN p_other_siblings_age VARCHAR(50),
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
    IN p_age_group_friends VARCHAR(100),
    IN p_neighborhood_friends VARCHAR(100),
    IN p_relationship_with_mom VARCHAR(100),
    IN p_relationship_with_dad VARCHAR(100),
    IN p_relationship_with_sib VARCHAR(100),
    IN p_relationship_extended_family VARCHAR(100),
    IN p_fears_conflicts TEXT,
    IN p_c_response_frustration TEXT,
    IN p_favorite_activities TEXT,
    IN p_last_five_years_moved BOOLEAN,
    IN p_things_used_home VARCHAR(100),
    IN p_hours_of_television_daily VARCHAR(50),
    IN p_language_at_home VARCHAR(50),
    IN p_changes_home_situation BOOLEAN,
    IN p_educational_expectations_of_child TEXT,
    IN p_fam_his_instructions BOOLEAN,
    IN p_immunization_instructions BOOLEAN,
    IN p_important_fam_members VARCHAR(100),
    IN p_fam_celebrations VARCHAR(100),
    IN p_childcare_before BOOLEAN,
    IN p_reason_for_childcare_before TEXT,
    IN p_what_child_interests TEXT,
    IN p_drop_off_time VARCHAR(100),
    IN p_pick_up_time VARCHAR(100),
    IN p_restricted_diet BOOLEAN,
    IN p_restricted_diet_reason TEXT,
    IN p_eat_own BOOLEAN,
    IN p_eat_own_reason TEXT,
    IN p_favorite_foods TEXT,
    IN p_rest_middle_day BOOLEAN,
    IN p_reason_rest_middle_day TEXT,
    IN p_rest_routine TEXT,
    IN p_toilet_trained BOOLEAN,
    IN p_reason_for_toilet_trained TEXT,
    IN p_existing_illness_allergy BOOLEAN,
    IN p_explain_illness_allergy TEXT,
    IN p_functioning_at_age BOOLEAN,
    IN p_explain_functioning_at_age TEXT,
    IN p_able_to_walk BOOLEAN,
    IN p_explain_able_to_walk TEXT,
    IN p_communicate_their_needs BOOLEAN,
    IN p_explain_communicate_their_needs TEXT,
    IN p_any_medication BOOLEAN,
    IN p_explain_for_any_medication TEXT,
    IN p_special_equipment BOOLEAN,
    IN p_explain_special_equipment TEXT,
    IN p_significant_periods BOOLEAN,
    IN p_explain_significant_periods TEXT,
    IN p_accommodations BOOLEAN,
    IN p_explain_for_accommodations TEXT,
    IN p_additional_information TEXT,
    IN p_child_info_is_correct BOOLEAN,
    IN p_child_pick_up_password VARCHAR(100),
    IN p_pick_up_password_form BOOLEAN,
    IN p_photo_video_permission_form TEXT,
    IN p_photo_permission_electronic BOOLEAN,
    IN p_photo_permission_post BOOLEAN,
    IN p_security_release_policy_form BOOLEAN,
    IN p_med_technicians_med_transportation_waiver TEXT,
    IN p_medical_transportation_waiver BOOLEAN,
    IN p_health_policies BOOLEAN,
    IN p_parent_sign_outside_waiver BOOLEAN,
    IN p_approve_social_media_post BOOLEAN,
    IN p_printed_social_media_post VARCHAR(100),
    IN p_social_media_post BOOLEAN,
    IN p_parent_sign VARCHAR(100),
    IN p_admin_sign VARCHAR(100),
    IN p_emergency_contact_first_id INT,
    IN p_emergency_contact_second_id INT,
    IN p_emergency_contact_third_id INT
)
BEGIN
    INSERT INTO admission_form (
        child_id, additional_parent_id, care_provider_id, dentist_id, nick_name, primary_language, school_age_child_school, 
        custody_papers_apply, gender, special_diabilities, allergies_reaction, additional_info, medication, health_insurance, 
        policy_number, emergency_medical_care, first_aid_procedures, above_info_is_correct, physical_exam_last_date, 
        dental_exam_last_date, allergies, asthma, bleeding_problems, diabetes, epilepsy, frequent_ear_infections, 
        frequent_illnesses, hearing_problems, high_fevers, hospitalization, rheumatic_fever, seizures_convulsions, 
        serious_injuries_accidents, surgeries, vision_problems, medical_other, illness_in_pregnancy, condition_of_newborn, 
        duration_of_pregnancy, birth_weight_lbs, birth_weight_oz, complications, bottle_fed, breast_fed, other_siblings_name, 
        other_siblings_age, fam_hist_allergies, fam_hist_heart_problems, fam_hist_tuberculosis, fam_hist_asthma, 
        fam_hist_high_blood_pressure, fam_hist_vision_problems, fam_hist_diabetes, fam_hist_hyperactivity, fam_hist_epilepsy, 
        fam_hist_no_illness, age_group_friends, neighborhood_friends, relationship_with_mom, relationship_with_dad, 
        relationship_with_sib, relationship_extended_family, fears_conflicts, c_response_frustration, favorite_activities, 
        last_five_years_moved, things_used_home, hours_of_television_daily, language_at_home, changes_home_situation, 
        educational_expectations_of_child, fam_his_instructions, immunization_instructions, important_fam_members, 
        fam_celebrations, childcare_before, reason_for_childcare_before, what_child_interests, drop_off_time, pick_up_time, 
        restricted_diet, restricted_diet_reason, eat_own, eat_own_reason, favorite_foods, rest_middle_day, 
        reason_rest_middle_day, rest_routine, toilet_trained, reason_for_toilet_trained, existing_illness_allergy, 
        explain_illness_allergy, functioning_at_age, explain_functioning_at_age, able_to_walk, explain_able_to_walk, 
        communicate_their_needs, explain_communicate_their_needs, any_medication, explain_for_any_medication, 
        special_equipment, explain_special_equipment, significant_periods, explain_significant_periods, accommodations, 
        explain_for_accommodations, additional_information, child_info_is_correct, child_pick_up_password, pick_up_password_form, 
        photo_video_permission_form, photo_permission_electronic, photo_permission_post, security_release_policy_form, 
        med_technicians_med_transportation_waiver, medical_transportation_waiver, health_policies, parent_sign_outside_waiver, 
        approve_social_media_post, printed_social_media_post, social_media_post, parent_sign, admin_sign, emergency_contact_first_id, emergency_contact_second_id, emergency_contact_third_id, is_active
    ) VALUES (
        p_child_id, p_additional_parent_id, p_care_provider_id, p_dentist_id, p_nick_name, p_primary_language, 
        p_school_age_child_school, p_custody_papers_apply, p_gender, p_special_diabilities, p_allergies_reaction, 
        p_additional_info, p_medication, p_health_insurance, p_policy_number, p_emergency_medical_care, p_first_aid_procedures, 
        p_above_info_is_correct, p_physical_exam_last_date, p_dental_exam_last_date, p_allergies, p_asthma, 
        p_bleeding_problems, p_diabetes, p_epilepsy, p_frequent_ear_infections, p_frequent_illnesses, p_hearing_problems, 
        p_high_fevers, p_hospitalization, p_rheumatic_fever, p_seizures_convulsions, p_serious_injuries_accidents, p_surgeries, 
        p_vision_problems, p_medical_other, p_illness_in_pregnancy, p_condition_of_newborn, p_duration_of_pregnancy, 
        p_birth_weight_lbs, p_birth_weight_oz, p_complications, p_bottle_fed, p_breast_fed, p_other_siblings_name, 
        p_other_siblings_age, p_fam_hist_allergies, p_fam_hist_heart_problems, p_fam_hist_tuberculosis, p_fam_hist_asthma, 
        p_fam_hist_high_blood_pressure, p_fam_hist_vision_problems, p_fam_hist_diabetes, p_fam_hist_hyperactivity, p_fam_hist_epilepsy, 
        p_fam_hist_no_illness, p_age_group_friends, p_neighborhood_friends, p_relationship_with_mom, p_relationship_with_dad, 
        p_relationship_with_sib, p_relationship_extended_family, p_fears_conflicts, p_c_response_frustration, p_favorite_activities, 
        p_last_five_years_moved, p_things_used_home, p_hours_of_television_daily, p_language_at_home, p_changes_home_situation, 
        p_educational_expectations_of_child, p_fam_his_instructions, p_immunization_instructions, p_important_fam_members, 
        p_fam_celebrations, p_childcare_before, p_reason_for_childcare_before, p_what_child_interests, p_drop_off_time, 
        p_pick_up_time, p_restricted_diet, p_restricted_diet_reason, p_eat_own, p_eat_own_reason, p_favorite_foods, 
        p_rest_middle_day, p_reason_rest_middle_day, p_rest_routine, p_toilet_trained, p_reason_for_toilet_trained, 
        p_existing_illness_allergy, p_explain_illness_allergy, p_functioning_at_age, p_explain_functioning_at_age, p_able_to_walk, 
        p_explain_able_to_walk, p_communicate_their_needs, p_explain_communicate_their_needs, p_any_medication, 
        p_explain_for_any_medication, p_special_equipment, p_explain_special_equipment, p_significant_periods, 
        p_explain_significant_periods, p_accommodations, p_explain_for_accommodations, p_additional_information, 
        p_child_info_is_correct, p_child_pick_up_password, p_pick_up_password_form, p_photo_video_permission_form, 
        p_photo_permission_electronic, p_photo_permission_post, p_security_release_policy_form, 
        p_med_technicians_med_transportation_waiver, p_medical_transportation_waiver, p_health_policies, p_parent_sign_outside_waiver, 
        p_approve_social_media_post, p_printed_social_media_post, p_social_media_post, p_parent_sign, p_admin_sign, p_emergency_contact_first_id, p_emergency_contact_second_id, p_emergency_contact_third_id, TRUE
    );
END //

DELIMITER ;

DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateAdmissionForm`(
    IN p_child_id INT,
    IN p_additional_parent_id VARCHAR(255),
    IN p_care_provider_id INT,
    IN p_dentist_id INT,
    IN p_nick_name VARCHAR(255),
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
    IN p_drop_off_time VARCHAR(100),
    IN p_pick_up_time VARCHAR(100),
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
    IN p_admin_sign VARCHAR(255),
    IN p_emergency_contact_first_id INT,
    IN p_emergency_contact_second_id INT,
    IN p_emergency_contact_third_id INT
)
BEGIN
    UPDATE admission_form
    SET 
        additional_parent_id = COALESCE(p_additional_parent_id,additional_parent_id),
        care_provider_id = COALESCE(p_care_provider_id,care_provider_id),
        dentist_id = COALESCE(p_dentist_id,dentist_id),
        nick_name = COALESCE(p_nick_name,nick_name),
        primary_language = COALESCE(p_primary_language, primary_language),
        school_age_child_school = COALESCE(p_school_age_child_school,school_age_child_school),
        custody_papers_apply = COALESCE(p_custody_papers_apply,custody_papers_apply),
        gender = COALESCE(p_gender,gender),
        special_diabilities = COALESCE(p_special_diabilities,special_diabilities),
        allergies_reaction = COALESCE(p_allergies_reaction,allergies_reaction),
        additional_info = COALESCE(p_additional_info,additional_info),
        medication = COALESCE(p_medication,medication),
        health_insurance = COALESCE(p_health_insurance,health_insurance),
        policy_number = COALESCE(p_policy_number,policy_number),
        emergency_medical_care = COALESCE(p_emergency_medical_care,emergency_medical_care),
        first_aid_procedures = COALESCE(p_first_aid_procedures,first_aid_procedures),
        above_info_is_correct = COALESCE(p_above_info_is_correct,above_info_is_correct),
        physical_exam_last_date = COALESCE(p_physical_exam_last_date,physical_exam_last_date),
        dental_exam_last_date = COALESCE(p_dental_exam_last_date,dental_exam_last_date),
        allergies = COALESCE(p_allergies,allergies),
        asthma = COALESCE(p_asthma,asthma),
        bleeding_problems = COALESCE(p_bleeding_problems,bleeding_problems),
        diabetes = COALESCE(p_diabetes,diabetes),
        epilepsy = COALESCE(p_epilepsy,epilepsy),
        frequent_ear_infections = COALESCE(p_frequent_ear_infections,frequent_ear_infections),
        frequent_illnesses = COALESCE(p_frequent_illnesses,frequent_illnesses),
        hearing_problems = COALESCE(p_hearing_problems,hearing_problems),
        high_fevers = COALESCE(p_high_fevers,high_fevers),
        hospitalization = COALESCE(p_hospitalization,hospitalization),
        rheumatic_fever = COALESCE(p_rheumatic_fever,rheumatic_fever),
        seizures_convulsions = COALESCE(p_seizures_convulsions,seizures_convulsions),
        serious_injuries_accidents = COALESCE(p_serious_injuries_accidents,serious_injuries_accidents),
        surgeries = COALESCE(p_surgeries,surgeries),
        vision_problems = COALESCE(p_vision_problems,vision_problems),
        medical_other = COALESCE(p_medical_other,medical_other),
        illness_in_pregnancy = COALESCE(p_illness_in_pregnancy,illness_in_pregnancy),
        condition_of_newborn = COALESCE(p_condition_of_newborn,condition_of_newborn),
        duration_of_pregnancy = COALESCE(p_duration_of_pregnancy,duration_of_pregnancy),
        birth_weight_lbs = COALESCE(p_birth_weight_lbs,birth_weight_lbs),
        birth_weight_oz = COALESCE(p_birth_weight_oz,birth_weight_oz),
        complications = COALESCE(p_complications,complications),
        bottle_fed = COALESCE(p_bottle_fed,bottle_fed),
        breast_fed = COALESCE(p_breast_fed,breast_fed),
        other_siblings_name = COALESCE(p_other_siblings_name,other_siblings_name),
        other_siblings_age = COALESCE(p_other_siblings_age,other_siblings_age),
        fam_hist_allergies = COALESCE(p_fam_hist_allergies,fam_hist_allergies),
        fam_hist_heart_problems = COALESCE(p_fam_hist_heart_problems,fam_hist_heart_problems),
        fam_hist_tuberculosis = COALESCE(p_fam_hist_tuberculosis,fam_hist_tuberculosis),
        fam_hist_asthma = COALESCE(p_fam_hist_asthma,fam_hist_asthma),
        fam_hist_high_blood_pressure = COALESCE(p_fam_hist_high_blood_pressure,fam_hist_high_blood_pressure),
        fam_hist_vision_problems = COALESCE(p_fam_hist_vision_problems,fam_hist_vision_problems),
        fam_hist_diabetes = COALESCE(p_fam_hist_diabetes,fam_hist_diabetes),
        fam_hist_hyperactivity = COALESCE(p_fam_hist_hyperactivity,fam_hist_hyperactivity),
        fam_hist_epilepsy = COALESCE(p_fam_hist_epilepsy,fam_hist_epilepsy),
        fam_hist_no_illness = COALESCE(p_fam_hist_no_illness,fam_hist_no_illness),
        age_group_friends = COALESCE(p_age_group_friends,age_group_friends),
        neighborhood_friends = COALESCE(p_neighborhood_friends,neighborhood_friends),
        relationship_with_mom = COALESCE(p_relationship_with_mom,relationship_with_mom),
        relationship_with_dad = COALESCE(p_relationship_with_dad,relationship_with_dad),
        relationship_with_sib = COALESCE(p_relationship_with_sib,relationship_with_sib),
        relationship_extended_family = COALESCE(p_relationship_extended_family,relationship_extended_family),
        fears_conflicts = COALESCE(p_fears_conflicts,fears_conflicts),
        c_response_frustration = COALESCE(p_c_response_frustration,c_response_frustration),
        favorite_activities = COALESCE(p_favorite_activities,favorite_activities),
        last_five_years_moved = COALESCE(p_last_five_years_moved,last_five_years_moved),
        things_used_home = COALESCE(p_things_used_home,things_used_home),
        hours_of_television_daily = COALESCE(p_hours_of_television_daily,hours_of_television_daily),
        language_at_home = COALESCE(p_language_at_home,language_at_home),
        changes_home_situation = COALESCE(p_changes_home_situation,changes_home_situation),
        educational_expectations_of_child = COALESCE(p_educational_expectations_of_child,educational_expectations_of_child),
        fam_his_instructions =COALESCE(p_fam_his_instructions,fam_his_instructions),
        immunization_instructions = COALESCE(p_immunization_instructions,immunization_instructions),
        important_fam_members = COALESCE(p_important_fam_members,important_fam_members),
        fam_celebrations = COALESCE(p_fam_celebrations,fam_celebrations),
        childcare_before = COALESCE(p_childcare_before,childcare_before),
        reason_for_childcare_before = COALESCE(p_reason_for_childcare_before,reason_for_childcare_before),
        what_child_interests = COALESCE(p_what_child_interests,what_child_interests),
        drop_off_time = COALESCE(p_drop_off_time,drop_off_time),
        pick_up_time = COALESCE(p_pick_up_time,pick_up_time),
        restricted_diet = COALESCE(p_restricted_diet,restricted_diet),
        restricted_diet_reason = COALESCE(p_restricted_diet_reason,restricted_diet_reason),
        eat_own = COALESCE(p_eat_own,eat_own),
        eat_own_reason = COALESCE(p_eat_own_reason,eat_own_reason),
        favorite_foods = COALESCE(p_favorite_foods,favorite_foods),
        rest_middle_day = COALESCE(p_rest_middle_day,rest_middle_day),
        reason_rest_middle_day = COALESCE(p_reason_rest_middle_day,reason_rest_middle_day),
        rest_routine = COALESCE(p_rest_routine,rest_routine),
        toilet_trained = COALESCE(p_toilet_trained,toilet_trained),
        reason_for_toilet_trained = COALESCE(p_reason_for_toilet_trained,reason_for_toilet_trained),
        existing_illness_allergy = COALESCE(p_existing_illness_allergy,existing_illness_allergy),
        explain_illness_allergy = COALESCE(p_explain_illness_allergy,explain_illness_allergy),
        functioning_at_age = COALESCE(p_functioning_at_age,functioning_at_age),
        explain_functioning_at_age = COALESCE(p_explain_functioning_at_age,explain_functioning_at_age),
        able_to_walk = COALESCE(p_able_to_walk,able_to_walk),
        explain_able_to_walk = COALESCE(p_explain_able_to_walk,explain_able_to_walk),
        communicate_their_needs = COALESCE(p_communicate_their_needs,communicate_their_needs),
        explain_communicate_their_needs = COALESCE(p_explain_communicate_their_needs,explain_communicate_their_needs),
        any_medication = COALESCE(p_any_medication,any_medication),
        explain_for_any_medication = COALESCE(p_explain_for_any_medication,explain_for_any_medication),
        special_equipment = COALESCE(p_special_equipment,special_equipment),
        explain_special_equipment = COALESCE(p_explain_special_equipment,explain_special_equipment),
        significant_periods = COALESCE(p_significant_periods,significant_periods),
        explain_significant_periods = COALESCE(p_explain_significant_periods,explain_significant_periods),
        accommodations = COALESCE(p_accommodations,accommodations),
        explain_for_accommodations = COALESCE(p_explain_for_accommodations,explain_for_accommodations),
        additional_information = COALESCE(p_additional_information,additional_information),
        child_info_is_correct = COALESCE(p_child_info_is_correct,child_info_is_correct),
        child_pick_up_password = COALESCE(p_child_pick_up_password,child_pick_up_password),
        pick_up_password_form = COALESCE(p_pick_up_password_form,pick_up_password_form),
        photo_video_permission_form = COALESCE(p_photo_video_permission_form,photo_video_permission_form),
        photo_permission_electronic = COALESCE(p_photo_permission_electronic,photo_permission_electronic),
        photo_permission_post = COALESCE(p_photo_permission_post,photo_permission_post),
        security_release_policy_form = COALESCE(p_security_release_policy_form,security_release_policy_form),
        med_technicians_med_transportation_waiver = COALESCE(p_med_technicians_med_transportation_waiver,med_technicians_med_transportation_waiver),
        medical_transportation_waiver = COALESCE(p_medical_transportation_waiver,medical_transportation_waiver),
        health_policies = COALESCE(p_health_policies,health_policies),
        parent_sign_outside_waiver = COALESCE(p_parent_sign_outside_waiver,parent_sign_outside_waiver),
        approve_social_media_post = COALESCE(p_approve_social_media_post,approve_social_media_post),
        printed_social_media_post = COALESCE(p_printed_social_media_post,printed_social_media_post),
        social_media_post = COALESCE(p_social_media_post,social_media_post),
        parent_sign = COALESCE(p_parent_sign,parent_sign),
        admin_sign = COALESCE(p_admin_sign,admin_sign),
        emergency_contact_first_id = COALESCE(p_emergency_contact_first_id,emergency_contact_first_id),
        emergency_contact_second_id = COALESCE(p_emergency_contact_second_id,emergency_contact_second_id),
        emergency_contact_third_id = COALESCE(p_emergency_contact_third_id,emergency_contact_third_id)
    WHERE 
        child_id = p_child_id AND is_active = TRUE;
END //

DELIMITER ;