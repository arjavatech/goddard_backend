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

