                                        --Goddard Database Tables--

--admin_info table
CREATE TABLE `admin_info` (
  `email_id` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `apporved_by` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--admission_form table
CREATE TABLE `admission_form` (
  `child_id` int NOT NULL,
  `additional_parent_id` int DEFAULT NULL,
  `care_provider_id` int DEFAULT NULL,
  `dentist_id` int DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `nick_name` varchar(100) DEFAULT NULL,
  `primary_language` varchar(50) DEFAULT NULL,
  `school_age_child_school` varchar(100) DEFAULT NULL,
  `do_relevant_custody_papers_apply` int DEFAULT '2',
  `gender` int DEFAULT '2',
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
  `approve_social_media_post` int DEFAULT '2',
  `printed_name_social_media_post` varchar(100) DEFAULT NULL,
  `do_you_agree_this_social_media_post` varchar(255) DEFAULT NULL,
  `parent_sign_admission` varchar(100) DEFAULT NULL,
  `parent_sign_date_admission` varchar(255) DEFAULT NULL,
  `admin_sign_admission` varchar(100) DEFAULT NULL,
  `admin_sign_date_admission` varchar(255) DEFAULT NULL,
  `emergency_contact_first_id` int DEFAULT NULL,
  `emergency_contact_second_id` int DEFAULT NULL,
  `emergency_contact_third_id` int DEFAULT NULL,
  `pointer` int DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--all_form_info table
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--authorization_form table
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
  `admin_sign_date_ach` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--care_provider table
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--child_info table
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--class_details table
CREATE TABLE `class_details` (
  `class_id` int NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--class_form_repository table
CREATE TABLE `class_form_repository` (
  `class_id` int NOT NULL,
  `form_id` int NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`form_id`,`class_id`),
  KEY `class_id` (`class_id`),
  CONSTRAINT `class_form_repository_ibfk_1` FOREIGN KEY (`form_id`) REFERENCES `all_form_info` (`form_id`),
  CONSTRAINT `class_form_repository_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `class_details` (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--dentist table
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--emergency_details table
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--enrollment_form table
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
  `admin_sign_date_enroll` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--form_repositary table
CREATE TABLE `form_repositary` (
  `form_id` int NOT NULL AUTO_INCREMENT,
  `form_name` varchar(255) NOT NULL,
  `state` int NOT NULL,
  PRIMARY KEY (`form_id`),
  UNIQUE KEY `form_name` (`form_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--parent_handbook table
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
  `admin_sign_date_handbook` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--parent_info table
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--parent_invite_info table
CREATE TABLE `parent_invite_info` (
  `invite_email` varchar(255) NOT NULL,
  `parent_id` int DEFAULT NULL,
  `invite_id` varchar(255) DEFAULT NULL,
  `time_stamp` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`invite_email`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `parent_invite_info_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `parent_info` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--student_form_repository table
CREATE TABLE `student_form_repository` (
  `child_id` int NOT NULL,
  `form_id` int NOT NULL,
  `form_status` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`child_id`,`form_id`),
  KEY `form_id` (`form_id`),
  CONSTRAINT `student_form_repository_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `child_info` (`child_id`),
  CONSTRAINT `student_form_repository_ibfk_2` FOREIGN KEY (`form_id`) REFERENCES `form_repositary` (`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci