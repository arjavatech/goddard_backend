                                        --Goddard Database Stored Procedures--

--GetConsolidatedFormData
CREATE DEFINER=`admin`@`%` PROCEDURE `GetConsolidatedFormData`()
BEGIN
    DECLARE stateValue INT;
    DECLARE formId INT;
    DECLARE formName VARCHAR(255);

    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT form_id, form_name, state FROM form_repositary;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET @all_data = JSON_OBJECT();
    SET @active_data = JSON_OBJECT();
    SET @default_data = JSON_OBJECT();
    SET @available_data = JSON_OBJECT();
    SET @archive_data = JSON_OBJECT();

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO formId, formName, stateValue;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Add to all_data
        SET @all_data = JSON_MERGE_PATCH(@all_data, JSON_OBJECT(formName, formId));

        -- Add to active_data if state is 0
        IF stateValue = 0 THEN
            SET @default_data = JSON_MERGE_PATCH(@default_data, JSON_OBJECT(formName, formId));
        END IF;
        
        -- Add to default_data if state is not 0
        IF stateValue = 1 THEN
            SET @available_data = JSON_MERGE_PATCH(@available_data, JSON_OBJECT(formName, formId));
        END IF;
        
        IF stateValue = 2 THEN
            SET @active_data = JSON_MERGE_PATCH(@active_data, JSON_OBJECT(formName, formId));
        END IF;
        IF stateValue = 3 THEN
            SET @archive_data = JSON_MERGE_PATCH(@archive_data, JSON_OBJECT(formName, formId));
        END IF;
    END LOOP;

    CLOSE cur;

    SELECT JSON_OBJECT('all', @all_data, 'active', @active_data, 'default', @default_data, 'available', @available_data, 'archive', @archive_data) AS consolidated_form_data;
END

--spClassBasedChildCount
CREATE DEFINER=`admin`@`%` PROCEDURE `spClassBasedChildCount`(
	IN p_class_id  INT
    )
BEGIN
    SELECT COUNT(*) AS count FROM child_info
    WHERE 
        class_id = p_class_id AND is_active = TRUE;
END

--spClassBasedChildCountWithClassName
CREATE DEFINER=`admin`@`%` PROCEDURE `spClassBasedChildCountWithClassName`()
BEGIN
    SELECT class_details.class_id, class_details.class_name, 
           IFNULL(COUNT(child_info.child_id), 0) AS count
    FROM class_details
    LEFT JOIN child_info 
    ON class_details.class_id = child_info.class_id 
    AND child_info.is_active = TRUE
    WHERE class_details.is_active = TRUE
    GROUP BY class_details.class_id, class_details.class_name;
END

--spCreateAdminInfo
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateAdminInfo`(
    IN p_email_id VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_designation VARCHAR(255),
    IN p_apporved_by VARCHAR(255)
)
BEGIN
    INSERT INTO admin_info (email_id, password, designation, apporved_by, is_active)
    VALUES (p_email_id, p_password, p_designation, p_apporved_by, TRUE);
END

--spCreateAdmissionForm
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateAdmissionForm`(
    IN p_child_id INT,
    IN p_additional_parent_id INT,
    IN p_care_provider_id INT,
    IN p_dentist_id INT,
    IN p_dob DATE,
    IN p_nick_name VARCHAR(100),
    IN p_primary_language VARCHAR(50),
    IN p_school_age_child_school VARCHAR(100),
    IN p_custody_papers_apply INT,
    IN p_gender INT,
    IN p_special_diabilities TEXT,
    IN p_allergies_reaction TEXT,
    IN p_additional_info TEXT,
    IN p_medication TEXT,
    IN p_health_insurance TEXT,
    IN p_policy_number VARCHAR(100),
    IN p_emergency_medical_care TEXT,
    IN p_first_aid_procedures TEXT,
    IN p_above_info_is_correct VARCHAR(255),
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
    IN p_bottle_fed INT,
    IN p_breast_fed INT,
    IN p_other_siblings_name VARCHAR(100),
    IN p_other_siblings_age VARCHAR(50),
    IN p_fam_hist_allergies VARCHAR(255),
    IN p_fam_hist_heart_problems VARCHAR(255),
    IN p_fam_hist_tuberculosis VARCHAR(255),
    IN p_fam_hist_asthma VARCHAR(255),
    IN p_fam_hist_high_blood_pressure VARCHAR(255),
    IN p_fam_hist_vision_problems VARCHAR(255),
    IN p_fam_hist_diabetes VARCHAR(255),
    IN p_fam_hist_hyperactivity VARCHAR(255),
    IN p_fam_hist_epilepsy VARCHAR(255),
    IN p_fam_hist_no_illness VARCHAR(255),
    IN p_age_group_friends VARCHAR(100),
    IN p_neighborhood_friends VARCHAR(100),
    IN p_relationship_with_mom VARCHAR(100),
    IN p_relationship_with_dad VARCHAR(100),
    IN p_relationship_with_sib VARCHAR(100),
    IN p_relationship_extended_family VARCHAR(100),
    IN p_fears_conflicts TEXT,
    IN p_c_response_frustration TEXT,
    IN p_favorite_activities TEXT,
    IN p_last_five_years_moved VARCHAR(255),
    IN p_things_used_home VARCHAR(100),
    IN p_hours_of_television_daily VARCHAR(50),
    IN p_language_at_home VARCHAR(50),
    IN p_changes_home_situation VARCHAR(255),
    IN p_educational_expectations_of_child TEXT,
    IN p_fam_his_instructions VARCHAR(255),
    IN p_immunization_instructions VARCHAR(255),
    IN p_important_fam_members VARCHAR(100),
    IN p_fam_celebrations VARCHAR(100),
    IN p_childcare_before INT,
    IN p_reason_for_childcare_before TEXT,
    IN p_what_child_interests TEXT,
    IN p_drop_off_time VARCHAR(100),
    IN p_pick_up_time VARCHAR(100),
    IN p_restricted_diet INT,
    IN p_restricted_diet_reason TEXT,
    IN p_eat_own INT,
    IN p_eat_own_reason TEXT,
    IN p_favorite_foods TEXT,
    IN p_rest_middle_day INT,
    IN p_reason_rest_middle_day TEXT,
    IN p_rest_routine TEXT,
    IN p_toilet_trained INT,
    IN p_reason_for_toilet_trained TEXT,
    IN p_existing_illness_allergy INT,
    IN p_explain_illness_allergy TEXT,
    IN p_functioning_at_age INT,
    IN p_explain_functioning_at_age TEXT,
    IN p_explain_able_to_walk TEXT,
    IN p_able_to_walk INT,
    IN p_explain_communicate_their_needs TEXT,
    IN p_communicate_their_needs INT,
    IN p_any_medication INT,
    IN p_explain_for_any_medication TEXT,
    IN p_special_equipment INT,
    IN p_explain_special_equipment TEXT,
    IN p_significant_periods INT,
    IN p_explain_significant_periods TEXT,
    IN p_accommodations INT,
    IN p_explain_for_accommodations TEXT,
    IN p_additional_information TEXT,
    IN p_child_info_is_correct VARCHAR(255),
    IN p_child_pick_up_password VARCHAR(100),
    IN p_pick_up_password_form VARCHAR(255),
    IN p_photo_video_permission_form VARCHAR(255),
    IN p_photo_permission_electronic VARCHAR(255),
    IN p_photo_permission_post VARCHAR(255),
    IN p_security_release_policy_form VARCHAR(255),
    IN p_med_technicians_med_transportation_waiver TEXT,
    IN p_medical_transportation_waiver VARCHAR(255),
    IN p_health_policies VARCHAR(255),
    IN p_parent_sign_outside_waiver VARCHAR(255),
    IN p_approve_social_media_post INT,
    IN p_printed_social_media_post VARCHAR(100),
    IN p_social_media_post VARCHAR(255),
    IN p_parent_sign VARCHAR(100),
    IN p_admin_sign VARCHAR(100),
    IN p_emergency_contact_first_id INT,
    IN p_emergency_contact_second_id INT,
    IN p_emergency_contact_third_id INT,
    IN p_pointer INT,
    IN p_agree_all_above_info_is_correct VARCHAR(255),
    IN p_parent_sign_date_admission VARCHAR(255),
    IN p_admin_sign_date_admission VARCHAR(255)
)
BEGIN
    INSERT INTO admission_form (
        child_id, additional_parent_id, care_provider_id, dentist_id, dob, nick_name, primary_language, school_age_child_school, 
        do_relevant_custody_papers_apply, gender, special_diabilities, allergies_medication_reaction, additional_info, medication, health_insurance, 
        policy_number, obtaining_emergency_medical_care, administration_first_aid_procedures, agree_all_above_information_is_correct, physical_exam_last_date, 
        dental_exam_last_date, allergies, asthma, bleeding_problems, diabetes, epilepsy, frequent_ear_infections, 
        frequent_illnesses, hearing_problems, high_fevers, hospitalization, rheumatic_fever, seizures_convulsions, 
        serious_injuries_accidents, surgeries, vision_problems, medical_other, illness_during_pregnancy, condition_of_newborn, 
        duration_of_pregnancy, birth_weight_lbs, birth_weight_oz, complications, bottle_fed, breast_fed, other_siblings_name, 
        other_siblings_age, family_history_allergies, family_history_heart_problems, family_history_tuberculosis, family_history_asthma, 
        family_history_high_blood_pressure, family_history_vision_problems, family_history_diabetes, family_history_hyperactivity, family_history_epilepsy, 
        no_illnesses_for_this_child, age_group_friends, neighborhood_friends, relationship_with_mother, relationship_with_father, 
        relationship_with_siblings, relationship_with_extended_family, fears_conflicts, child_response_frustration, favorite_activities, 
        last_five_years_moved, things_used_at_home, hours_of_television_daily, language_used_at_home, changes_at_home_situation, 
        educational_expectations_of_child, fam_his_instructions, do_you_agree_this_immunization_instructions, important_fam_members, 
        about_family_celebrations, childcare_before, reason_for_childcare_before, what_child_interests, drop_off_time, pick_up_time, 
        restricted_diet, restricted_diet_reason, eat_own, eat_own_reason, favorite_foods, rest_in_the_middle_day, 
        reason_for_rest_in_the_middle_day, rest_routine, toilet_trained, reason_for_toilet_trained, explain_for_existing_illness_allergy, 
        existing_illness_allergy, functioning_at_age, explain_for_functioning_at_age, able_to_walk, explain_for_able_to_walk,
        explain_for_communicate_their_needs, communicate_their_needs, any_medication, explain_for_any_medication, 
        utilize_special_equipment, explain_for_utilize_special_equipment, significant_periods, explain_for_significant_periods, desire_any_accommodations, 
        explain_for_desire_any_accommodations, additional_information, do_you_agree_this, child_password_pick_up_password_form, do_you_agree_this_pick_up_password_form, 
        photo_usage_photo_video_permission_form, photo_permission_agree_group_photos_electronic, do_you_agree_this_photo_video_permission_form, security_release_policy_form, 
        med_technicians_med_transportation_waiver, medical_transportation_waiver, do_you_agree_this_health_policies, parent_sign_outside_waiver, 
        approve_social_media_post, printed_name_social_media_post, do_you_agree_this_social_media_post, parent_sign_admission, admin_sign_admission, emergency_contact_first_id, emergency_contact_second_id, emergency_contact_third_id, pointer, agree_all_above_info_is_correct, is_active, parent_sign_date_admission, admin_sign_date_admission
    ) VALUES (
        p_child_id, p_additional_parent_id, p_care_provider_id, p_dentist_id, p_dob, p_nick_name, p_primary_language, 
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
		p_explain_illness_allergy, p_existing_illness_allergy, p_functioning_at_age, p_explain_functioning_at_age, p_able_to_walk, 
        p_explain_able_to_walk, p_explain_communicate_their_needs, p_communicate_their_needs, p_any_medication, 
        p_explain_for_any_medication, p_special_equipment, p_explain_special_equipment, p_significant_periods, 
        p_explain_significant_periods, p_accommodations, p_explain_for_accommodations, p_additional_information, 
        p_child_info_is_correct, p_child_pick_up_password, p_pick_up_password_form, p_photo_video_permission_form, 
        p_photo_permission_electronic, p_photo_permission_post, p_security_release_policy_form, 
        p_med_technicians_med_transportation_waiver, p_medical_transportation_waiver, p_health_policies, p_parent_sign_outside_waiver, 
        p_approve_social_media_post, p_printed_social_media_post, p_social_media_post, p_parent_sign, p_admin_sign, p_emergency_contact_first_id, p_emergency_contact_second_id, p_emergency_contact_third_id, p_pointer, p_agree_all_above_info_is_correct,TRUE, p_parent_sign_date_admission, p_admin_sign_date_admission
    );
END

--spCreateAuthorizationForm
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateAuthorizationForm`(
    IN p_childId INT,
    IN p_bankRoutingAch VARCHAR(255),
    IN p_bankAccountAch VARCHAR(255),
    IN p_driverLicenseAch VARCHAR(255),
    IN p_stateAch VARCHAR(255),
    IN p_iAch VARCHAR(255),
    IN p_parentSignAch VARCHAR(255),
    IN p_adminSignAch VARCHAR(255),
    IN p_parent_sign_date_ach VARCHAR(255),
    IN p_admin_sign_date_ach VARCHAR(255)
)
BEGIN
    INSERT INTO authorization_form (
        child_id, bank_routing, bank_account, driver_license, state, 
        i, parent_sign_ach, admin_sign_ach, is_active, parent_sign_date_ach, admin_sign_date_ach
    ) VALUES (
        p_childId, p_bankRoutingAch, p_bankAccountAch, p_driverLicenseAch, p_stateAch, 
        p_iAch, p_parentSignAch, p_adminSignAch, TRUE, p_parent_sign_date_ach, p_admin_sign_date_ach
    );
END

--spCreateCareProvider
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateCareProvider`(
    IN p_child_care_provider_name VARCHAR(255),
    IN p_child_care_provider_telephone_number VARCHAR(20),
    IN p_child_hospital_affiliation VARCHAR(255),
    IN p_child_care_provider_street_address VARCHAR(255),
    IN p_child_care_provider_city_address VARCHAR(100),
    IN p_child_care_provider_state_address VARCHAR(50),
    IN p_child_care_provider_zip_address VARCHAR(12)
)
BEGIN
    INSERT INTO care_provider (
        child_care_provider_name,
        child_care_provider_telephone_number,
        child_hospital_affiliation,
        child_care_provider_street_address,
        child_care_provider_city_address,
        child_care_provider_state_address,
        child_care_provider_zip_address,
        is_active
    )
    VALUES (
        p_child_care_provider_name,
        p_child_care_provider_telephone_number,
        p_child_hospital_affiliation,
        p_child_care_provider_street_address,
        p_child_care_provider_city_address,
        p_child_care_provider_state_address,
        p_child_care_provider_zip_address,
        TRUE
    );
END

--spCreateCareProviderReturnId
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateCareProviderReturnId`(
    IN p_child_care_provider_name VARCHAR(255),
    IN p_child_care_provider_telephone_number VARCHAR(20),
    IN p_child_hospital_affiliation VARCHAR(255),
    IN p_child_care_provider_street_address VARCHAR(255),
    IN p_child_care_provider_city_address VARCHAR(100),
    IN p_child_care_provider_state_address VARCHAR(50),
    IN p_child_care_provider_zip_address VARCHAR(12),
    OUT p_child_care_provider_id INT         
)
BEGIN
    INSERT INTO care_provider (
        child_care_provider_name,
        child_care_provider_telephone_number,
        child_hospital_affiliation,
        child_care_provider_street_address,
        child_care_provider_city_address,
        child_care_provider_state_address,
        child_care_provider_zip_address,
        is_active
    )
    VALUES (
        p_child_care_provider_name,
        p_child_care_provider_telephone_number,
        p_child_hospital_affiliation,
        p_child_care_provider_street_address,
        p_child_care_provider_city_address,
        p_child_care_provider_state_address,
        p_child_care_provider_zip_address,
        TRUE
    );

    SET p_child_care_provider_id = LAST_INSERT_ID();
END

--spCreateChildInfo
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateChildInfo`(
    IN p_parent_id VARCHAR(255),
    IN p_class_id INT,
    IN p_child_first_name VARCHAR(100),
    IN p_child_last_name VARCHAR(100),
    OUT p_child_id INT
)
BEGIN
    INSERT INTO child_info (
        parent_id, class_id, child_first_name, child_last_name, is_active
    ) VALUES (
        p_parent_id, p_class_id, p_child_first_name, p_child_last_name, TRUE
    );
    
    -- Get the last inserted ID
    SET p_child_id = LAST_INSERT_ID();
END

--spCreateClass
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateClass`(
    IN p_className VARCHAR(255)
)
BEGIN
    INSERT INTO class_details (class_name, is_active)
    VALUES (p_className, TRUE);
END

--spCreateClassFormRepository
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateClassFormRepository`( 
    IN p_classId INT,
    IN p_formId INT
)
BEGIN
    INSERT INTO class_form_repository (class_id, form_id, is_active)
    VALUES (p_classId, p_formId, TRUE);
END

--spCreateDentist
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateDentist`(
    IN p_child_dentist_name VARCHAR(255),
    IN p_dentist_telephone_number VARCHAR(20),
    IN p_dentist_street_address VARCHAR(255),
    IN p_dentist_city_address VARCHAR(100),
    IN p_dentist_state_address VARCHAR(50),
    IN p_dentist_zip_address VARCHAR(12)
)
BEGIN
    INSERT INTO dentist (
        child_dentist_name, 
        dentist_telephone_number, 
        dentist_street_address, 
        dentist_city_address, 
        dentist_state_address, 
        dentist_zip_address, 
        is_active
    )
    VALUES (
        p_child_dentist_name, 
        p_dentist_telephone_number, 
        p_dentist_street_address, 
        p_dentist_city_address, 
        p_dentist_state_address, 
        p_dentist_zip_address, 
        TRUE
    );
END

--spCreateDentistReturnId
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateDentistReturnId`(
    IN p_child_dentist_name VARCHAR(255),
    IN p_dentist_telephone_number VARCHAR(20),
    IN p_dentist_street_address VARCHAR(255),
    IN p_dentist_city_address VARCHAR(100),
    IN p_dentist_state_address VARCHAR(50),
    IN p_dentist_zip_address VARCHAR(12),
    OUT p_child_dentist_id INT          
)
BEGIN
  
    INSERT INTO dentist (
        child_dentist_name, 
        dentist_telephone_number, 
        dentist_street_address, 
        dentist_city_address, 
        dentist_state_address, 
        dentist_zip_address, 
        is_active
    )
    VALUES (
        p_child_dentist_name, 
        p_dentist_telephone_number, 
        p_dentist_street_address, 
        p_dentist_city_address, 
        p_dentist_state_address, 
        p_dentist_zip_address, 
        TRUE
    );

    SET p_child_dentist_id = LAST_INSERT_ID();
END

--spCreateEmergencyDetail
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateEmergencyDetail`(
    IN p_child_emergency_contact_name VARCHAR(255),
    IN p_child_emergency_contact_relationship VARCHAR(255),
    IN p_child_emergency_contact_full_address VARCHAR(255),
    IN p_child_emergency_contact_city_address VARCHAR(255),
    IN p_child_emergency_contact_state_address VARCHAR(255),
    IN p_child_emergency_contact_zip_address VARCHAR(20),
    IN p_child_emergency_contact_telephone_number VARCHAR(20)
)
BEGIN
    INSERT INTO emergency_details (
        child_emergency_contact_name, 
        child_emergency_contact_relationship, 
        child_emergency_contact_full_address, 
        child_emergency_contact_city_address, 
        child_emergency_contact_state_address, 
        child_emergency_contact_zip_address, 
        child_emergency_contact_telephone_number, 
        is_active
    )
    VALUES (
        p_child_emergency_contact_name, 
        p_child_emergency_contact_relationship, 
        p_child_emergency_contact_full_address, 
        p_child_emergency_contact_city_address, 
        p_child_emergency_contact_state_address, 
        p_child_emergency_contact_zip_address, 
        p_child_emergency_contact_telephone_number, 
        TRUE
    );
END

--spCreateEmergencyDetailReturnId
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateEmergencyDetailReturnId`(
    IN p_child_emergency_contact_name VARCHAR(255),
    IN p_child_emergency_contact_relationship VARCHAR(255),
    IN p_child_emergency_contact_full_address VARCHAR(255),
    IN p_child_emergency_contact_city_address VARCHAR(255),
    IN p_child_emergency_contact_state_address VARCHAR(255),
    IN p_child_emergency_contact_zip_address VARCHAR(20),
    IN p_child_emergency_contact_telephone_number VARCHAR(20),
    OUT p_child_emergency_contact_id INT     
)
BEGIN
    INSERT INTO emergency_details (
        child_emergency_contact_name, 
        child_emergency_contact_relationship, 
        child_emergency_contact_full_address, 
        child_emergency_contact_city_address, 
        child_emergency_contact_state_address, 
        child_emergency_contact_zip_address, 
        child_emergency_contact_telephone_number, 
        is_active
    )
    VALUES (
        p_child_emergency_contact_name, 
        p_child_emergency_contact_relationship, 
        p_child_emergency_contact_full_address, 
        p_child_emergency_contact_city_address, 
        p_child_emergency_contact_state_address, 
        p_child_emergency_contact_zip_address, 
        p_child_emergency_contact_telephone_number, 
        TRUE
    );
    SET p_child_emergency_contact_id = LAST_INSERT_ID();
END

--spCreateEmptyAdmissionForm
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateEmptyAdmissionForm`(
    IN p_child_id INT
)
BEGIN
    INSERT INTO admission_form (
        child_id
    ) VALUES (
        p_child_id
    );
END

--spCreateEmptyAuthorizationForm
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateEmptyAuthorizationForm`(
    IN p_childId INT
)
BEGIN
    INSERT INTO authorization_form (
        child_id
    ) VALUES (
        p_childId
    );
END

--spCreateEmptyEnrollmentForm
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateEmptyEnrollmentForm`(
    IN p_childId INT
)
BEGIN
    INSERT INTO enrollment_form (
        child_id
    )
    VALUES (
        p_childId
    );
END