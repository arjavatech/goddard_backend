CREATE DATABASE test;
USE test;

CREATE TABLE `admin_info` (
  `email_id` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `apporved_by` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`email_id`)
);

CREATE TABLE `all_form_info` (
  `form_id` int NOT NULL AUTO_INCREMENT,
  `main_topic` varchar(255) DEFAULT NULL,
  `sub_topic_one` varchar(255) DEFAULT NULL,
  `sub_topic_two` varchar(255) DEFAULT NULL,
  `sub_topic_three` varchar(255) DEFAULT NULL,
  `sub_topic_four` varchar(255) DEFAULT NULL,
  `sub_topic_five` varchar(255) DEFAULT NULL,
  `sub_topic_six` varchar(255) DEFAULT NULL,
  `sub_topic_seven` varchar(255) DEFAULT NULL,
  `sub_topic_eight` varchar(255) DEFAULT NULL,
  `sub_topic_nine` varchar(255) DEFAULT NULL,
  `sub_topic_ten` varchar(255) DEFAULT NULL,
  `sub_topic_eleven` varchar(255) DEFAULT NULL,
  `sub_topic_twelve` varchar(255) DEFAULT NULL,
  `sub_topic_thirteen` varchar(255) DEFAULT NULL,
  `sub_topic_fourteen` varchar(255) DEFAULT NULL,
  `sub_topic_fifteen` varchar(255) DEFAULT NULL,
  `sub_topic_sixteen` varchar(255) DEFAULT NULL,
  `sub_topic_seventeen` varchar(255) DEFAULT NULL,
  `sub_topic_eighteen` varchar(255) DEFAULT NULL,
  `form_type` varchar(255) DEFAULT NULL,
  `form_status` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`form_id`)
);

CREATE TABLE `form_repositary` (
  `form_id` int NOT NULL AUTO_INCREMENT,
  `form_name` varchar(255) NOT NULL,
  `state` int NOT NULL,
  PRIMARY KEY (`form_id`),
  UNIQUE KEY `form_name` (`form_name`)
);

CREATE TABLE `care_provider` (
  `child_care_provider_id` int NOT NULL AUTO_INCREMENT,
  `child_care_provider_name` varchar(255) NOT NULL,
  `child_care_provider_telephone_number` varchar(20) NOT NULL,
  `child_hospital_affiliation` varchar(255) DEFAULT NULL,
  `child_care_provider_street_address` varchar(255) DEFAULT NULL,
  `child_care_provider_city_address` varchar(100) DEFAULT NULL,
  `child_care_provider_state_address` varchar(50) DEFAULT NULL,
  `child_care_provider_zip_address` varchar(12) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`child_care_provider_id`)
);

CREATE TABLE `dentist` (
  `child_dentist_id` int NOT NULL AUTO_INCREMENT,
  `child_dentist_name` varchar(255) DEFAULT NULL,
  `dentist_telephone_number` varchar(20) DEFAULT NULL,
  `dentist_street_address` varchar(255) DEFAULT NULL,
  `dentist_city_address` varchar(100) DEFAULT NULL,
  `dentist_state_address` varchar(50) DEFAULT NULL,
  `dentist_zip_address` varchar(12) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`child_dentist_id`)
);

CREATE TABLE `class_details` (
  `class_id` int NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`class_id`)
);

CREATE TABLE `class_form_repository` (
  `class_id` int NOT NULL,
  `form_id` int NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`form_id`,`class_id`),
  KEY `class_id` (`class_id`),
  CONSTRAINT `class_form_repository_ibfk_1` FOREIGN KEY (`form_id`) REFERENCES `all_form_info` (`form_id`),
  CONSTRAINT `class_form_repository_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `class_details` (`class_id`)
);

CREATE TABLE `parent_info` (
  `parent_id` int NOT NULL AUTO_INCREMENT,
  `parent_email` varchar(255) DEFAULT NULL,
  `parent_name` varchar(255) DEFAULT NULL,
  `parent_street_address` varchar(255) DEFAULT NULL,
  `parent_city_address` varchar(255) DEFAULT NULL,
  `parent_state_address` varchar(50) DEFAULT NULL,
  `parent_zip_address` varchar(10) DEFAULT NULL,
  `home_telephone_number` varchar(20) DEFAULT NULL,
  `home_cell_number` varchar(20) DEFAULT NULL,
  `business_name` varchar(255) DEFAULT NULL,
  `work_hours_from` varchar(50) DEFAULT NULL,
  `work_hours_to` varchar(50) DEFAULT NULL,
  `business_telephone_number` varchar(20) DEFAULT NULL,
  `business_street_address` varchar(255) DEFAULT NULL,
  `business_city_address` varchar(100) DEFAULT NULL,
  `business_state_address` varchar(50) DEFAULT NULL,
  `business_zip_address` varchar(12) DEFAULT NULL,
  `business_cell_number` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `signup_url` varchar(255) DEFAULT NULL,
  `is_password_reset` tinyint(1) DEFAULT NULL,
  `status` int DEFAULT '1',
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`parent_id`)
);

CREATE TABLE `parent_invite_info` (
  `invite_email` varchar(255) NOT NULL,
  `parent_id` int DEFAULT NULL,
  `invite_id` varchar(255) DEFAULT NULL,
  `time_stamp` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`invite_email`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `parent_invite_info_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `parent_info` (`parent_id`)
);

CREATE TABLE `child_info` (
  `child_id` int NOT NULL AUTO_INCREMENT,
  `parent_id` varchar(255) DEFAULT NULL,
  `class_id` int DEFAULT NULL,
  `child_first_name` varchar(100) DEFAULT NULL,
  `child_last_name` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`child_id`),
  KEY `class_id` (`class_id`),
  CONSTRAINT `child_info_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `class_details` (`class_id`)
);

CREATE TABLE `emergency_details` (
  `child_emergency_contact_id` int NOT NULL AUTO_INCREMENT,
  `child_emergency_contact_name` varchar(255) DEFAULT NULL,
  `child_emergency_contact_relationship` varchar(255) DEFAULT NULL,
  `child_emergency_contact_full_address` varchar(255) DEFAULT NULL,
  `child_emergency_contact_city_address` varchar(255) DEFAULT NULL,
  `child_emergency_contact_state_address` varchar(255) DEFAULT NULL,
  `child_emergency_contact_zip_address` varchar(20) DEFAULT NULL,
  `child_emergency_contact_telephone_number` varchar(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`child_emergency_contact_id`)
);

CREATE TABLE `student_form_repository` (
  `child_id` int NOT NULL,
  `form_id` int NOT NULL,
  `form_status` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`child_id`,`form_id`),
  KEY `form_id` (`form_id`),
  CONSTRAINT `student_form_repository_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `child_info` (`child_id`),
  CONSTRAINT `student_form_repository_ibfk_2` FOREIGN KEY (`form_id`) REFERENCES `form_repositary` (`form_id`)
);

CREATE TABLE `admission_form` (
  `child_id` int NOT NULL,
  `additional_parent_id` int DEFAULT NULL,
  `care_provider_id` int DEFAULT NULL,
  `dentist_id` int DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `nick_name` varchar(100) DEFAULT NULL,
  `primary_language` varchar(50) DEFAULT NULL,
  `school_age_child_school` varchar(100) DEFAULT NULL,
  `do_relevant_custody_papers_apply` int DEFAULT NULL,
  `gender` int DEFAULT NULL,
  `special_diabilities` text,
  `allergies_medication_reaction` varchar(255) DEFAULT NULL,
  `additional_info` text,
  `medication` text,
  `health_insurance` text,
  `policy_number` varchar(100) DEFAULT NULL,
  `obtaining_emergency_medical_care` text,
  `administration_first_aid_procedures` text,
  `agree_all_above_information_is_correct` varchar(255) DEFAULT NULL,
  `physical_exam_last_date` date DEFAULT NULL,
  `dental_exam_last_date` date DEFAULT NULL,
  `allergies` text,
  `asthma` text,
  `bleeding_problems` text,
  `diabetes` text,
  `epilepsy` text,
  `frequent_ear_infections` text,
  `frequent_illnesses` text,
  `hearing_problems` text,
  `high_fevers` text,
  `hospitalization` text,
  `rheumatic_fever` text,
  `seizures_convulsions` text,
  `serious_injuries_accidents` text,
  `surgeries` text,
  `vision_problems` text,
  `medical_other` text,
  `illness_during_pregnancy` text,
  `condition_of_newborn` text,
  `duration_of_pregnancy` text,
  `birth_weight_lbs` varchar(50) DEFAULT NULL,
  `birth_weight_oz` varchar(50) DEFAULT NULL,
  `complications` text,
  `bottle_fed` int DEFAULT '2',
  `breast_fed` int DEFAULT '2',
  `other_siblings_name` varchar(100) DEFAULT NULL,
  `other_siblings_age` varchar(50) DEFAULT NULL,
  `family_history_allergies` varchar(255) DEFAULT NULL,
  `family_history_heart_problems` varchar(255) DEFAULT NULL,
  `family_history_tuberculosis` varchar(255) DEFAULT NULL,
  `family_history_asthma` varchar(255) DEFAULT NULL,
  `family_history_high_blood_pressure` varchar(255) DEFAULT NULL,
  `family_history_vision_problems` varchar(255) DEFAULT NULL,
  `family_history_diabetes` varchar(255) DEFAULT NULL,
  `family_history_hyperactivity` varchar(255) DEFAULT NULL,
  `family_history_epilepsy` varchar(255) DEFAULT NULL,
  `no_illnesses_for_this_child` varchar(255) DEFAULT NULL,
  `age_group_friends` varchar(100) DEFAULT NULL,
  `neighborhood_friends` varchar(100) DEFAULT NULL,
  `relationship_with_mother` varchar(100) DEFAULT NULL,
  `relationship_with_father` varchar(100) DEFAULT NULL,
  `relationship_with_siblings` varchar(100) DEFAULT NULL,
  `relationship_with_extended_family` varchar(100) DEFAULT NULL,
  `fears_conflicts` text,
  `child_response_frustration` text,
  `favorite_activities` text,
  `last_five_years_moved` varchar(255) DEFAULT NULL,
  `things_used_at_home` varchar(100) DEFAULT NULL,
  `hours_of_television_daily` varchar(50) DEFAULT NULL,
  `language_used_at_home` varchar(50) DEFAULT NULL,
  `changes_at_home_situation` varchar(255) DEFAULT NULL,
  `educational_expectations_of_child` text,
  `fam_his_instructions` varchar(255) DEFAULT NULL,
  `do_you_agree_this_immunization_instructions` varchar(255) DEFAULT NULL,
  `important_fam_members` varchar(100) DEFAULT NULL,
  `about_family_celebrations` varchar(100) DEFAULT NULL,
  `childcare_before` int DEFAULT '2',
  `reason_for_childcare_before` text,
  `what_child_interests` text,
  `drop_off_time` varchar(100) DEFAULT NULL,
  `pick_up_time` varchar(100) DEFAULT NULL,
  `restricted_diet` int DEFAULT '2',
  `restricted_diet_reason` text,
  `eat_own` int DEFAULT '2',
  `eat_own_reason` text,
  `favorite_foods` text,
  `rest_in_the_middle_day` int DEFAULT '2',
  `reason_for_rest_in_the_middle_day` text,
  `rest_routine` text,
  `toilet_trained` int DEFAULT '2',
  `reason_for_toilet_trained` text,
  `explain_for_existing_illness_allergy` text,
  `existing_illness_allergy` int DEFAULT '2',
  `functioning_at_age` int DEFAULT '2',
  `explain_for_functioning_at_age` text,
  `explain_for_able_to_walk` text,
  `able_to_walk` int DEFAULT '2',
  `explain_for_communicate_their_needs` text,
  `communicate_their_needs` int DEFAULT '2',
  `any_medication` int DEFAULT '2',
  `explain_for_any_medication` text,
  `utilize_special_equipment` int DEFAULT '2',
  `explain_for_utilize_special_equipment` text,
  `significant_periods` int DEFAULT '2',
  `explain_for_significant_periods` text,
  `desire_any_accommodations` int DEFAULT '2',
  `explain_for_desire_any_accommodations` text,
  `additional_information` text,
  `do_you_agree_this` varchar(255) DEFAULT NULL,
  `child_password_pick_up_password_form` varchar(100) DEFAULT NULL,
  `do_you_agree_this_pick_up_password_form` varchar(255) DEFAULT NULL,
  `photo_usage_photo_video_permission_form` text,
  `photo_permission_agree_group_photos_electronic` varchar(255) DEFAULT NULL,
  `do_you_agree_this_photo_video_permission_form` varchar(255) DEFAULT NULL,
  `security_release_policy_form` varchar(255) DEFAULT NULL,
  `med_technicians_med_transportation_waiver` text,
  `medical_transportation_waiver` varchar(255) DEFAULT NULL,
  `do_you_agree_this_health_policies` varchar(255) DEFAULT NULL,
  `parent_sign_outside_waiver` varchar(255) DEFAULT NULL,
  `approve_social_media_post` int DEFAULT NULL,
  `printed_name_social_media_post` varchar(100) DEFAULT NULL,
  `do_you_agree_this_social_media_post` varchar(255) DEFAULT NULL,
  `parent_sign_admission` varchar(100) DEFAULT NULL,
  `parent_sign_date_admission` varchar(255) DEFAULT NULL,
  `admin_sign_admission` varchar(100) DEFAULT NULL,
  `admin_sign_date_admission` bigint DEFAULT NULL,
  `emergency_contact_first_id` int DEFAULT NULL,
  `emergency_contact_second_id` int DEFAULT NULL,
  `emergency_contact_third_id` int DEFAULT NULL,
  `pointer` int DEFAULT NULL,
  `child_dentist_name` varchar(255) DEFAULT NULL,
  `dentist_telephone_number` varchar(20) DEFAULT NULL,
  `dentist_street_address` varchar(255) DEFAULT NULL,
  `dentist_city_address` varchar(100) DEFAULT NULL,
  `dentist_state_address` varchar(50) DEFAULT NULL,
  `dentist_zip_address` varchar(12) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `agree_all_above_info_is_correct` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`child_id`),
  KEY `additional_parent_id` (`additional_parent_id`),
  KEY `care_provider_id` (`care_provider_id`),
  KEY `dentist_id` (`dentist_id`),
  KEY `emergency_contact_first` (`emergency_contact_first_id`),
  KEY `emergency_contact_second` (`emergency_contact_second_id`),
  KEY `fk_emergency_contact_third` (`emergency_contact_third_id`),
  CONSTRAINT `admission_form_ibfk_1` FOREIGN KEY (`additional_parent_id`) REFERENCES `parent_info` (`parent_id`),
  CONSTRAINT `admission_form_ibfk_2` FOREIGN KEY (`care_provider_id`) REFERENCES `care_provider` (`child_care_provider_id`),
  CONSTRAINT `admission_form_ibfk_3` FOREIGN KEY (`dentist_id`) REFERENCES `dentist` (`child_dentist_id`),
  CONSTRAINT `emergency_contact_first` FOREIGN KEY (`emergency_contact_first_id`) REFERENCES `emergency_details` (`child_emergency_contact_id`),
  CONSTRAINT `emergency_contact_second` FOREIGN KEY (`emergency_contact_second_id`) REFERENCES `emergency_details` (`child_emergency_contact_id`),
  CONSTRAINT `fk_emergency_contact_third` FOREIGN KEY (`emergency_contact_third_id`) REFERENCES `emergency_details` (`child_emergency_contact_id`)
);

CREATE TABLE `authorization_form` (
  `child_id` int NOT NULL,
  `bank_routing` varchar(255) DEFAULT NULL,
  `bank_account` varchar(255) DEFAULT NULL,
  `driver_license` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `i` varchar(255) DEFAULT NULL,
  `parent_sign_ach` varchar(255) DEFAULT NULL,
  `parent_sign_date_ach` varchar(255) DEFAULT NULL,
  `admin_sign_ach` varchar(255) DEFAULT NULL,
  `admin_sign_date_ach` bigint DEFAULT NULL,
  `ach_pointer` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`child_id`)
);



CREATE TABLE `enrollment_form` (
  `child_id` int NOT NULL,
  `child_first_name` varchar(255) DEFAULT NULL,
  `point_one_field_three` varchar(255) DEFAULT NULL,
  `point_two_initial_here` varchar(255) DEFAULT NULL,
  `point_three_initial_here` varchar(255) DEFAULT NULL,
  `point_four_initial_here` varchar(255) DEFAULT NULL,
  `point_five_initial_here` varchar(255) DEFAULT NULL,
  `point_six_initial_here` varchar(255) DEFAULT NULL,
  `point_seven_initial_here` varchar(255) DEFAULT NULL,
  `point_eight_initial_here` varchar(255) DEFAULT NULL,
  `point_nine_initial_here` varchar(255) DEFAULT NULL,
  `point_ten_initial_here` varchar(255) DEFAULT NULL,
  `point_eleven_initial_here` varchar(255) DEFAULT NULL,
  `point_twelve_initial_here` varchar(255) DEFAULT NULL,
  `point_thirteen_initial_here` varchar(255) DEFAULT NULL,
  `point_fourteen_initial_here` varchar(255) DEFAULT NULL,
  `point_fifteen_initial_here` varchar(255) DEFAULT NULL,
  `point_sixteen_initial_here` varchar(255) DEFAULT NULL,
  `point_seventeen_initial_here` varchar(255) DEFAULT NULL,
  `point_eighteen_initial_here` varchar(255) DEFAULT NULL,
  `point_ninteen_initial_here` varchar(255) DEFAULT NULL,
  `preferred_start_date` date DEFAULT NULL,
  `preferred_schedule` varchar(255) DEFAULT NULL,
  `full_day` varchar(255) DEFAULT NULL,
  `half_day` varchar(255) DEFAULT NULL,
  `parent_sign_enroll` varchar(255) DEFAULT NULL,
  `parent_sign_date_enroll` varchar(255) DEFAULT NULL,
  `admin_sign_enroll` varchar(255) DEFAULT NULL,
  `admin_sign_date_enroll` bigint DEFAULT NULL,
  `enroll_pointer` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`child_id`)
);


CREATE TABLE `parent_handbook` (
  `child_id` int NOT NULL,
  `welcome_goddard_agreement` varchar(255) DEFAULT NULL,
  `mission_statement_agreement` varchar(255) DEFAULT NULL,
  `general_information_agreement` varchar(255) DEFAULT NULL,
  `medical_care_provider_agreement` varchar(255) DEFAULT NULL,
  `parent_access_agreement` varchar(255) DEFAULT NULL,
  `release_of_children_agreement` varchar(255) DEFAULT NULL,
  `registration_fees_agreement` varchar(255) DEFAULT NULL,
  `outside_engagements_agreement` varchar(255) DEFAULT NULL,
  `health_policies_agreement` varchar(255) DEFAULT NULL,
  `medication_procedures_agreement` varchar(255) DEFAULT NULL,
  `bring_to_school_agreement` varchar(255) DEFAULT NULL,
  `rest_time_agreement` varchar(255) DEFAULT NULL,
  `training_philosophy_agreement` varchar(255) DEFAULT NULL,
  `affiliation_policy_agreement` varchar(255) DEFAULT NULL,
  `security_issue_agreement` varchar(255) DEFAULT NULL,
  `expulsion_policy_agreement` varchar(255) DEFAULT NULL,
  `addressing_individual_child_agreement` varchar(255) DEFAULT NULL,
  `finalword_agreement` varchar(255) DEFAULT NULL,
  `parent_sign_handbook` varchar(255) DEFAULT NULL,
  `parent_sign_date_handbook` varchar(255) DEFAULT NULL,
  `admin_sign_handbook` varchar(255) DEFAULT NULL,
  `admin_sign_date_handbook` bigint DEFAULT NULL,
  `handbook_pointer` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`child_id`)
);


-- Strored Procedures-- 

DELIMITER //

CREATE PROCEDURE `GetConsolidatedFormData`()
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
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spClassBasedChildCount`(
	IN p_class_id  INT
    )
BEGIN
    SELECT COUNT(*) AS count FROM child_info
    WHERE 
        class_id = p_class_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spClassBasedChildCountWithClassName`()
BEGIN
    SELECT class_details.class_id, class_details.class_name, 
           IFNULL(COUNT(child_info.child_id), 0) AS count
    FROM class_details
    LEFT JOIN child_info 
    ON class_details.class_id = child_info.class_id 
    AND child_info.is_active = TRUE
    WHERE class_details.is_active = TRUE
    GROUP BY class_details.class_id, class_details.class_name;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateAdminInfo`(
    IN p_email_id VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_designation VARCHAR(255),
    IN p_apporved_by VARCHAR(255)
)
BEGIN
    INSERT INTO admin_info (email_id, password, designation, apporved_by, is_active)
    VALUES (p_email_id, p_password, p_designation, p_apporved_by, TRUE);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateAdmissionForm`(
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
    IN p_parent_sign_date_admission INT,
    IN p_admin_sign_date_admission INT
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
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateAdmissionForm1`(
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
    IN p_parent_sign_date_admission INT,
    IN p_admin_sign_date_admission INT,
    IN `p_child_dentist_name` varchar(255),
    IN `p_dentist_telephone_number` varchar(20),
	IN `p_dentist_street_address` varchar(255),
    IN `p_dentist_city_address` varchar(100),
    IN `p_dentist_state_address` varchar(50),
    IN `p_dentist_ZIP_address` varchar(12)
    
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
        approve_social_media_post, printed_name_social_media_post, do_you_agree_this_social_media_post, parent_sign_admission, admin_sign_admission, emergency_contact_first_id, emergency_contact_second_id, emergency_contact_third_id, pointer, agree_all_above_info_is_correct, is_active, parent_sign_date_admission, admin_sign_date_admission,
        child_dentist_name, dentist_telephone_number, dentist_street_address, dentist_city_address, dentist_state_address, dentist_zip_address
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
        p_approve_social_media_post, p_printed_social_media_post, p_social_media_post, p_parent_sign, p_admin_sign, p_emergency_contact_first_id, p_emergency_contact_second_id, p_emergency_contact_third_id, p_pointer, p_agree_all_above_info_is_correct,TRUE, p_parent_sign_date_admission, p_admin_sign_date_admission,
        p_child_dentist_name, p_dentist_telephone_number, p_dentist_street_address, p_dentist_city_address, p_dentist_state_address, p_dentist_zip_address
    );
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateAuthorizationForm`(
    IN p_childId INT,
    IN p_bankRoutingAch VARCHAR(255),
    IN p_bankAccountAch VARCHAR(255),
    IN p_driverLicenseAch VARCHAR(255),
    IN p_stateAch VARCHAR(255),
    IN p_iAch VARCHAR(255),
    IN p_parentSignAch VARCHAR(255),
    IN p_adminSignAch VARCHAR(255),
    IN p_parent_sign_date_ach INT,
    IN p_admin_sign_date_ach INT
)
BEGIN
    INSERT INTO authorization_form (
        child_id, bank_routing, bank_account, driver_license, state, 
        i, parent_sign_ach, admin_sign_ach, is_active, parent_sign_date_ach, admin_sign_date_ach
    ) VALUES (
        p_childId, p_bankRoutingAch, p_bankAccountAch, p_driverLicenseAch, p_stateAch, 
        p_iAch, p_parentSignAch, p_adminSignAch, TRUE, p_parent_sign_date_ach, p_admin_sign_date_ach
    );
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateCareProvider`(
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
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateCareProviderReturnId`(
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
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateChildInfo`(
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
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateClass`(
    IN p_className VARCHAR(255)
)
BEGIN
    INSERT INTO class_details (class_name, is_active)
    VALUES (p_className, TRUE);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateClassFormRepository`( 
    IN p_classId INT,
    IN p_formId INT
)
BEGIN
    INSERT INTO class_form_repository (class_id, form_id, is_active)
    VALUES (p_classId, p_formId, TRUE);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateDentist`(
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
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateDentistReturnId`(
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
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateEmergencyDetail`(
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
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateEmergencyDetailReturnId`(
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

CREATE PROCEDURE `spCreateEnrollmentForm`(
    IN p_childId INT,
    IN p_enrollmentName VARCHAR(255),
    IN p_pointOneFieldThree VARCHAR(255),
    IN p_pointTwoInitialHere VARCHAR(255),
    IN p_pointThreeInitialHere VARCHAR(255),
    IN p_pointFourInitialHere VARCHAR(255),
    IN p_pointFiveInitialHere VARCHAR(255),
    IN p_pointSixInitialHere VARCHAR(255),
    IN p_pointSevenInitialHere VARCHAR(255),
    IN p_pointEightInitialHere VARCHAR(255),
    IN p_pointNineInitialHere VARCHAR(255),
    IN p_pointTenInitialHere VARCHAR(255),
    IN p_pointElevenInitialHere VARCHAR(255),
    IN p_pointTwelveInitialHere VARCHAR(255),
    IN p_pointThirteenInitialHere VARCHAR(255),
    IN p_pointFourteenInitialHere VARCHAR(255),
    IN p_pointFifteenInitialHere VARCHAR(255),
    IN p_pointSixteenInitialHere VARCHAR(255),
    IN p_pointSeventeenInitialHere VARCHAR(255),
    IN p_pointEighteenInitialHere VARCHAR(255),
    IN p_point_ninteen_initial_here VARCHAR(255),
    IN p_preferredStartDate DATE,
    IN p_preferredSchedule VARCHAR(255),
    IN p_fullDay VARCHAR(255),
    IN p_halfDay VARCHAR(255),
    IN p_parentSignEnroll VARCHAR(255),
    IN p_adminSignEnroll VARCHAR(255),
    IN p_parent_sign_date_enroll int,
    IN p_admin_sign_date_ach_enroll int
)
BEGIN
    INSERT INTO enrollment_form (
        child_id,
        child_first_name,
        point_one_field_three,
        point_two_initial_here,
        point_three_initial_here,
        point_four_initial_here,
        point_five_initial_here,
        point_six_initial_here,
        point_seven_initial_here,
        point_eight_initial_here,
        point_nine_initial_here,
        point_ten_initial_here,
        point_eleven_initial_here,
        point_twelve_initial_here,
        point_thirteen_initial_here,
        point_fourteen_initial_here,
        point_fifteen_initial_here,
        point_sixteen_initial_here,
        point_seventeen_initial_here,
        point_eighteen_initial_here,
        point_ninteen_initial_here,
        preferred_start_date,
        preferred_schedule,
        full_day,
        half_day,
        parent_sign_enroll,
        admin_sign_enroll,
        is_active,
        parent_sign_date_enroll,
        admin_sign_date_enroll
    )
    VALUES (
        p_childId,
        p_enrollmentName,
        p_pointOneFieldThree,
        p_pointTwoInitialHere,
        p_pointThreeInitialHere,
        p_pointFourInitialHere,
        p_pointFiveInitialHere,
        p_pointSixInitialHere,
        p_pointSevenInitialHere,
        p_pointEightInitialHere,
        p_pointNineInitialHere,
        p_pointTenInitialHere,
        p_pointElevenInitialHere,
        p_pointTwelveInitialHere,
        p_pointThirteenInitialHere,
        p_pointFourteenInitialHere,
        p_pointFifteenInitialHere,
        p_pointSixteenInitialHere,
        p_pointSeventeenInitialHere,
        p_pointEighteenInitialHere,
        p_point_ninteen_initial_here,
        p_preferredStartDate,
        p_preferredSchedule,
        p_fullDay,
        p_halfDay,
        p_parentSignEnroll,
        p_adminSignEnroll,
        TRUE,
        p_parent_sign_date_enroll,
        p_admin_sign_date_enroll
    );
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateFormInfo`(
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

DELIMITER //

CREATE PROCEDURE `spCreateParentInfo`(
    IN p_name VARCHAR(255)
)
BEGIN
    INSERT INTO parent_info (
        parent_name
        ) 
    VALUES (
        p_name
        );
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateParentInfoAndGetID`(
    IN p_name VARCHAR(255),
    OUT parent_id INT
)
BEGIN
    INSERT INTO parent_info (
        parent_name
    ) VALUES (
        p_name
    );
    
    -- Get the last inserted ID
    SET parent_id = LAST_INSERT_ID();
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateParentInfoReturnId`(
    IN p_primary_parent_email VARCHAR(255),
    IN p_parent_name VARCHAR(255),
    IN p_parent_street_address VARCHAR(255),
    IN p_parent_city_address VARCHAR(255),
    IN p_parent_state_address VARCHAR(50),
    IN p_parent_zip_address VARCHAR(10),
    IN p_home_telephone_number VARCHAR(20),
    IN p_home_cell_number VARCHAR(20),
    IN p_business_name VARCHAR(255),
    IN p_work_hours_from VARCHAR(50),
    IN p_work_hours_to VARCHAR(50),
    IN p_business_telephone_number VARCHAR(20),
    IN p_business_street_address VARCHAR(255),
    IN p_business_city_address VARCHAR(100),
    IN p_business_state_address VARCHAR(50),
    IN p_business_zip_address VARCHAR(12),
    IN p_business_cell_number VARCHAR(20),
    IN p_password VARCHAR(255),
    OUT p_parent_id INT    
)
BEGIN
    INSERT INTO parent_info (
        parent_email, 
        parent_name, 
        parent_street_address, 
        parent_city_address, 
        parent_state_address, 
        parent_zip_address, 
        home_telephone_number, 
        home_cell_number, 
        business_name, 
        work_hours_from,
        work_hours_to,
        business_telephone_number, 
        business_street_address, 
        business_city_address, 
        business_state_address, 
        business_zip_address, 
        business_cell_number, 
        password, 
        is_active
    ) 
    VALUES (
        p_primary_parent_email, 
        p_parent_name, 
        p_parent_street_address, 
        p_parent_city_address, 
        p_parent_state_address, 
        p_parent_zip_address, 
        p_home_telephone_number, 
        p_home_cell_number, 
        p_business_name, 
        p_work_hours_from,
        p_work_hours_to,
        p_business_telephone_number, 
        p_business_street_address, 
        p_business_city_address, 
        p_business_state_address, 
        p_business_zip_address, 
        p_business_cell_number, 
        p_password, 
        TRUE
    );

    SET p_parent_id = LAST_INSERT_ID();
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateParentInfoWithAllDetails`(
    IN p_primary_parent_email VARCHAR(255),
    IN p_parent_name VARCHAR(255),
    IN p_parent_street_address VARCHAR(255),
    IN p_parent_city_address VARCHAR(255),
    IN p_parent_state_address VARCHAR(50),
    IN p_parent_zip_address VARCHAR(10),
    IN p_home_telephone_number VARCHAR(20),
    IN p_home_cell_number VARCHAR(20),
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
    INSERT INTO parent_info (
        parent_email, 
        parent_name, 
        parent_street_address, 
        parent_city_address, 
        parent_state_address, 
        parent_zip_address, 
        home_telephone_number, 
        home_cell_number, 
        business_name, 
        work_hours_from,
        work_hours_to,
        business_telephone_number, 
        business_street_address, 
        business_city_address, 
        business_state_address, 
        business_zip_address, 
        business_cell_number, 
        password, 
        is_active
    ) 
    VALUES (
        p_primary_parent_email, 
        p_parent_name, 
        p_parent_street_address, 
        p_parent_city_address, 
        p_parent_state_address, 
        p_parent_zip_address, 
        p_home_telephone_number, 
        p_home_cell_number, 
        p_business_name, 
        p_work_hours_from,
        p_work_hours_to,
        p_business_telephone_number, 
        p_business_street_address, 
        p_business_city_address, 
        p_business_state_address, 
        p_business_zip_address, 
        p_business_cell_number, 
        p_password, 
        TRUE
    );
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateParentInvite`(
    IN p_email VARCHAR(255),
    IN p_invite_id VARCHAR(255),
    IN p_parent_id INT,
    IN p_time_stamp VARCHAR(255)
    )
BEGIN
    INSERT INTO parent_invite_info (
        invite_email, 
        invite_id, 
        parent_id,
        time_stamp
    )
    VALUES (
        p_email, 
        p_invite_id, 
        p_parent_id,
        p_time_stamp
    );
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spCreateStudentFormRepository`(
    IN p_childId INT,
    IN p_formId INT,
    IN p_formstatus INT
)
BEGIN
    INSERT INTO student_form_repository (child_id, form_id, form_status, is_active)
    VALUES (p_childId, p_formId, p_formstatus, TRUE);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteAdminInfo`(
    IN p_email_id VARCHAR(255)
)
BEGIN
    UPDATE admin_info
    SET is_active = FALSE
    WHERE 
        email_id = p_email_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteAdmissionForm`(
    IN p_childId INT
)
BEGIN
    UPDATE admission_form
    SET is_active = FALSE
    WHERE child_id = p_childId;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteAuthorizationForm`(
    IN p_childId INT
)
BEGIN
    UPDATE authorization_form
    SET is_active = FALSE
    WHERE child_id = p_childId;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteCareProvider`(
    IN p_id INT
)
BEGIN
    UPDATE care_provider
    SET is_active = FALSE
    WHERE child_care_provider_id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteChildInfo`(
    IN p_child_id INT
)
BEGIN
    UPDATE child_info
    SET 
        is_active = FALSE
    WHERE 
        child_id = p_child_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteClass`(
    IN p_classId INT
)
BEGIN
    UPDATE class_details
    SET is_active = FALSE
    WHERE 
        class_id = p_classId;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteClassFormRepository`(
    IN p_classId INT,
    IN p_formId INT
)
BEGIN
    UPDATE class_form_repository
    SET is_active = FALSE
    WHERE 
        class_id = p_classId 
        AND form_id = p_formId;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteDentist`(
    IN p_id INT
)
BEGIN
    UPDATE dentist
    SET is_active = FALSE
    WHERE child_dentist_id = p_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteEmergencyDetail`(
    IN p_emergency_id INT
)
BEGIN
    UPDATE emergency_details
    SET is_active = FALSE
    WHERE child_emergency_contact_id = p_emergency_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteEnrollmentForm`(
    IN p_childId INT
)
BEGIN
    UPDATE enrollment_form
    SET is_active = FALSE
    WHERE child_id = p_childId;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteForm`(
    IN p_form_id INT
)
BEGIN
    DELETE FROM form_repositary
    WHERE form_id = p_form_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteFormInfo`(
    IN p_form_id INT
)
BEGIN
    UPDATE all_form_info
    SET is_active = FALSE
    WHERE 
        form_id = p_form_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteParentHandbook`(
    IN p_child_id INT
)
BEGIN
    UPDATE parent_handbook
    SET is_active = FALSE
    WHERE child_id = p_child_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteParentInfo`(
    IN p_parent_id INT
)
BEGIN
    UPDATE parent_info
    SET is_active = FALSE
    WHERE parent_id = p_parent_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteParentInvite`(
    IN p_email VARCHAR(255)
)
BEGIN
    DELETE FROM parent_invite_info
    WHERE invite_email = p_email;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spDeleteStudentAllFormRepository`(
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

CREATE PROCEDURE `spDeleteStudentFormRepository`(
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

CREATE PROCEDURE `spGetActiveInviteStatus`()
BEGIN
    SELECT 
        pi.invite_email,
        p.parent_id,
        pi.time_stamp,
        p.parent_name,
        p.parent_email AS primary_email,
        CASE 
            WHEN p.parent_email IS NOT NULL THEN 'Active'
            ELSE 'Inactive'
        END AS invite_status,
        CASE 
            WHEN p.status = 1 THEN 'Active'
            ELSE 'Archive'
        END AS status
    FROM 
        parent_invite_info pi
    JOIN 
        parent_info p ON pi.parent_id = p.parent_id AND p.status = 1;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAdminInfo`(
    IN p_email_id VARCHAR(255)
)
BEGIN
    SELECT * FROM admin_info
    WHERE email_id = p_email_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAdmissionForm`(
    IN p_child_id INT
)
BEGIN
    SELECT * FROM admission_form
    WHERE child_id = p_child_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllActiveFormInfo`()
BEGIN
    SELECT * FROM all_form_info
    WHERE 
        is_active = TRUE AND form_status = "Active";
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllAdminInfo`()
BEGIN
    SELECT * FROM admin_info
    WHERE is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllAdmissionForms`()
BEGIN
    SELECT * 
    FROM admission_form 
    WHERE is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllAdmissionFormsChildNames`()
BEGIN
    SELECT child_id, child_first_name
    FROM admission_form 
    WHERE is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllAdmissionFormsCount`()
BEGIN
    SELECT COUNT(*) AS count
    FROM admission_form 
    WHERE is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllAuthorizationForms`()
BEGIN
    SELECT * FROM authorization_form
    WHERE is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllCareProviders`()
BEGIN
    SELECT * FROM care_provider
    WHERE is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllChildCount`()
BEGIN
    SELECT COUNT(*) AS count
    FROM child_info 
    WHERE is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllChildInfo`()
BEGIN
    SELECT * FROM child_info
    WHERE 
        is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllChildNames`()
BEGIN
    SELECT child_id, child_first_name
    FROM child_info 
    WHERE is_active = TRUE;
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
    p.parent_email AS primary_email,
    p2.parent_email AS additional_parent_email,
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
LEFT JOIN
    parent_info p ON c.parent_id = p.parent_id
LEFT JOIN
    admission_form adf ON adf.child_id = c.child_id
LEFT JOIN 
    parent_info p2 ON adf.additional_parent_id = p2.parent_id

WHERE fr.is_active = 1 
GROUP BY 
    c.child_id, 
    c.child_first_name, 
    c.child_last_name, 
    cl.class_name, 
    p.parent_email, 
    p2.parent_email;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllClass`()
BEGIN
    SELECT * FROM class_details
    WHERE 
        is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllClassFormRepository`()
BEGIN
    SELECT * FROM class_form_repository
    WHERE 
        is_active = TRUE;
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
    p.parent_email AS primary_email,
    p2.parent_email AS additional_parent_email,
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
LEFT JOIN
    admission_form adf ON adf.child_id = c.child_id
LEFT JOIN 
    parent_info p2 ON adf.additional_parent_id = p2.parent_id
LEFT JOIN 
    student_form_repository fr ON fr.child_id = c.child_id
WHERE 
    c.class_id = p_classId
    AND fr.is_active = 1 
GROUP BY 
    c.child_id, 
    c.child_first_name, 
    c.child_last_name, 
    cl.class_name, 
    p.parent_email, 
    p2.parent_email;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllClassRoomBasedChildIds`(
    IN p_classId INT
)
BEGIN
    SELECT 
    c.child_id
FROM 
    child_info c
JOIN 
    class_details cl ON c.class_id = cl.class_id

WHERE 
    cl.is_active = 1 and c.is_active = 1;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllDentists`()
BEGIN
    SELECT * FROM dentist
    WHERE is_active = TRUE;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE `spGetAllEmergencyDetails`()
BEGIN
    SELECT * FROM emergency_details
    WHERE is_active = TRUE;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE `spGetAllEnrollmentForms`()
BEGIN
    SELECT * FROM enrollment_form
    WHERE is_active = TRUE;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE `spGetAllFormBasedChildDetails`(IN p_form_id INT)
BEGIN
    SELECT 
        ci.child_first_name,
        ci.child_last_name,
        cd.class_name,
        pi.parent_email AS primary_email,
        pi_additional.parent_email AS additional_parent_email,
        CASE
            WHEN sfr.form_status = 0 THEN 'Incomplete'
            WHEN sfr.form_status = 1 THEN 'Approval Pending'
            WHEN sfr.form_status = 2 THEN 'Completed'
            ELSE 'Unknown Status'
        END AS form_status
    FROM 
        child_info ci
    LEFT JOIN 
        class_details cd ON ci.class_id = cd.class_id
    LEFT JOIN 
        parent_info pi ON ci.parent_id = pi.parent_id
    LEFT JOIN 
        admission_form af ON ci.child_id = af.child_id
    LEFT JOIN 
        parent_info pi_additional ON af.additional_parent_id = pi_additional.parent_id
    INNER JOIN 
        student_form_repository sfr ON ci.child_id = sfr.child_id
    WHERE 
        sfr.form_id = p_form_id
        AND sfr.is_active = TRUE;
    
END //


DELIMITER ;


DELIMITER //

CREATE PROCEDURE `spGetAllFormInfo`()
BEGIN
    SELECT * FROM all_form_info
    WHERE 
        is_active = TRUE;
END //


DELIMITER ;


DELIMITER //

CREATE PROCEDURE `spGetAllInActiveFormInfo`()
BEGIN
    SELECT * FROM all_form_info
    WHERE 
        is_active = TRUE AND form_status = "Inactive";
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE `spGetAllMainTopicFormInfo`()
BEGIN
    SELECT main_topic FROM all_form_info
    WHERE 
        is_active = TRUE;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE `spGetAllParentHandbooks`()
BEGIN
    SELECT * FROM parent_handbook
    WHERE is_active = TRUE;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE `spGetAllParentInfo`()
BEGIN
    SELECT * 
    FROM parent_info 
    WHERE is_active = TRUE;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE `spGetAllParentInviteEmails`()
BEGIN
    SELECT invite_email AS parent_email FROM parent_invite_info;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE `spGetAllParentInvites`()
BEGIN
    SELECT * FROM parent_invite_info;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllPrimaryParent`()
BEGIN
    SELECT parent_id, parent_email, parent_name
    FROM parent_info 
    WHERE password IS NOT NULL AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllSignUpAndInviteEmails`()
BEGIN
    SELECT DISTINCT parent_email 
    FROM parent_info 
    WHERE is_active = TRUE AND parent_email IS NOT NULL;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllStudentFormRepoChildIDs`()
BEGIN
    SELECT child_id, form_id FROM student_form_repository
    WHERE is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAllStudentFormRepository`()
BEGIN
    SELECT * FROM student_form_repository
    WHERE is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetArchiveInviteStatus`()
BEGIN
    SELECT 
        pi.invite_email,
        p.parent_id,
        pi.time_stamp,
        p.parent_name,
        p.parent_email AS primary_email,
        CASE 
            WHEN p.parent_email IS NOT NULL THEN 'Active'
            ELSE 'Inactive'
        END AS invite_status,
        CASE 
            WHEN p.status = 1 THEN 'Active'
            ELSE 'Archive'
        END AS status
    FROM 
        parent_invite_info pi
    JOIN 
        parent_info p ON pi.parent_id = p.parent_id AND p.status = 2;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAuthorizationForm`(
    IN p_childId INT
)
BEGIN
    SELECT af.*, ad.pointer
    FROM authorization_form af
    LEFT JOIN admission_form ad ON af.child_id = ad.child_id
    WHERE af.child_id = p_childId AND af.is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetAuthorizationFormStatus`(
    IN p_childId INT
)
BEGIN
    SELECT 
    CASE 
        WHEN admin_sign_ach IS NULL AND parent_sign_ach IS NULL THEN "Incomplete"
        WHEN admin_sign_ach IS NULL THEN "Approval Pending"
        ELSE "Completed"
    END AS form_status
    FROM authorization_form
    WHERE child_id = p_childId AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetCareProvider`(
    IN p_id INT
)
BEGIN
    SELECT * FROM care_provider
    WHERE child_care_provider_id = p_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `⁠spGetChildDetailsBasedOnMultipleClasses⁠`(
	IN class_ids VARCHAR(255)
    )
BEGIN
    SELECT *
    FROM child_info
    WHERE FIND_IN_SET(class_id, class_ids) > 0 AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetChildInfo`(
    IN p_child_id INT
)
BEGIN
    SELECT * FROM child_info
    WHERE 
        child_id = p_child_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetChildName`(
    IN p_parent_id INT
)
BEGIN
    SELECT * FROM child_info
    WHERE 
        parent_id = p_parent_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetClass`(
    IN p_classId INT
)
BEGIN
    SELECT * FROM class_details
    WHERE 
        class_id = p_classId AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetClassFormRepository`(
    IN p_classId INT,
    IN p_formId INT
)
BEGIN
    SELECT * FROM class_form_repository
    WHERE 
        class_id = p_classId 
        AND form_id = p_formId
        AND is_active = TRUE;
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

CREATE PROCEDURE `spGetDefaultForm`()
BEGIN
    SELECT form_id, form_name FROM form_repositary
    WHERE state = 0;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetDentist`(
    IN p_id INT
)
BEGIN
    SELECT * FROM dentist
    WHERE child_dentist_id = p_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetEmergencyDetail`(
    IN p_emergency_id INT
)
BEGIN
    SELECT * FROM emergency_details
    WHERE child_emergency_contact_id = p_emergency_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetEnrollmentForm`(
    IN p_childId INT
)
BEGIN
    SELECT ef.*, ad.pointer
    FROM enrollment_form ef
    LEFT JOIN admission_form ad ON ef.child_id = ad.child_id
    WHERE ef.child_id = p_childId AND ef.is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetEnrollmentFormStatus`(
    IN p_childId INT
)
BEGIN
    SELECT 
    CASE 
        WHEN admin_sign_enroll IS NULL AND parent_sign_enroll IS NULL THEN "Incomplete"
		WHEN admin_sign_enroll IS NULL THEN "Approval Pending"
        ELSE "Completed"
    END AS form_status
    FROM enrollment_form
    WHERE child_id = p_childId AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetForm`(
    IN p_form_id INT
)
BEGIN
    SELECT * FROM form_repositary
    WHERE form_id = p_form_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetFormInfo`(
    IN p_form_id INT
)
BEGIN
    SELECT * FROM form_repositary
    WHERE 
        form_id = p_form_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetFormInfoStatus`(
    IN p_form_id INT
)
BEGIN
    SELECT form_status FROM all_form_info
    WHERE form_id = p_form_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetInviteStatus`()
BEGIN
    SELECT 
        pi.invite_email,
        p.parent_id,
        pi.time_stamp,
        p.parent_name,
        p.parent_email AS primary_email,
        CASE 
            WHEN p.parent_email IS NOT NULL THEN 'Active'
            ELSE 'Inactive'
        END AS invite_status,
        CASE 
            WHEN p.status = 1 THEN 'Active'
            ELSE 'Archive'
        END AS status
    FROM 
        parent_invite_info pi
    LEFT JOIN 
        parent_info p ON pi.parent_id = p.parent_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetParentBasedChildList`(
    IN p_email VARCHAR(255)
)
BEGIN
SELECT 
       af.child_id, 
       af.child_first_name, 
       af.child_last_name, 
     pi.parent_name AS parent_name
FROM 
     child_info af
  INNER JOIN 
        parent_info pi 
    ON 
       af.parent_id = pi.parent_id
  WHERE 
       pi.parent_email = p_email AND pi.is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetParentEmail`(
    IN p_email_id VARCHAR(255)
)
BEGIN
    SELECT * FROM parent_info
    WHERE parent_email = p_email_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetParentHandbook`(
    IN p_childId INT
)
BEGIN
    SELECT ph.*, ad.pointer
    FROM parent_handbook ph
    LEFT JOIN admission_form ad ON ph.child_id = ad.child_id
    WHERE ph.child_id = p_childId AND ph.is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetParentHandbookStatus`(
    IN p_childId INT
)
BEGIN
    SELECT 
    CASE 
        WHEN admin_sign_handbook IS NULL AND parent_sign_handbook IS NULL THEN "Incomplete"
		WHEN admin_sign_handbook IS NULL THEN "Approval Pending"
        ELSE "Completed"
    END AS form_status
    FROM parent_handbook
    WHERE child_id = p_childId AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetParentIdInInviteTable`(
    IN p_invite_id VARCHAR(255)
)
BEGIN
    SELECT * FROM parent_invite_info
    WHERE invite_id = p_invite_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetParentInfo`(
    IN p_parent_id INT
)
BEGIN
    SELECT * 
    FROM parent_info 
    WHERE parent_id = p_parent_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetParentInfoBasedEmail`(
    IN p_email_id VARCHAR(255),
    IN p_url VARCHAR(255)
)
BEGIN
    SELECT * FROM parent_info
    WHERE signup_url = p_url AND parent_email = p_email_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetParentInvite`(
    IN p_email VARCHAR(255)
)
BEGIN
    SELECT * FROM parent_invite_info
    WHERE invite_email = p_email;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetParentInviteStatus`(
	IN p_invite_email VARCHAR(255)
)
BEGIN
    SELECT
        CASE 
            WHEN p.parent_email IS NOT NULL THEN 'Active'
            ELSE 'Inactive'
        END AS status
    FROM 
        parent_invite_info pi
    LEFT JOIN 
        parent_info p ON pi.parent_id = p.parent_id
	WHERE invite_email = p_invite_email;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetPersonalInfoAllFormStatus`(
    IN p_childId INT
)
BEGIN
SELECT 
    CASE 
		WHEN admin_sign_admission IS NULL AND parent_sign_admission IS NULL THEN "Incomplete"
		WHEN admin_sign_admission IS NULL THEN "Approval Pending"
        ELSE "Completed"
    END AS form_status,
    "admission_form" AS formname,
    admin_date AS completedTimestamp
    FROM admission_form
    WHERE child_id = p_childId AND is_active = TRUE
    
    UNION
    SELECT 
    CASE 
        WHEN admin_sign_ach IS NULL AND parent_sign_ach IS NULL THEN "Incomplete"
		WHEN admin_sign_ach IS NULL THEN "Approval Pending"
        ELSE "Completed"
    END AS form_status,
    "authorization_form" AS formname,
    admin_date AS completedTimestamp
    FROM authorization_form
    WHERE child_id = p_childId AND is_active = TRUE
    
    UNION
    
    SELECT 
    CASE 
        WHEN admin_sign_enroll IS NULL AND parent_sign_enroll IS NULL THEN "Incomplete"
		WHEN admin_sign_enroll IS NULL THEN "Approval Pending"
        ELSE "Completed"
    END AS form_status,
    "enrollment_form" AS formname,
    admin_date AS completedTimestamp
    FROM enrollment_form
    WHERE child_id = p_childId AND is_active = TRUE
    
    UNION
    
    SELECT 
    CASE 
        WHEN admin_sign_handbook IS NULL AND parent_sign_handbook IS NULL THEN "Incomplete"
		WHEN admin_sign_handbook IS NULL THEN "Approval Pending"
        ELSE "Completed"
    END AS form_status,
    "parent_handbook" AS formname,
    admin_date AS completedTimestamp
    FROM parent_handbook
    WHERE child_id = p_childId AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetStudentAllDetails`(
    IN p_childId INT
)
BEGIN
    
SELECT c.child_id,
    c.child_first_name,
    c.child_last_name,
    cd.class_name,
    cp.*,
    d.*,
    p1.*,
    p2.parent_name AS parent_two_name,
    p2.parent_email AS parent_two_email,
    p2.parent_street_address AS parent_two_street_address,
    p2.parent_city_address AS parent_two_city_address,
    p2.parent_state_address AS parent_two_state_address,
    p2.parent_zip_address AS parent_two_zip_address,
    p2.home_telephone_number AS parent_two_home_telephone_number,
    p2.business_cell_number AS parent_two_business_cell_number,
    p2.business_city_address AS parent_two_business_city_address,
    p2.business_name AS parent_two_business_name,
    p2.business_state_address AS parent_two_business_state_address,
    p2.business_street_address AS parent_two_business_street_address,
    p2.business_telephone_number AS parent_two_business_telephone_number,
    p2.business_zip_address AS parent_two_business_zip_address,
    p2.home_cell_number AS parent_two_home_cell_number,
    p2.work_hours_from AS parent_two_work_hours_from,
    p2.work_hours_to AS parent_two_work_hours_to,
    phb.*,
    enf.*,
    auf.*,
    adf.*,
    JSON_ARRAY(
    JSON_OBJECT(
        'child_emergency_contact_id', e1.child_emergency_contact_id,
        'child_emergency_contact_name', e1.child_emergency_contact_name,
        'child_emergency_contact_relationship', e1.child_emergency_contact_relationship,
        'child_emergency_contact_telephone_number', e1.child_emergency_contact_telephone_number,
        'child_emergency_contact_full_address', e1.child_emergency_contact_full_address,
        'child_emergency_contact_city_address', e1.child_emergency_contact_city_address,
        'child_emergency_contact_state_address', e1.child_emergency_contact_state_address,
        'child_emergency_contact_zip_address', e1.child_emergency_contact_zip_address
    ),
    JSON_OBJECT(
        'child_emergency_contact_id', e2.child_emergency_contact_id,
        'child_emergency_contact_name', e2.child_emergency_contact_name,
        'child_emergency_contact_relationship', e2.child_emergency_contact_relationship,
        'child_emergency_contact_telephone_number', e2.child_emergency_contact_telephone_number,
        'child_emergency_contact_full_address', e2.child_emergency_contact_full_address,
        'child_emergency_contact_city_address', e2.child_emergency_contact_city_address,
        'child_emergency_contact_state_address', e2.child_emergency_contact_state_address,
        'child_emergency_contact_zip_address', e2.child_emergency_contact_zip_address
    ),
    JSON_OBJECT(
        'child_emergency_contact_id', e3.child_emergency_contact_id,
        'child_emergency_contact_name', e3.child_emergency_contact_name,
        'child_emergency_contact_relationship', e3.child_emergency_contact_relationship,
        'child_emergency_contact_telephone_number', e3.child_emergency_contact_telephone_number,
        'child_emergency_contact_full_address', e3.child_emergency_contact_full_address,
        'child_emergency_contact_city_address', e3.child_emergency_contact_city_address,
        'child_emergency_contact_state_address', e3.child_emergency_contact_state_address,
        'child_emergency_contact_zip_address', e3.child_emergency_contact_zip_address
    )) AS 'emergency_contact_info'
  
FROM child_info c
JOIN class_details cd ON c.class_id = cd.class_id
LEFT JOIN parent_info p1 ON c.parent_id = p1.parent_id
JOIN admission_form adf ON c.child_id = adf.child_id
LEFT JOIN parent_info p2 ON adf.additional_parent_id = p2.parent_id
LEFT JOIN dentist d ON adf.dentist_id = d.child_dentist_id
LEFT JOIN care_provider cp ON adf.care_provider_id = cp.child_care_provider_id
LEFT JOIN emergency_details e1 ON adf.emergency_contact_first_id = e1.child_emergency_contact_id
LEFT JOIN emergency_details e2 ON adf.emergency_contact_second_id = e2.child_emergency_contact_id
LEFT JOIN emergency_details e3 ON adf.emergency_contact_third_id = e3.child_emergency_contact_id
JOIN authorization_form auf ON c.child_id = auf.child_id
JOIN parent_handbook phb ON c.child_id = phb.child_id
JOIN enrollment_form enf ON c.child_id = enf.child_id
WHERE  c.child_id = p_childId AND c.is_active = 1;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetStudentAllDetails1`(
    IN p_childId INT
)
BEGIN
    
SELECT c.child_id,
    c.child_first_name,
    c.child_last_name,
    cd.class_name,
    cp.*,
    p1.*,
    p2.parent_name AS parent_two_name,
    p2.parent_email AS parent_two_email,
    p2.parent_street_address AS parent_two_street_address,
    p2.parent_city_address AS parent_two_city_address,
    p2.parent_state_address AS parent_two_state_address,
    p2.parent_zip_address AS parent_two_zip_address,
    p2.home_telephone_number AS parent_two_home_telephone_number,
    p2.business_cell_number AS parent_two_business_cell_number,
    p2.business_city_address AS parent_two_business_city_address,
    p2.business_name AS parent_two_business_name,
    p2.business_state_address AS parent_two_business_state_address,
    p2.business_street_address AS parent_two_business_street_address,
    p2.business_telephone_number AS parent_two_business_telephone_number,
    p2.business_zip_address AS parent_two_business_zip_address,
    p2.home_cell_number AS parent_two_home_cell_number,
    p2.work_hours_from AS parent_two_work_hours_from,
    p2.work_hours_to AS parent_two_work_hours_to,
    phb.*,
    enf.*,
    auf.*,
    adf.*,
    JSON_ARRAY(
    JSON_OBJECT(
        'child_emergency_contact_id', e1.child_emergency_contact_id,
        'child_emergency_contact_name', e1.child_emergency_contact_name,
        'child_emergency_contact_relationship', e1.child_emergency_contact_relationship,
        'child_emergency_contact_telephone_number', e1.child_emergency_contact_telephone_number,
        'child_emergency_contact_full_address', e1.child_emergency_contact_full_address,
        'child_emergency_contact_city_address', e1.child_emergency_contact_city_address,
        'child_emergency_contact_state_address', e1.child_emergency_contact_state_address,
        'child_emergency_contact_zip_address', e1.child_emergency_contact_zip_address
    ),
    JSON_OBJECT(
        'child_emergency_contact_id', e2.child_emergency_contact_id,
        'child_emergency_contact_name', e2.child_emergency_contact_name,
        'child_emergency_contact_relationship', e2.child_emergency_contact_relationship,
        'child_emergency_contact_telephone_number', e2.child_emergency_contact_telephone_number,
        'child_emergency_contact_full_address', e2.child_emergency_contact_full_address,
        'child_emergency_contact_city_address', e2.child_emergency_contact_city_address,
        'child_emergency_contact_state_address', e2.child_emergency_contact_state_address,
        'child_emergency_contact_zip_address', e2.child_emergency_contact_zip_address
    ),
    JSON_OBJECT(
        'child_emergency_contact_id', e3.child_emergency_contact_id,
        'child_emergency_contact_name', e3.child_emergency_contact_name,
        'child_emergency_contact_relationship', e3.child_emergency_contact_relationship,
        'child_emergency_contact_telephone_number', e3.child_emergency_contact_telephone_number,
        'child_emergency_contact_full_address', e3.child_emergency_contact_full_address,
        'child_emergency_contact_city_address', e3.child_emergency_contact_city_address,
        'child_emergency_contact_state_address', e3.child_emergency_contact_state_address,
        'child_emergency_contact_zip_address', e3.child_emergency_contact_zip_address
    )) AS 'emergency_contact_info'
  
FROM child_info c
JOIN class_details cd ON c.class_id = cd.class_id
LEFT JOIN parent_info p1 ON c.parent_id = p1.parent_id
JOIN admission_form adf ON c.child_id = adf.child_id
LEFT JOIN parent_info p2 ON adf.additional_parent_id = p2.parent_id
LEFT JOIN care_provider cp ON adf.care_provider_id = cp.child_care_provider_id
LEFT JOIN emergency_details e1 ON adf.emergency_contact_first_id = e1.child_emergency_contact_id
LEFT JOIN emergency_details e2 ON adf.emergency_contact_second_id = e2.child_emergency_contact_id
LEFT JOIN emergency_details e3 ON adf.emergency_contact_third_id = e3.child_emergency_contact_id
JOIN authorization_form auf ON c.child_id = auf.child_id
JOIN parent_handbook phb ON c.child_id = phb.child_id
JOIN enrollment_form enf ON c.child_id = enf.child_id
WHERE  c.child_id = p_childId AND c.is_active = 1;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetStudentAllDetailsAsNestedJson`(
    IN p_childId INT
)
BEGIN
    
SELECT DISTINCT c.child_id,
    c.child_first_name,
    c.child_last_name,
    c.class_id,
    cd.class_name,
    JSON_OBJECT(
    "child_care_provider_id", cp.child_care_provider_id,
    "child_care_provider_name", cp.child_care_provider_name,
    "child_care_provider_telephone_number", cp.child_care_provider_telephone_number,
    "child_hospital_affiliation", cp.child_hospital_affiliation,
    "child_care_provider_street_address", cp.child_care_provider_street_address,
    "child_care_provider_city_address", cp.child_care_provider_city_address,
    "child_care_provider_state_address", cp.child_care_provider_state_address,
    "child_care_provider_zip_address", cp.child_care_provider_zip_address
  ) AS child_care_provider_info,
	JSON_OBJECT(
    "child_dentist_id", d.child_dentist_id,
    "child_dentist_name", d.child_dentist_name,
    "dentist_telephone_number", d.dentist_telephone_number,
    "dentist_street_address", d.dentist_street_address,
    "dentist_city_address", d.dentist_city_address,
    "dentist_state_address", d.dentist_state_address,
    "dentist_zip_address", d.dentist_zip_address
  ) AS child_dentist_info,
    JSON_OBJECT(
    "parent_id", p1.parent_id,
    "parent_name", p1.parent_name,
    "parent_email", p1.parent_email,
    "parent_street_address", p1.parent_street_address,
    "parent_city_address", p1.parent_city_address,
    "parent_state_address", p1.parent_state_address,
    "parent_zip_address", p1.parent_zip_address,
    "parent_home_telephone_number", p1.home_telephone_number,
    "parent_business_cell_number", p1.business_cell_number,
    "parent_business_city_address", p1.business_city_address,
    "parent_business_name", p1.business_name,
    "parent_business_state_address", p1.business_state_address,
    "parent_business_street_address", p1.business_street_address,
    "parent_business_telephone_number", p1.business_telephone_number,
    "parent_business_zip_address", p1.business_zip_address,
    "parent_home_cell_number", p1.home_cell_number,
    "parent_work_hours_from", p1.work_hours_from,
    "parent_work_hours_to", p1.work_hours_to) AS primary_parent_info,
    JSON_OBJECT(
    "parent_id", p2.parent_id,
    "parent_name", p2.parent_name,
    "parent_email", p2.parent_email,
    "parent_street_address", p2.parent_street_address,
    "parent_city_address", p2.parent_city_address,
    "parent_state_address", p2.parent_state_address,
    "parent_zip_address", p2.parent_zip_address,
    "parent_home_telephone_number", p2.home_telephone_number,
    "parent_business_cell_number", p2.business_cell_number,
    "parent_business_city_address", p2.business_city_address,
    "parent_business_name", p2.business_name,
    "parent_business_state_address", p2.business_state_address,
    "parent_business_street_address", p2.business_street_address,
    "parent_business_telephone_number", p2.business_telephone_number,
    "parent_business_zip_address", p2.business_zip_address,
    "parent_home_cell_number", p2.home_cell_number,
    "parent_work_hours_from", p2.work_hours_from,
    "parent_work_hours_to", p2.work_hours_to) AS additional_parent_info,
    phb.*,
    enf.point_one_field_three,
    enf.point_two_initial_here,
    enf.point_three_initial_here,
  enf.point_four_initial_here,
  enf.point_five_initial_here,
  enf.point_six_initial_here,
  enf.point_seven_initial_here,
  enf.point_eight_initial_here,
  enf.point_nine_initial_here,
  enf.point_ten_initial_here,
  enf.point_eleven_initial_here,
  enf.point_twelve_initial_here,
  enf.point_thirteen_initial_here,
  enf.point_fourteen_initial_here,
  enf.point_fifteen_initial_here,
  enf.point_sixteen_initial_here,
  enf.point_seventeen_initial_here,
  enf.point_eighteen_initial_here,
  enf.point_ninteen_initial_here,
  enf.preferred_start_date,
  enf.preferred_schedule,
  enf.full_day,
  enf.half_day,
  enf.parent_sign_enroll,
  enf.parent_sign_date_enroll,
  enf.admin_sign_enroll,
  enf.admin_sign_date_enroll,
    auf.*,
    adf.*,
    JSON_ARRAY(
    JSON_OBJECT(
        'child_emergency_contact_id', e1.child_emergency_contact_id,
        'child_emergency_contact_name', e1.child_emergency_contact_name,
        'child_emergency_contact_relationship', e1.child_emergency_contact_relationship,
        'child_emergency_contact_telephone_number', e1.child_emergency_contact_telephone_number,
        'child_emergency_contact_full_address', e1.child_emergency_contact_full_address,
        'child_emergency_contact_city_address', e1.child_emergency_contact_city_address,
        'child_emergency_contact_state_address', e1.child_emergency_contact_state_address,
        'child_emergency_contact_zip_address', e1.child_emergency_contact_zip_address
    ),
    JSON_OBJECT(
        'child_emergency_contact_id', e2.child_emergency_contact_id,
        'child_emergency_contact_name', e2.child_emergency_contact_name,
        'child_emergency_contact_relationship', e2.child_emergency_contact_relationship,
        'child_emergency_contact_telephone_number', e2.child_emergency_contact_telephone_number,
        'child_emergency_contact_full_address', e2.child_emergency_contact_full_address,
        'child_emergency_contact_city_address', e2.child_emergency_contact_city_address,
        'child_emergency_contact_state_address', e2.child_emergency_contact_state_address,
        'child_emergency_contact_zip_address', e2.child_emergency_contact_zip_address
    ),
    JSON_OBJECT(
        'child_emergency_contact_id', e3.child_emergency_contact_id,
        'child_emergency_contact_name', e3.child_emergency_contact_name,
        'child_emergency_contact_relationship', e3.child_emergency_contact_relationship,
        'child_emergency_contact_telephone_number', e3.child_emergency_contact_telephone_number,
        'child_emergency_contact_full_address', e3.child_emergency_contact_full_address,
        'child_emergency_contact_city_address', e3.child_emergency_contact_city_address,
        'child_emergency_contact_state_address', e3.child_emergency_contact_state_address,
        'child_emergency_contact_zip_address', e3.child_emergency_contact_zip_address
    )) AS 'emergency_contact_info'
  
FROM child_info c
JOIN class_details cd ON c.class_id = cd.class_id
LEFT JOIN parent_info p1 ON c.parent_id = p1.parent_id
LEFT JOIN admission_form adf ON c.child_id = adf.child_id
LEFT JOIN parent_info p2 ON adf.additional_parent_id = p2.parent_id
LEFT JOIN dentist d ON adf.dentist_id = d.child_dentist_id
LEFT JOIN care_provider cp ON adf.care_provider_id = cp.child_care_provider_id
LEFT JOIN emergency_details e1 ON adf.emergency_contact_first_id = e1.child_emergency_contact_id
LEFT JOIN emergency_details e2 ON adf.emergency_contact_second_id = e2.child_emergency_contact_id
LEFT JOIN emergency_details e3 ON adf.emergency_contact_third_id = e3.child_emergency_contact_id
LEFT JOIN authorization_form auf ON c.child_id = auf.child_id
LEFT JOIN parent_handbook phb ON c.child_id = phb.child_id
LEFT JOIN enrollment_form enf ON c.child_id = enf.child_id
WHERE  c.child_id = p_childId AND c.is_active = 1;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetStudentAllDetailsAsNestedJson1`(
    IN p_childId INT
)
BEGIN
    
SELECT DISTINCT c.child_id,
    c.child_first_name,
    c.child_last_name,
    c.class_id,
    cd.class_name,
    JSON_OBJECT(
    "child_care_provider_id", cp.child_care_provider_id,
    "child_care_provider_name", cp.child_care_provider_name,
    "child_care_provider_telephone_number", cp.child_care_provider_telephone_number,
    "child_hospital_affiliation", cp.child_hospital_affiliation,
    "child_care_provider_street_address", cp.child_care_provider_street_address,
    "child_care_provider_city_address", cp.child_care_provider_city_address,
    "child_care_provider_state_address", cp.child_care_provider_state_address,
    "child_care_provider_zip_address", cp.child_care_provider_zip_address
  ) AS child_care_provider_info,
    JSON_OBJECT(
    "parent_id", p1.parent_id,
    "parent_name", p1.parent_name,
    "parent_email", p1.parent_email,
    "parent_street_address", p1.parent_street_address,
    "parent_city_address", p1.parent_city_address,
    "parent_state_address", p1.parent_state_address,
    "parent_zip_address", p1.parent_zip_address,
    "parent_home_telephone_number", p1.home_telephone_number,
    "parent_business_cell_number", p1.business_cell_number,
    "parent_business_city_address", p1.business_city_address,
    "parent_business_name", p1.business_name,
    "parent_business_state_address", p1.business_state_address,
    "parent_business_street_address", p1.business_street_address,
    "parent_business_telephone_number", p1.business_telephone_number,
    "parent_business_zip_address", p1.business_zip_address,
    "parent_home_cell_number", p1.home_cell_number,
    "parent_work_hours_from", p1.work_hours_from,
    "parent_work_hours_to", p1.work_hours_to) AS primary_parent_info,
    JSON_OBJECT(
    "parent_id", p2.parent_id,
    "parent_name", p2.parent_name,
    "parent_email", p2.parent_email,
    "parent_street_address", p2.parent_street_address,
    "parent_city_address", p2.parent_city_address,
    "parent_state_address", p2.parent_state_address,
    "parent_zip_address", p2.parent_zip_address,
    "parent_home_telephone_number", p2.home_telephone_number,
    "parent_business_cell_number", p2.business_cell_number,
    "parent_business_city_address", p2.business_city_address,
    "parent_business_name", p2.business_name,
    "parent_business_state_address", p2.business_state_address,
    "parent_business_street_address", p2.business_street_address,
    "parent_business_telephone_number", p2.business_telephone_number,
    "parent_business_zip_address", p2.business_zip_address,
    "parent_home_cell_number", p2.home_cell_number,
    "parent_work_hours_from", p2.work_hours_from,
    "parent_work_hours_to", p2.work_hours_to) AS additional_parent_info,
    phb.*,
    enf.point_one_field_three,
    enf.point_two_initial_here,
    enf.point_three_initial_here,
  enf.point_four_initial_here,
  enf.point_five_initial_here,
  enf.point_six_initial_here,
  enf.point_seven_initial_here,
  enf.point_eight_initial_here,
  enf.point_nine_initial_here,
  enf.point_ten_initial_here,
  enf.point_eleven_initial_here,
  enf.point_twelve_initial_here,
  enf.point_thirteen_initial_here,
  enf.point_fourteen_initial_here,
  enf.point_fifteen_initial_here,
  enf.point_sixteen_initial_here,
  enf.point_seventeen_initial_here,
  enf.point_eighteen_initial_here,
  enf.point_ninteen_initial_here,
  enf.preferred_start_date,
  enf.preferred_schedule,
  enf.full_day,
  enf.half_day,
  enf.parent_sign_enroll,
  enf.parent_sign_date_enroll,
  enf.admin_sign_enroll,
  enf.admin_sign_date_enroll,
    auf.*,
    adf.*,
    JSON_ARRAY(
    JSON_OBJECT(
        'child_emergency_contact_id', e1.child_emergency_contact_id,
        'child_emergency_contact_name', e1.child_emergency_contact_name,
        'child_emergency_contact_relationship', e1.child_emergency_contact_relationship,
        'child_emergency_contact_telephone_number', e1.child_emergency_contact_telephone_number,
        'child_emergency_contact_full_address', e1.child_emergency_contact_full_address,
        'child_emergency_contact_city_address', e1.child_emergency_contact_city_address,
        'child_emergency_contact_state_address', e1.child_emergency_contact_state_address,
        'child_emergency_contact_zip_address', e1.child_emergency_contact_zip_address
    ),
    JSON_OBJECT(
        'child_emergency_contact_id', e2.child_emergency_contact_id,
        'child_emergency_contact_name', e2.child_emergency_contact_name,
        'child_emergency_contact_relationship', e2.child_emergency_contact_relationship,
        'child_emergency_contact_telephone_number', e2.child_emergency_contact_telephone_number,
        'child_emergency_contact_full_address', e2.child_emergency_contact_full_address,
        'child_emergency_contact_city_address', e2.child_emergency_contact_city_address,
        'child_emergency_contact_state_address', e2.child_emergency_contact_state_address,
        'child_emergency_contact_zip_address', e2.child_emergency_contact_zip_address
    ),
    JSON_OBJECT(
        'child_emergency_contact_id', e3.child_emergency_contact_id,
        'child_emergency_contact_name', e3.child_emergency_contact_name,
        'child_emergency_contact_relationship', e3.child_emergency_contact_relationship,
        'child_emergency_contact_telephone_number', e3.child_emergency_contact_telephone_number,
        'child_emergency_contact_full_address', e3.child_emergency_contact_full_address,
        'child_emergency_contact_city_address', e3.child_emergency_contact_city_address,
        'child_emergency_contact_state_address', e3.child_emergency_contact_state_address,
        'child_emergency_contact_zip_address', e3.child_emergency_contact_zip_address
    )) AS 'emergency_contact_info'
  
FROM child_info c
JOIN class_details cd ON c.class_id = cd.class_id
LEFT JOIN parent_info p1 ON c.parent_id = p1.parent_id
LEFT JOIN admission_form adf ON c.child_id = adf.child_id
LEFT JOIN parent_info p2 ON adf.additional_parent_id = p2.parent_id
LEFT JOIN care_provider cp ON adf.care_provider_id = cp.child_care_provider_id
LEFT JOIN emergency_details e1 ON adf.emergency_contact_first_id = e1.child_emergency_contact_id
LEFT JOIN emergency_details e2 ON adf.emergency_contact_second_id = e2.child_emergency_contact_id
LEFT JOIN emergency_details e3 ON adf.emergency_contact_third_id = e3.child_emergency_contact_id
LEFT JOIN authorization_form auf ON c.child_id = auf.child_id
LEFT JOIN parent_handbook phb ON c.child_id = phb.child_id
LEFT JOIN enrollment_form enf ON c.child_id = enf.child_id
WHERE  c.child_id = p_childId AND c.is_active = 1;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetStudentFormRepository`(
    IN p_childId INT
)
BEGIN
    SELECT * FROM student_form_repository
    WHERE 
        child_id = p_childId 
        AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spGetYearBasedAllFormStatus`(
    IN p_childId INT,
    IN p_year INT
)
BEGIN
SELECT 
    CASE 
		WHEN admin_sign_admission IS NULL AND parent_sign_admission IS NULL THEN "Incomplete"
		WHEN admin_sign_admission IS NULL THEN "Approval Pending"
        ELSE "Completed"
    END AS form_status,
    "admission_form" AS formname,
    admin_sign_date_admission AS completedTimestamp
    FROM admission_form
    WHERE child_id = p_childId AND is_active = TRUE AND FROM_UNIXTIME(admin_sign_date_admission / 1000, '%Y') =  p_year
    
    UNION
    SELECT 
    CASE 
        WHEN admin_sign_ach IS NULL AND parent_sign_ach IS NULL THEN "Incomplete"
		WHEN admin_sign_ach IS NULL THEN "Approval Pending"
        ELSE "Completed"
    END AS form_status,
    "authorization_form" AS formname,
    admin_sign_date_ach AS completedTimestamp
    FROM authorization_form
    WHERE child_id = p_childId AND is_active = TRUE AND FROM_UNIXTIME(admin_sign_date_ach / 1000, '%Y') =  p_year
    
    UNION
    
    SELECT 
    CASE 
        WHEN admin_sign_enroll IS NULL AND parent_sign_enroll IS NULL THEN "Incomplete"
		WHEN admin_sign_enroll IS NULL THEN "Approval Pending"
        ELSE "Completed"
    END AS form_status,
    "enrollment_form" AS formname,
    admin_sign_date_enroll AS completedTimestamp
    FROM enrollment_form
    WHERE child_id = p_childId AND is_active = TRUE AND FROM_UNIXTIME(admin_sign_date_enroll / 1000, '%Y') =  p_year
    
    UNION
    
    SELECT 
    CASE 
        WHEN admin_sign_handbook IS NULL AND parent_sign_handbook IS NULL THEN "Incomplete"
		WHEN admin_sign_handbook IS NULL THEN "Approval Pending"
        ELSE "Completed"
    END AS form_status,
    "parent_handbook" AS formname,
    admin_sign_date_handbook AS completedTimestamp
    FROM parent_handbook
    WHERE child_id = p_childId AND is_active = TRUE AND FROM_UNIXTIME(admin_sign_date_handbook / 1000, '%Y') =  p_year;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spInsertForm`(
    IN p_form_name VARCHAR(255),
    IN p_state INT
)
BEGIN
    INSERT INTO form_repositary (form_name, state)
    VALUES (p_form_name, p_state);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateAdditionalParentInfoIDOnly`(
    IN p_child_id INT,
    IN p_parent_id INT
)
BEGIN
    UPDATE admission_form
    SET 
        additional_parent_id = COALESCE(p_parent_id, additional_parent_id)
    WHERE 
        child_id = p_child_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateAdminInfo`(
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

CREATE PROCEDURE `spUpdateAdmissionForm`(
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
    IN p_explain_illness_allergy TEXT,
    IN p_existing_illness_allergy INT,
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
    IN p_admin_sign_date_admission BIGINT
)
BEGIN
    UPDATE admission_form
    SET 
        additional_parent_id = COALESCE(p_additional_parent_id,additional_parent_id),
        care_provider_id = COALESCE(p_care_provider_id,care_provider_id),
        dentist_id = COALESCE(p_dentist_id,dentist_id),
        dob = COALESCE(p_dob,dob),
        nick_name = COALESCE(p_nick_name,nick_name),
        primary_language = COALESCE(p_primary_language, primary_language),
        school_age_child_school = COALESCE(p_school_age_child_school,school_age_child_school),
        do_relevant_custody_papers_apply = COALESCE(p_custody_papers_apply,do_relevant_custody_papers_apply),
        gender = COALESCE(p_gender,gender),
        special_diabilities = COALESCE(p_special_diabilities,special_diabilities),
        allergies_medication_reaction = COALESCE(p_allergies_reaction,allergies_medication_reaction),
        additional_info = COALESCE(p_additional_info,additional_info),
        medication = COALESCE(p_medication,medication),
        health_insurance = COALESCE(p_health_insurance,health_insurance),
        policy_number = COALESCE(p_policy_number,policy_number),
        obtaining_emergency_medical_care = COALESCE(p_emergency_medical_care,obtaining_emergency_medical_care),
        administration_first_aid_procedures = COALESCE(p_first_aid_procedures,administration_first_aid_procedures),
        agree_all_above_information_is_correct = COALESCE(p_above_info_is_correct,agree_all_above_information_is_correct),
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
        illness_during_pregnancy = COALESCE(p_illness_in_pregnancy,illness_during_pregnancy),
        condition_of_newborn = COALESCE(p_condition_of_newborn,condition_of_newborn),
        duration_of_pregnancy = COALESCE(p_duration_of_pregnancy,duration_of_pregnancy),
        birth_weight_lbs = COALESCE(p_birth_weight_lbs,birth_weight_lbs),
        birth_weight_oz = COALESCE(p_birth_weight_oz,birth_weight_oz),
        complications = COALESCE(p_complications,complications),
        bottle_fed = COALESCE(p_bottle_fed,bottle_fed),
        breast_fed = COALESCE(p_breast_fed,breast_fed),
        other_siblings_name = COALESCE(p_other_siblings_name,other_siblings_name),
        other_siblings_age = COALESCE(p_other_siblings_age,other_siblings_age),
        family_history_allergies = COALESCE(p_fam_hist_allergies,family_history_allergies),
        family_history_heart_problems = COALESCE(p_fam_hist_heart_problems,family_history_heart_problems),
        family_history_tuberculosis = COALESCE(p_fam_hist_tuberculosis,family_history_tuberculosis),
        family_history_asthma = COALESCE(p_fam_hist_asthma,family_history_asthma),
        family_history_high_blood_pressure = COALESCE(p_fam_hist_high_blood_pressure,family_history_high_blood_pressure),
        family_history_vision_problems = COALESCE(p_fam_hist_vision_problems,family_history_vision_problems),
        family_history_diabetes = COALESCE(p_fam_hist_diabetes,family_history_diabetes),
        family_history_hyperactivity = COALESCE(p_fam_hist_hyperactivity,family_history_hyperactivity),
        family_history_epilepsy = COALESCE(p_fam_hist_epilepsy,family_history_epilepsy),
        no_illnesses_for_this_child = COALESCE(p_fam_hist_no_illness,no_illnesses_for_this_child),
        age_group_friends = COALESCE(p_age_group_friends,age_group_friends),
        neighborhood_friends = COALESCE(p_neighborhood_friends,neighborhood_friends),
        relationship_with_mother = COALESCE(p_relationship_with_mom,relationship_with_mother),
        relationship_with_father = COALESCE(p_relationship_with_dad,relationship_with_father),
        relationship_with_siblings = COALESCE(p_relationship_with_sib,relationship_with_siblings),
        relationship_with_extended_family = COALESCE(p_relationship_extended_family,relationship_with_extended_family),
        fears_conflicts = COALESCE(p_fears_conflicts,fears_conflicts),
        child_response_frustration = COALESCE(p_c_response_frustration,child_response_frustration),
        favorite_activities = COALESCE(p_favorite_activities,favorite_activities),
        last_five_years_moved = COALESCE(p_last_five_years_moved,last_five_years_moved),
        things_used_at_home = COALESCE(p_things_used_home,things_used_at_home),
        hours_of_television_daily = COALESCE(p_hours_of_television_daily,hours_of_television_daily),
        language_used_at_home = COALESCE(p_language_at_home,language_used_at_home),
        changes_at_home_situation = COALESCE(p_changes_home_situation,changes_at_home_situation),
        educational_expectations_of_child = COALESCE(p_educational_expectations_of_child,educational_expectations_of_child),
        fam_his_instructions =COALESCE(p_fam_his_instructions,fam_his_instructions),
        do_you_agree_this_immunization_instructions = COALESCE(p_immunization_instructions,do_you_agree_this_immunization_instructions),
        important_fam_members = COALESCE(p_important_fam_members,important_fam_members),
        about_family_celebrations = COALESCE(p_fam_celebrations,about_family_celebrations),
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
        rest_in_the_middle_day = COALESCE(p_rest_middle_day,rest_in_the_middle_day),
        reason_for_rest_in_the_middle_day = COALESCE(p_reason_rest_middle_day,reason_for_rest_in_the_middle_day),
        rest_routine = COALESCE(p_rest_routine,rest_routine),
        toilet_trained = COALESCE(p_toilet_trained,toilet_trained),
        reason_for_toilet_trained = COALESCE(p_reason_for_toilet_trained,reason_for_toilet_trained),
        explain_for_existing_illness_allergy = COALESCE(p_explain_illness_allergy,explain_for_existing_illness_allergy),
        existing_illness_allergy = COALESCE(p_existing_illness_allergy,existing_illness_allergy),
        functioning_at_age = COALESCE(p_functioning_at_age,functioning_at_age),
        explain_for_functioning_at_age = COALESCE(p_explain_functioning_at_age,explain_for_functioning_at_age),        
        explain_for_able_to_walk = COALESCE(p_explain_able_to_walk,explain_for_able_to_walk),
        able_to_walk = COALESCE(p_able_to_walk,able_to_walk),        
        explain_for_communicate_their_needs = COALESCE(p_explain_communicate_their_needs,explain_for_communicate_their_needs),
        communicate_their_needs = COALESCE(p_communicate_their_needs,communicate_their_needs),
        any_medication = COALESCE(p_any_medication,any_medication),
        explain_for_any_medication = COALESCE(p_explain_for_any_medication,explain_for_any_medication),
        utilize_special_equipment = COALESCE(p_special_equipment,utilize_special_equipment),
        explain_for_utilize_special_equipment = COALESCE(p_explain_special_equipment,explain_for_utilize_special_equipment),
        significant_periods = COALESCE(p_significant_periods,significant_periods),
        explain_for_significant_periods = COALESCE(p_explain_significant_periods,explain_for_significant_periods),
        desire_any_accommodations = COALESCE(p_accommodations,desire_any_accommodations),
        explain_for_desire_any_accommodations = COALESCE(p_explain_for_accommodations,explain_for_desire_any_accommodations),
        additional_information = COALESCE(p_additional_information,additional_information),
        do_you_agree_this = COALESCE(p_child_info_is_correct,do_you_agree_this),
        do_you_agree_this_pick_up_password_form = COALESCE(p_pick_up_password_form,do_you_agree_this_pick_up_password_form),
        child_password_pick_up_password_form = COALESCE(p_child_pick_up_password,child_password_pick_up_password_form),
        photo_usage_photo_video_permission_form = COALESCE(p_photo_video_permission_form,photo_usage_photo_video_permission_form),
        photo_permission_agree_group_photos_electronic = COALESCE(p_photo_permission_electronic,photo_permission_agree_group_photos_electronic),
        do_you_agree_this_photo_video_permission_form = COALESCE(p_photo_permission_post,do_you_agree_this_photo_video_permission_form),
        security_release_policy_form = COALESCE(p_security_release_policy_form,security_release_policy_form),
        med_technicians_med_transportation_waiver = COALESCE(p_med_technicians_med_transportation_waiver,med_technicians_med_transportation_waiver),
        medical_transportation_waiver = COALESCE(p_medical_transportation_waiver,medical_transportation_waiver),
        do_you_agree_this_health_policies = COALESCE(p_health_policies,do_you_agree_this_health_policies),
        parent_sign_outside_waiver = COALESCE(p_parent_sign_outside_waiver,parent_sign_outside_waiver),
        approve_social_media_post = COALESCE(p_approve_social_media_post,approve_social_media_post),
        printed_name_social_media_post = COALESCE(p_printed_social_media_post,printed_name_social_media_post),
        do_you_agree_this_social_media_post = COALESCE(p_social_media_post,do_you_agree_this_social_media_post),
        parent_sign_admission = COALESCE(p_parent_sign,parent_sign_admission),
        admin_sign_admission = COALESCE(p_admin_sign,admin_sign_admission),
        emergency_contact_first_id = COALESCE(p_emergency_contact_first_id,emergency_contact_first_id),
        emergency_contact_second_id = COALESCE(p_emergency_contact_second_id,emergency_contact_second_id),
        emergency_contact_third_id = COALESCE(p_emergency_contact_third_id,emergency_contact_third_id),
        pointer = COALESCE(p_pointer,pointer),
        agree_all_above_info_is_correct = COALESCE(p_agree_all_above_info_is_correct,agree_all_above_info_is_correct),
        parent_sign_date_admission = COALESCE(p_parent_sign_date_admission, parent_sign_date_admission),
        admin_sign_date_admission = COALESCE(p_admin_sign_date_admission, admin_sign_date_admission)
    WHERE 
        child_id = p_child_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateAdmissionForm1`(
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
    IN p_explain_illness_allergy TEXT,
    IN p_existing_illness_allergy INT,
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
    IN p_admin_sign_date_admission BIGINT,
    IN `p_child_dentist_name` varchar(255),
    IN `p_dentist_telephone_number` varchar(20),
	IN `p_dentist_street_address` varchar(255),
    IN `p_dentist_city_address` varchar(100),
    IN `p_dentist_state_address` varchar(50),
    IN `p_dentist_ZIP_address` varchar(12)
)
BEGIN
    UPDATE admission_form
    SET 
        additional_parent_id = COALESCE(p_additional_parent_id,additional_parent_id),
        care_provider_id = COALESCE(p_care_provider_id,care_provider_id),
        dentist_id = COALESCE(p_dentist_id,dentist_id),
        dob = COALESCE(p_dob,dob),
        nick_name = COALESCE(p_nick_name,nick_name),
        primary_language = COALESCE(p_primary_language, primary_language),
        school_age_child_school = COALESCE(p_school_age_child_school,school_age_child_school),
        do_relevant_custody_papers_apply = COALESCE(p_custody_papers_apply,do_relevant_custody_papers_apply),
        gender = COALESCE(p_gender,gender),
        special_diabilities = COALESCE(p_special_diabilities,special_diabilities),
        allergies_medication_reaction = COALESCE(p_allergies_reaction,allergies_medication_reaction),
        additional_info = COALESCE(p_additional_info,additional_info),
        medication = COALESCE(p_medication,medication),
        health_insurance = COALESCE(p_health_insurance,health_insurance),
        policy_number = COALESCE(p_policy_number,policy_number),
        obtaining_emergency_medical_care = COALESCE(p_emergency_medical_care,obtaining_emergency_medical_care),
        administration_first_aid_procedures = COALESCE(p_first_aid_procedures,administration_first_aid_procedures),
        agree_all_above_information_is_correct = COALESCE(p_above_info_is_correct,agree_all_above_information_is_correct),
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
        illness_during_pregnancy = COALESCE(p_illness_in_pregnancy,illness_during_pregnancy),
        condition_of_newborn = COALESCE(p_condition_of_newborn,condition_of_newborn),
        duration_of_pregnancy = COALESCE(p_duration_of_pregnancy,duration_of_pregnancy),
        birth_weight_lbs = COALESCE(p_birth_weight_lbs,birth_weight_lbs),
        birth_weight_oz = COALESCE(p_birth_weight_oz,birth_weight_oz),
        complications = COALESCE(p_complications,complications),
        bottle_fed = COALESCE(p_bottle_fed,bottle_fed),
        breast_fed = COALESCE(p_breast_fed,breast_fed),
        other_siblings_name = COALESCE(p_other_siblings_name,other_siblings_name),
        other_siblings_age = COALESCE(p_other_siblings_age,other_siblings_age),
        family_history_allergies = COALESCE(p_fam_hist_allergies,family_history_allergies),
        family_history_heart_problems = COALESCE(p_fam_hist_heart_problems,family_history_heart_problems),
        family_history_tuberculosis = COALESCE(p_fam_hist_tuberculosis,family_history_tuberculosis),
        family_history_asthma = COALESCE(p_fam_hist_asthma,family_history_asthma),
        family_history_high_blood_pressure = COALESCE(p_fam_hist_high_blood_pressure,family_history_high_blood_pressure),
        family_history_vision_problems = COALESCE(p_fam_hist_vision_problems,family_history_vision_problems),
        family_history_diabetes = COALESCE(p_fam_hist_diabetes,family_history_diabetes),
        family_history_hyperactivity = COALESCE(p_fam_hist_hyperactivity,family_history_hyperactivity),
        family_history_epilepsy = COALESCE(p_fam_hist_epilepsy,family_history_epilepsy),
        no_illnesses_for_this_child = COALESCE(p_fam_hist_no_illness,no_illnesses_for_this_child),
        age_group_friends = COALESCE(p_age_group_friends,age_group_friends),
        neighborhood_friends = COALESCE(p_neighborhood_friends,neighborhood_friends),
        relationship_with_mother = COALESCE(p_relationship_with_mom,relationship_with_mother),
        relationship_with_father = COALESCE(p_relationship_with_dad,relationship_with_father),
        relationship_with_siblings = COALESCE(p_relationship_with_sib,relationship_with_siblings),
        relationship_with_extended_family = COALESCE(p_relationship_extended_family,relationship_with_extended_family),
        fears_conflicts = COALESCE(p_fears_conflicts,fears_conflicts),
        child_response_frustration = COALESCE(p_c_response_frustration,child_response_frustration),
        favorite_activities = COALESCE(p_favorite_activities,favorite_activities),
        last_five_years_moved = COALESCE(p_last_five_years_moved,last_five_years_moved),
        things_used_at_home = COALESCE(p_things_used_home,things_used_at_home),
        hours_of_television_daily = COALESCE(p_hours_of_television_daily,hours_of_television_daily),
        language_used_at_home = COALESCE(p_language_at_home,language_used_at_home),
        changes_at_home_situation = COALESCE(p_changes_home_situation,changes_at_home_situation),
        educational_expectations_of_child = COALESCE(p_educational_expectations_of_child,educational_expectations_of_child),
        fam_his_instructions =COALESCE(p_fam_his_instructions,fam_his_instructions),
        do_you_agree_this_immunization_instructions = COALESCE(p_immunization_instructions,do_you_agree_this_immunization_instructions),
        important_fam_members = COALESCE(p_important_fam_members,important_fam_members),
        about_family_celebrations = COALESCE(p_fam_celebrations,about_family_celebrations),
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
        rest_in_the_middle_day = COALESCE(p_rest_middle_day,rest_in_the_middle_day),
        reason_for_rest_in_the_middle_day = COALESCE(p_reason_rest_middle_day,reason_for_rest_in_the_middle_day),
        rest_routine = COALESCE(p_rest_routine,rest_routine),
        toilet_trained = COALESCE(p_toilet_trained,toilet_trained),
        reason_for_toilet_trained = COALESCE(p_reason_for_toilet_trained,reason_for_toilet_trained),
        explain_for_existing_illness_allergy = COALESCE(p_explain_illness_allergy,explain_for_existing_illness_allergy),
        existing_illness_allergy = COALESCE(p_existing_illness_allergy,existing_illness_allergy),
        functioning_at_age = COALESCE(p_functioning_at_age,functioning_at_age),
        explain_for_functioning_at_age = COALESCE(p_explain_functioning_at_age,explain_for_functioning_at_age),        
        explain_for_able_to_walk = COALESCE(p_explain_able_to_walk,explain_for_able_to_walk),
        able_to_walk = COALESCE(p_able_to_walk,able_to_walk),        
        explain_for_communicate_their_needs = COALESCE(p_explain_communicate_their_needs,explain_for_communicate_their_needs),
        communicate_their_needs = COALESCE(p_communicate_their_needs,communicate_their_needs),
        any_medication = COALESCE(p_any_medication,any_medication),
        explain_for_any_medication = COALESCE(p_explain_for_any_medication,explain_for_any_medication),
        utilize_special_equipment = COALESCE(p_special_equipment,utilize_special_equipment),
        explain_for_utilize_special_equipment = COALESCE(p_explain_special_equipment,explain_for_utilize_special_equipment),
        significant_periods = COALESCE(p_significant_periods,significant_periods),
        explain_for_significant_periods = COALESCE(p_explain_significant_periods,explain_for_significant_periods),
        desire_any_accommodations = COALESCE(p_accommodations,desire_any_accommodations),
        explain_for_desire_any_accommodations = COALESCE(p_explain_for_accommodations,explain_for_desire_any_accommodations),
        additional_information = COALESCE(p_additional_information,additional_information),
        do_you_agree_this = COALESCE(p_child_info_is_correct,do_you_agree_this),
        do_you_agree_this_pick_up_password_form = COALESCE(p_pick_up_password_form,do_you_agree_this_pick_up_password_form),
        child_password_pick_up_password_form = COALESCE(p_child_pick_up_password,child_password_pick_up_password_form),
        photo_usage_photo_video_permission_form = COALESCE(p_photo_video_permission_form,photo_usage_photo_video_permission_form),
        photo_permission_agree_group_photos_electronic = COALESCE(p_photo_permission_electronic,photo_permission_agree_group_photos_electronic),
        do_you_agree_this_photo_video_permission_form = COALESCE(p_photo_permission_post,do_you_agree_this_photo_video_permission_form),
        security_release_policy_form = COALESCE(p_security_release_policy_form,security_release_policy_form),
        med_technicians_med_transportation_waiver = COALESCE(p_med_technicians_med_transportation_waiver,med_technicians_med_transportation_waiver),
        medical_transportation_waiver = COALESCE(p_medical_transportation_waiver,medical_transportation_waiver),
        do_you_agree_this_health_policies = COALESCE(p_health_policies,do_you_agree_this_health_policies),
        parent_sign_outside_waiver = COALESCE(p_parent_sign_outside_waiver,parent_sign_outside_waiver),
        approve_social_media_post = COALESCE(p_approve_social_media_post,approve_social_media_post),
        printed_name_social_media_post = COALESCE(p_printed_social_media_post,printed_name_social_media_post),
        do_you_agree_this_social_media_post = COALESCE(p_social_media_post,do_you_agree_this_social_media_post),
        parent_sign_admission = COALESCE(p_parent_sign,parent_sign_admission),
        admin_sign_admission = COALESCE(p_admin_sign,admin_sign_admission),
        emergency_contact_first_id = COALESCE(p_emergency_contact_first_id,emergency_contact_first_id),
        emergency_contact_second_id = COALESCE(p_emergency_contact_second_id,emergency_contact_second_id),
        emergency_contact_third_id = COALESCE(p_emergency_contact_third_id,emergency_contact_third_id),
        pointer = COALESCE(p_pointer,pointer),
        agree_all_above_info_is_correct = COALESCE(p_agree_all_above_info_is_correct,agree_all_above_info_is_correct),
        parent_sign_date_admission = COALESCE(p_parent_sign_date_admission, parent_sign_date_admission),
        admin_sign_date_admission = COALESCE(p_admin_sign_date_admission, admin_sign_date_admission),
        child_dentist_name = COALESCE(p_child_dentist_name,child_dentist_name),
        dentist_telephone_number = COALESCE(p_dentist_telephone_number,dentist_telephone_number),
        dentist_street_address = COALESCE(p_dentist_street_address,dentist_street_address),
        dentist_city_address = COALESCE(p_dentist_city_address,dentist_city_address),
        dentist_state_address = COALESCE(p_dentist_state_address,dentist_state_address),
        dentist_zip_address = COALESCE(p_dentist_zip_address,dentist_zip_address)
    WHERE 
        child_id = p_child_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateAuthorizationForm`(
    IN p_childId INT,
    IN p_bankRoutingAch VARCHAR(255),
    IN p_bankAccountAch VARCHAR(255),
    IN p_driverLicenseAch VARCHAR(255),
    IN p_stateAch VARCHAR(255),
    IN p_iAch VARCHAR(255),
    IN p_parentSignAch VARCHAR(255),
    IN p_adminSignAch VARCHAR(255),
    IN p_parent_sign_date_ach VARCHAR(255),
    IN p_admin_sign_date_ach BIGINT,
    IN p_ach_pointer INT,
    IN p_pointer INT
)
BEGIN
    -- Start Transaction
    START TRANSACTION;

    -- Update authorization_form table
    UPDATE authorization_form
    SET 
        bank_routing = COALESCE(p_bankRoutingAch, bank_routing),
        bank_account = COALESCE(p_bankAccountAch, bank_account),
        driver_license = COALESCE(p_driverLicenseAch, driver_license),
        state = COALESCE(p_stateAch, state),
        i = COALESCE(p_iAch, i),
        parent_sign_ach = COALESCE(p_parentSignAch, parent_sign_ach),
        admin_sign_ach = COALESCE(p_adminSignAch, admin_sign_ach),
        parent_sign_date_ach = COALESCE(p_parent_sign_date_ach, parent_sign_date_ach),
        admin_sign_date_ach = COALESCE(p_admin_sign_date_ach, admin_sign_date_ach),
        ach_pointer = COALESCE(p_ach_pointer, ach_pointer)
    WHERE 
        child_id = p_childId AND is_active = TRUE;

    -- Update admission_form table
    UPDATE admission_form
    SET 
        pointer = COALESCE(p_pointer, pointer)
    WHERE 
        child_id = p_childId AND is_active = TRUE;

    -- Commit Transaction
    COMMIT;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateCareProvider`(
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
        child_care_provider_name = COALESCE(p_name, child_care_provider_name),
        child_care_provider_telephone_number = COALESCE(p_telephone_number, child_care_provider_telephone_number),
        child_hospital_affiliation = COALESCE(p_hospital_affiliation, child_hospital_affiliation),
        child_care_provider_street_address = COALESCE(p_street_address, child_care_provider_street_address),
        child_care_provider_city_address = COALESCE(p_city_address, child_care_provider_city_address),
        child_care_provider_state_address = COALESCE(p_state_address, child_care_provider_state_address),
        child_care_provider_zip_address = COALESCE(p_zip_address, child_care_provider_zip_address)
    WHERE 
        child_care_provider_id = p_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateCareProviderIdOnly`(
    IN p_child_id INT,
    IN p_care_provider_id INT
)
BEGIN
    UPDATE admission_form
    SET 
        care_provider_id = COALESCE(p_care_provider_id, care_provider_id)
    WHERE 
        child_id = p_child_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateChildClassId`(
    IN p_child_id INT,
    IN p_class_id INT
)
BEGIN
    UPDATE child_info
    SET 
        class_id = p_class_id
    WHERE 
        child_id = p_child_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateChildInfo`(
    IN p_child_id INT,
    IN p_parent_id VARCHAR(255),
    IN p_class_id INT,
    IN p_child_first_name VARCHAR(100),
    IN p_child_last_name VARCHAR(100)
)
BEGIN
    UPDATE child_info
    SET 
        parent_id = COALESCE(p_parent_id, parent_id),
        class_id = COALESCE(p_class_id, class_id),
        child_first_name = COALESCE(p_child_first_name, child_first_name),
        child_last_name = COALESCE(p_child_last_name, child_last_name)
    WHERE 
        child_id = p_child_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateClass`(
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

DELIMITER //

CREATE PROCEDURE `spUpdateClassFormRepository`(
    IN p_oldClassId INT,
    IN p_oldFormId INT,
    IN p_newClassId INT,
    IN p_newFormId INT
)
BEGIN
    UPDATE class_form_repository
    SET 
        class_id = p_newClassId,
        form_id = p_newFormId
    WHERE 
        class_id = p_oldClassId 
        AND form_id = p_oldFormId
        AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateDentist`(
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
        child_dentist_name = COALESCE(p_name, child_dentist_name),
        dentist_telephone_number = COALESCE(p_telephone_number, dentist_telephone_number),
        dentist_street_address = COALESCE(p_street_address, dentist_street_address),
        dentist_city_address = COALESCE(p_city_address, dentist_city_address),
        dentist_state_address = COALESCE(p_state_address, dentist_state_address),
        dentist_zip_address = COALESCE(p_zip_address, dentist_zip_address)
    WHERE 
        child_dentist_id = p_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateDentistIdOnly`(
	IN p_child_id INT,
    IN p_dentist_id INT
)
BEGIN
    UPDATE admission_form
    SET 
        dentist_id = COALESCE(p_dentist_id, dentist_id)
    WHERE 
        child_id = p_child_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateEmergencyContactIDOnly`(
    IN p_child_id INT,
    IN p_emergency_contact_id INT,
    IN p_position INT
)
BEGIN
    IF p_position = 0 THEN
        UPDATE admission_form
        SET 
            emergency_contact_first_id = COALESCE(p_emergency_contact_id, emergency_contact_first_id)
        WHERE 
            child_id = p_child_id AND is_active = TRUE;
    ELSEIF p_position = 1 THEN
        UPDATE admission_form
        SET 
            emergency_contact_second_id = COALESCE(p_emergency_contact_id, emergency_contact_second_id)
        WHERE 
            child_id = p_child_id AND is_active = TRUE;
    ELSEIF p_position = 2 THEN
        UPDATE admission_form
        SET 
            emergency_contact_third_id = COALESCE(p_emergency_contact_id, emergency_contact_third_id)
        WHERE 
            child_id = p_child_id AND is_active = TRUE;
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateEmergencyDetail`(
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
        child_emergency_contact_name = COALESCE(p_contact_name, child_emergency_contact_name),
        child_emergency_contact_relationship = COALESCE(p_contact_relationship, child_emergency_contact_relationship),
        child_emergency_contact_full_address = COALESCE(p_street_address, child_emergency_contact_full_address),
        child_emergency_contact_city_address = COALESCE(p_city_address, child_emergency_contact_city_address),
        child_emergency_contact_state_address = COALESCE(p_state_address, child_emergency_contact_state_address),
        child_emergency_contact_zip_address = COALESCE(p_zip_address, child_emergency_contact_zip_address),
        child_emergency_contact_telephone_number = COALESCE(p_contact_telephone_number, child_emergency_contact_telephone_number)
    WHERE 
        child_emergency_contact_id = p_emergency_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateEnrollmentForm`(
    IN p_childId INT,
    IN p_enrollmentName VARCHAR(255),
    IN p_pointOneFieldThree VARCHAR(255),
    IN p_pointTwoInitialHere VARCHAR(255),
    IN p_pointThreeInitialHere VARCHAR(255),
    IN p_pointFourInitialHere VARCHAR(255),
    IN p_pointFiveInitialHere VARCHAR(255),
    IN p_pointSixInitialHere VARCHAR(255),
    IN p_pointSevenInitialHere VARCHAR(255),
    IN p_pointEightInitialHere VARCHAR(255),
    IN p_pointNineInitialHere VARCHAR(255),
    IN p_pointTenInitialHere VARCHAR(255),
    IN p_pointElevenInitialHere VARCHAR(255),
    IN p_pointTwelveInitialHere VARCHAR(255),
    IN p_pointThirteenInitialHere VARCHAR(255),
    IN p_pointFourteenInitialHere VARCHAR(255),
    IN p_pointFifteenInitialHere VARCHAR(255),
    IN p_pointSixteenInitialHere VARCHAR(255),
    IN p_pointSeventeenInitialHere VARCHAR(255),
    IN p_pointEighteenInitialHere VARCHAR(255),
    IN p_point_ninteen_initial_here VARCHAR(255),
    IN p_preferredStartDate DATE,
    IN p_preferredSchedule VARCHAR(255),
    IN p_fullDay VARCHAR(255),
    IN p_halfDay VARCHAR(255),
    IN p_parentSignEnroll VARCHAR(255),
    IN p_adminSignEnroll VARCHAR(255),
    IN p_parent_sign_date_enroll VARCHAR(255),
    IN p_admin_sign_date_enroll BIGINT,
    IN p_enroll_pointer INT,
    IN p_pointer INT
)
BEGIN

-- Start Transaction
    START TRANSACTION;
    
    UPDATE enrollment_form
    SET 
        child_first_name = COALESCE(p_enrollmentName, child_first_name),
        point_one_field_three = COALESCE(p_pointOneFieldThree, point_one_field_three),
        point_two_initial_here = COALESCE(p_pointTwoInitialHere, point_two_initial_here),
        point_three_initial_here = COALESCE(p_pointThreeInitialHere, point_three_initial_here),
        point_four_initial_here = COALESCE(p_pointFourInitialHere, point_four_initial_here),
        point_five_initial_here = COALESCE(p_pointFiveInitialHere, point_five_initial_here),
        point_six_initial_here = COALESCE(p_pointSixInitialHere, point_six_initial_here),
        point_seven_initial_here = COALESCE(p_pointSevenInitialHere, point_seven_initial_here),
        point_eight_initial_here = COALESCE(p_pointEightInitialHere, point_eight_initial_here),
        point_nine_initial_here = COALESCE(p_pointNineInitialHere, point_nine_initial_here),
        point_ten_initial_here = COALESCE(p_pointTenInitialHere, point_ten_initial_here),
        point_eleven_initial_here = COALESCE(p_pointElevenInitialHere, point_eleven_initial_here),
        point_twelve_initial_here = COALESCE(p_pointTwelveInitialHere, point_twelve_initial_here),
        point_thirteen_initial_here = COALESCE(p_pointThirteenInitialHere, point_thirteen_initial_here),
        point_fourteen_initial_here = COALESCE(p_pointFourteenInitialHere, point_fourteen_initial_here),
        point_fifteen_initial_here = COALESCE(p_pointFifteenInitialHere, point_fifteen_initial_here),
        point_sixteen_initial_here = COALESCE(p_pointSixteenInitialHere, point_sixteen_initial_here),
        point_seventeen_initial_here = COALESCE(p_pointSeventeenInitialHere, point_seventeen_initial_here),
        point_eighteen_initial_here = COALESCE(p_pointEighteenInitialHere, point_eighteen_initial_here),
        point_ninteen_initial_here = COALESCE(p_point_ninteen_initial_here, point_ninteen_initial_here),
        preferred_start_date = COALESCE(p_preferredStartDate, preferred_start_date),
        preferred_schedule = COALESCE(p_preferredSchedule, preferred_schedule),
        full_day = COALESCE(p_fullDay, full_day),
        half_day = COALESCE(p_halfDay, half_day),
        parent_sign_enroll = COALESCE(p_parentSignEnroll, parent_sign_enroll),
        admin_sign_enroll = COALESCE(p_adminSignEnroll, admin_sign_enroll),
        parent_sign_date_enroll = COALESCE(p_parent_sign_date_enroll, parent_sign_date_enroll),
        admin_sign_date_enroll = COALESCE(p_admin_sign_date_enroll, admin_sign_date_enroll),
        enroll_pointer = COALESCE(p_enroll_pointer, enroll_pointer)
    WHERE 
        child_id = p_childId AND is_active = TRUE;

    -- Update admission_form table
    UPDATE admission_form
    SET 
        pointer = COALESCE(p_pointer, pointer)
    WHERE 
        child_id = p_childId AND is_active = TRUE;

    -- Commit Transaction
    COMMIT;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateForm`(
    IN p_form_id INT,
    IN p_form_name VARCHAR(255),
    IN p_state INT
)
BEGIN
    UPDATE form_repositary
    SET form_name = p_form_name, state = p_state
    WHERE form_id = p_form_id;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateFormInfo`(
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

CREATE PROCEDURE `⁠spUpdateMultipleFormStatus⁠`(IN form_ids VARCHAR(255))
BEGIN
    -- Update form status for the provided list of form IDs
    UPDATE all_form_info 
    SET form_status = 'Active'
    WHERE FIND_IN_SET(form_id, form_ids) > 0 AND form_status = 'Available';
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateParentAsArchiev`(
    IN p_parent_id INT
)
BEGIN
    UPDATE parent_info
    SET 
        status = 2
    WHERE parent_id = p_parent_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateParentAsArchive`(
    IN p_parent_id INT
)
BEGIN
    UPDATE parent_info
    SET 
        status = 2
    WHERE parent_id = p_parent_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateParentHandbook`(
    IN p_child_id INT,
    IN p_welcome_goddard_agreement VARCHAR(255),
    IN p_mission_statement_agreement VARCHAR(255),
    IN p_general_information_agreement VARCHAR(255),
    IN p_medical_care_provider_agreement VARCHAR(255),
    IN p_parent_access_agreement VARCHAR(255),
    IN p_release_of_children_agreement VARCHAR(255),
    IN p_registration_fees_agreement VARCHAR(255),
    IN p_outside_engagements_agreement VARCHAR(255),
    IN p_health_policies_agreement VARCHAR(255),
    IN p_medication_procedures_agreement VARCHAR(255),
    IN p_bring_to_school_agreement VARCHAR(255),
    IN p_rest_time_agreement VARCHAR(255),
    IN p_training_philosophy_agreement VARCHAR(255),
    IN p_affiliation_policy_agreement VARCHAR(255),
    IN p_security_issue_agreement VARCHAR(255),
    IN p_expulsion_policy_agreement VARCHAR(255),
    IN p_addressing_individual_child_agreement VARCHAR(255),
    IN p_finalword_agreement VARCHAR(255),
    IN p_parent_sign_handbook VARCHAR(255),
    IN p_admin_sign_handbook VARCHAR(255),
    IN p_parent_sign_date_handbook VARCHAR(255),
    IN p_admin_sign_date_handbook BIGINT,
    IN p_handbook_pointer INT,
    IN p_pointer INT
)
BEGIN

-- Start Transaction
    START TRANSACTION;
    
    UPDATE parent_handbook
    SET 
        welcome_goddard_agreement = COALESCE(p_welcome_goddard_agreement, welcome_goddard_agreement),
        mission_statement_agreement = COALESCE(p_mission_statement_agreement, mission_statement_agreement),
        general_information_agreement = COALESCE(p_general_information_agreement, general_information_agreement),
        medical_care_provider_agreement = COALESCE(p_medical_care_provider_agreement, medical_care_provider_agreement),
        parent_access_agreement = COALESCE(p_parent_access_agreement, parent_access_agreement),
        release_of_children_agreement = COALESCE(p_release_of_children_agreement, release_of_children_agreement),
        registration_fees_agreement = COALESCE(p_registration_fees_agreement, registration_fees_agreement),
        outside_engagements_agreement = COALESCE(p_outside_engagements_agreement, outside_engagements_agreement),
        health_policies_agreement = COALESCE(p_health_policies_agreement, health_policies_agreement),
        medication_procedures_agreement = COALESCE(p_medication_procedures_agreement, medication_procedures_agreement),
        bring_to_school_agreement = COALESCE(p_bring_to_school_agreement, bring_to_school_agreement),
        rest_time_agreement = COALESCE(p_rest_time_agreement, rest_time_agreement),
        training_philosophy_agreement = COALESCE(p_training_philosophy_agreement, training_philosophy_agreement),
        affiliation_policy_agreement = COALESCE(p_affiliation_policy_agreement, affiliation_policy_agreement),
        security_issue_agreement = COALESCE(p_security_issue_agreement, security_issue_agreement),
        expulsion_policy_agreement = COALESCE(p_expulsion_policy_agreement, expulsion_policy_agreement),
        addressing_individual_child_agreement = COALESCE(p_addressing_individual_child_agreement, addressing_individual_child_agreement),
        finalword_agreement = COALESCE(p_finalword_agreement, finalword_agreement),
        parent_sign_handbook = COALESCE(p_parent_sign_handbook, parent_sign_handbook),
        admin_sign_handbook = COALESCE(p_admin_sign_handbook, admin_sign_handbook),
        parent_sign_date_handbook = COALESCE(p_parent_sign_date_handbook, parent_sign_date_handbook),
        admin_sign_date_handbook = COALESCE(p_admin_sign_date_handbook, admin_sign_date_handbook),
        handbook_pointer = COALESCE(p_handbook_pointer, handbook_pointer)
        
    WHERE 
        child_id = p_child_id AND is_active = TRUE;

    -- Update admission_form table
    UPDATE admission_form
    SET 
        pointer = COALESCE(p_pointer, pointer)
    WHERE 
        child_id = p_child_id AND is_active = TRUE;

    -- Commit Transaction
    COMMIT;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateParentInfo`(
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
        parent_email = COALESCE(p_email,parent_email),
        parent_street_address = COALESCE(p_street_address,parent_street_address),
        parent_city_address = COALESCE(p_city_address,parent_city_address),
        parent_state_address = COALESCE(p_state_address,parent_state_address),
        parent_zip_address = COALESCE(p_zip_address,parent_zip_address),
        home_telephone_number = COALESCE(p_home_telephone_number,home_telephone_number),
        home_cell_number = COALESCE(p_home_cellphone_number,home_cell_number),
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

CREATE PROCEDURE `spUpdateParentInfoPassword`(
    IN p_parent_id INT,
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_url VARCHAR(255)
)
BEGIN
    UPDATE parent_info
    SET 
        parent_email = COALESCE(p_email, parent_email),
        password = COALESCE(p_password, password),
        signup_url = COALESCE(p_url, signup_url),
        is_password_reset = TRUE
        
    WHERE 
        parent_id = p_parent_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateParentInfoStatus`(
    IN p_parent_id INT,
    IN p_status INT
)
BEGIN
    UPDATE parent_info
    SET 
        status = p_status
    WHERE parent_id = p_parent_id AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateParentInvite`(
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

CREATE PROCEDURE `spUpdateParentPassword`(
    IN p_parent_email VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    UPDATE parent_info
    SET password = p_password,
		is_password_reset = TRUE
    
    WHERE parent_email = p_parent_email;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdatePasswordResetFlag`(
    IN p_parent_email VARCHAR(255),
    IN p_url VARCHAR(255)
)
BEGIN
    UPDATE parent_info
    SET is_password_reset = False,
		signup_url = p_url
    WHERE parent_email = p_parent_email AND is_active = TRUE;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `spUpdateStudentFormRepository`(
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

DELIMITER //

CREATE DEFINER=`developer`@`%` PROCEDURE `StudentSegmentDataGet`(
    IN p_student_id INT
)
BEGIN
    DECLARE student_json JSON;
    DECLARE hs_marks_json JSON;
    DECLARE hss_11_marks_json JSON;
    DECLARE hss_12_marks_json JSON;
    DECLARE diploma_marks_json JSON;
    DECLARE father_json JSON;
    DECLARE mother_json JSON;
    DECLARE guardian_json JSON;
    -- DECLARE sibling_list_json JSON_ARRAY;
    DECLARE result_json JSON;

    -- Fetch student details as JSON
    SELECT IFNULL(JSON_OBJECT(
        'student_id', student_id,
        'first_name', first_name,
        'last_name', last_name,
        'scholarship_source', scholarship_source,
        'date_of_birth', date_of_birth,
        'gender', gender,
        'address', address,
        'district', district,
        'pincode', pincode,
        'mobile_number', mobile_number,
        'alt_mobile_number', alt_mobile_number,
        'email', email,
        'physically_challenged', physically_challenged,
        'living_with', living_with,
        'course_of_study', course_of_study,
        'ambition1', ambition1,
        'ambition2', ambition2,
        'community', community,
        'first_graduate', first_graduate,
        '10th_school_name', 10th_school_name,
        '10th_school_region_type', 10th_school_region_type,
        '10th_school_type', 10th_school_type,
        '10th_total_marks', 10th_total_marks,
        '11th_school_name', 11th_school_name,
        '11th_school_region_type', 11th_school_region_type,
        '11th_school_type', 11th_school_type,
        '11th_total_marks', 11th_total_marks,
        '12th_school_name', 12th_school_name,
        '12th_school_region_type', 12th_school_region_type,
        '12th_school_type', 12th_school_type,
        '12th_total_marks', 12th_total_marks,
        'diploma_school_name', diploma_school_name,
        'diploma_school_region_type', diploma_school_region_type,
        'diploma_school_type', diploma_school_type,
        'diploma_percentage', diploma_percentage,
        'hs_group_subject_list', hs_group_subject_list,
        'pg_name', pg_name,
        'pg_relationship_type', pg_relationship_type,
        'pg_education_level', pg_education_level,
        'pg_occupation', pg_occupation,
        'pg_mobile_number', pg_mobile_number,
        'pg_email', pg_email,
        'total_members', total_members,
        'family_income', family_income
    ), JSON_OBJECT()) INTO student_json
    FROM student
    WHERE student_id = p_student_id AND is_active = 1;

    -- Fetch HS Marks as JSON
    SELECT IFNULL(JSON_OBJECT(
        'student_id', student_id, 
        'year_passed', year_passed, 
        'registration_number', registration_number, 
        'medium_of_study', medium_of_study, 
        'language_name', language_name, 
        'language_marks', language_marks, 
        'english_marks', english_marks, 
        'math_marks', math_marks, 
        'science_marks', science_marks, 
        'social_science_marks', social_science_marks, 
        'total_marks', total_marks
    ), JSON_OBJECT()) INTO hs_marks_json
    FROM hs_marks
    WHERE student_id = p_student_id AND is_active = 1;

    -- Fetch 11th HSS Marks as JSON
    SELECT IFNULL(JSON_OBJECT(
        'student_id', student_id, 
        'standard', standard, 
        'year_passed', year_passed, 
        'registration_number', registration_number,  -- Fixed typo
        'medium_of_study', medium_of_study, 
        'engineering_cutoff', engineering_cutoff, 
        'neet_score', neet_score, 
        'agri_cutoff', agri_cutoff, 
        'hs_group_subject_list', hs_group_subject_list, 
        'language_name', language_name, 
        'language_marks', language_marks, 
        'english_marks', english_marks, 
        'subject1_mark', subject1_mark, 
        'subject2_mark', subject2_mark, 
        'subject3_mark', subject3_mark, 
        'subject4_mark', subject4_mark, 
        'total_marks', total_marks
    ), JSON_OBJECT()) INTO hss_11_marks_json
    FROM hss_marks
    WHERE student_id = p_student_id AND standard = '11th' AND is_active = 1;

    -- Fetch 12th HSS Marks as JSON
    SELECT IFNULL(JSON_OBJECT(
        'student_id', student_id, 
        'standard', standard, 
        'year_passed', year_passed, 
        'registration_number', registration_number,  -- Fixed typo
        'medium_of_study', medium_of_study, 
        'engineering_cutoff', engineering_cutoff, 
        'neet_score', neet_score, 
        'agri_cutoff', agri_cutoff, 
        'hs_group_subject_list', hs_group_subject_list, 
        'language_name', language_name, 
        'language_marks', language_marks, 
        'english_marks', english_marks, 
        'subject1_mark', subject1_mark, 
        'subject2_mark', subject2_mark, 
        'subject3_mark', subject3_mark, 
        'subject4_mark', subject4_mark, 
        'total_marks', total_marks
    ), JSON_OBJECT()) INTO hss_12_marks_json
    FROM hss_marks
    WHERE student_id = p_student_id AND standard = '12th' AND is_active = 1;

    -- Fetch Diploma Marks as JSON
    SELECT IFNULL(JSON_OBJECT(
        'student_id', student_id,
        'course', course,
        'diploma_percentage', diploma_percentage,
        'year_passed', year_passed,
        'medium_of_study', medium_of_study
    ), JSON_OBJECT()) INTO diploma_marks_json
    FROM diploma_marks
    WHERE student_id = p_student_id and is_active = 1;

     -- Fetch Father Details as JSON
    SELECT IFNULL(JSON_OBJECT(
        'relationship_type', relationship_type,
        'name', name,
        'age', age,
        'status', status,
        'occupation', occupation,
        'salary', salary,
        'education_level', education_level
    ), JSON_OBJECT()) INTO father_json
    FROM relationship
    WHERE student_id = p_student_id and relationship_type = 'Father' and is_active = 1;

         -- Fetch Mother Details as JSON
    SELECT IFNULL(JSON_OBJECT(
        'relationship_type', relationship_type,
        'name', name,
        'age', age,
        'status', status,
        'occupation', occupation,
        'salary', salary,
        'education_level', education_level
    ), JSON_OBJECT()) INTO mother_json
    FROM relationship
    WHERE student_id = p_student_id and relationship_type = 'Mother' and is_active = 1;

    -- Fetch Guardian Details as JSON
    SELECT IFNULL(JSON_OBJECT(
        'relationship_type', relationship_type,
        'name', name,
        'age', age,
        'status', status,
        'occupation', occupation,
        'salary', salary,
        'education_level', education_level
    ), JSON_OBJECT()) INTO guardian_json
    FROM relationship
    WHERE student_id = p_student_id and relationship_type = 'Guardian' and is_active = 1;

    -- Combine all JSON objects into a final result
    SET result_json = JSON_OBJECT(
        'student_details', student_json,
        'tenth_mark_details', hs_marks_json,
        'eleventh_mark_details', hss_11_marks_json,
        'twelfth_mark_details', hss_12_marks_json,
        'diploma_mark_details', diploma_marks_json,
        'father_details', father_json,
        'mother_details', mother_json,
        'guardian_details', guardian_json
    );

    -- Return the combined JSON result
    SELECT result_json AS student_details;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE `UpdateFormRepoFormState`(
    IN form_ids VARCHAR(255),
    IN new_state INT
)
BEGIN

	SET SQL_SAFE_UPDATES = 0;
    -- Update all form_id entries in the form_repositary table where form_id is in the form_ids list
    UPDATE form_repositary
    SET state = new_state
    WHERE FIND_IN_SET(form_id, form_ids);
    
    SET SQL_SAFE_UPDATES = 1;
END //

DELIMITER ;






