                                        --Goddard Database Stored Procedures--

                                                --Admin Info CRUD--

--Create details
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

--Retrieve record based on email-id
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAdminInfo`(
    IN p_email_id VARCHAR(255)
)
BEGIN
    SELECT * FROM admin_info
    WHERE email_id = p_email_id AND is_active = TRUE;
END

--Retrieve all records
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAllAdminInfo`()
BEGIN
    SELECT * FROM admin_info
    WHERE is_active = TRUE;
END

--Update record based on email-id
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
END

--Delete record based on email-id
CREATE DEFINER=`admin`@`%` PROCEDURE `spDeleteAdminInfo`(
    IN p_email_id VARCHAR(255)
)
BEGIN
    UPDATE admin_info
    SET is_active = FALSE
    WHERE 
        email_id = p_email_id;
END


                                                    --Parent Invite CRUD--

--Create record
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateParentInvite`(
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
END

--Retrieve record based on email-id
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetParentInvite`(
    IN p_email VARCHAR(255)
)
BEGIN
    SELECT * FROM parent_invite_info
    WHERE invite_email = p_email;
END

--Retrieve all records
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAllParentInvites`()
BEGIN
    SELECT * FROM parent_invite_info;
END

--Update record based on email-id
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
END
--Delete record based on email-id
CREATE DEFINER=`admin`@`%` PROCEDURE `spDeleteParentInvite`(
    IN p_email VARCHAR(255)
)
BEGIN
    DELETE FROM parent_invite_info
    WHERE invite_email = p_email;
END


                                                    --Child Info CRUD--(pending)

--Create record
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

--Retrieve record based on child-id
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetChildInfo`(
    IN p_child_id INT
)
BEGIN
    SELECT * FROM child_info
    WHERE 
        child_id = p_child_id AND is_active = TRUE;
END

--Retrieve all records
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAllChildInfo`()
BEGIN
    SELECT * FROM child_info
    WHERE 
        is_active = TRUE;
END

--Update record based on child-id
CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateChildInfo`(
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
END

--Update child class id based on child-id
CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateChildClassId`(
    IN p_child_id INT,
    IN p_class_id INT
)
BEGIN
    UPDATE child_info
    SET 
        class_id = p_class_id
    WHERE 
        child_id = p_child_id AND is_active = TRUE;
END

--Delete record based on child-id
CREATE DEFINER=`admin`@`%` PROCEDURE `spDeleteChildInfo`(
    IN p_child_id INT
)
BEGIN
    UPDATE child_info
    SET 
        is_active = FALSE
    WHERE 
        child_id = p_child_id;
END


                                                        --All Form Info CRUD--

--Create record
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateFormInfo`(
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
END

--Retrieve record based on form-id
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetFormInfo`(
    IN p_form_id INT
)
BEGIN
    SELECT * FROM form_repositary
    WHERE 
        form_id = p_form_id;
END

--Retrieve all records
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAllFormInfo`()
BEGIN
    SELECT * FROM all_form_info
    WHERE 
        is_active = TRUE;
END

--Update record based on form id
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
END

--Delete record based on form id
CREATE DEFINER=`admin`@`%` PROCEDURE `spDeleteFormInfo`(
    IN p_form_id INT
)
BEGIN
    UPDATE all_form_info
    SET is_active = FALSE
    WHERE 
        form_id = p_form_id;
END


                                                        --Parent Info CRUD--(pending)

--Create record with all details
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateParentInfoWithAllDetails`(
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
END
--Retrieve record based on parent id
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetParentInfo`(
    IN p_parent_id INT
)
BEGIN
    SELECT * 
    FROM parent_info 
    WHERE parent_id = p_parent_id AND is_active = TRUE;
END

--Retrieve all records
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAllParentInfo`()
BEGIN
    SELECT * 
    FROM parent_info 
    WHERE is_active = TRUE;
END

--Update record based on parent id
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
END
--Delete record based on parent id
CREATE DEFINER=`admin`@`%` PROCEDURE `spDeleteParentInfo`(
    IN p_parent_id INT
)
BEGIN
    UPDATE parent_info
    SET is_active = FALSE
    WHERE parent_id = p_parent_id;
END


--Class Details CRUD--

--Create record
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateClass`(
    IN p_className VARCHAR(255)
)
BEGIN
    INSERT INTO class_details (class_name, is_active)
    VALUES (p_className, TRUE);
END

--Retrieve record based on class id
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetClass`(
    IN p_classId INT
)
BEGIN
    SELECT * FROM class_details
    WHERE 
        class_id = p_classId AND is_active = TRUE;
END

--Retrieve all records
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAllClass`()
BEGIN
    SELECT * FROM class_details
    WHERE 
        is_active = TRUE;
END

--Update record based on class id
CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateClass`(
    IN p_classId INT,
    IN p_className VARCHAR(255)
)
BEGIN
    UPDATE class_details
    SET 
        class_name = p_className
    WHERE 
        class_id = p_classId AND is_active = TRUE;
END

--Delete record based on class id
CREATE DEFINER=`admin`@`%` PROCEDURE `spDeleteClass`(
    IN p_classId INT
)
BEGIN
    UPDATE class_details
    SET is_active = FALSE
    WHERE 
        class_id = p_classId;
END

                                                        --Care Provider CRUD--

--Create record
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

--Retrieve record based on child care provider id
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetCareProvider`(
    IN p_id INT
)
BEGIN
    SELECT * FROM care_provider
    WHERE child_care_provider_id = p_id AND is_active = TRUE;
END

--Retrieve all records
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAllCareProviders`()
BEGIN
    SELECT * FROM care_provider
    WHERE is_active = TRUE;
END

--Update record based on child care provider id
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
        child_care_provider_name = COALESCE(p_name, child_care_provider_name),
        child_care_provider_telephone_number = COALESCE(p_telephone_number, child_care_provider_telephone_number),
        child_hospital_affiliation = COALESCE(p_hospital_affiliation, child_hospital_affiliation),
        child_care_provider_street_address = COALESCE(p_street_address, child_care_provider_street_address),
        child_care_provider_city_address = COALESCE(p_city_address, child_care_provider_city_address),
        child_care_provider_state_address = COALESCE(p_state_address, child_care_provider_state_address),
        child_care_provider_zip_address = COALESCE(p_zip_address, child_care_provider_zip_address)
    WHERE 
        child_care_provider_id = p_id AND is_active = TRUE;
END

--Delete record based on child care provider id
CREATE DEFINER=`admin`@`%` PROCEDURE `spDeleteCareProvider`(
    IN p_id INT
)
BEGIN
    UPDATE care_provider
    SET is_active = FALSE
    WHERE child_care_provider_id = p_id;
END


                                                        --Dentist CRUD--

--Create record
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

--Retrieve record based on child dentist id
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetDentist`(
    IN p_id INT
)
BEGIN
    SELECT * FROM dentist
    WHERE child_dentist_id = p_id AND is_active = TRUE;
END

--Retrieve all records
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAllDentists`()
BEGIN
    SELECT * FROM dentist
    WHERE is_active = TRUE;
END

--Update record based on child dentist id
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
        child_dentist_name = COALESCE(p_name, child_dentist_name),
        dentist_telephone_number = COALESCE(p_telephone_number, dentist_telephone_number),
        dentist_street_address = COALESCE(p_street_address, dentist_street_address),
        dentist_city_address = COALESCE(p_city_address, dentist_city_address),
        dentist_state_address = COALESCE(p_state_address, dentist_state_address),
        dentist_zip_address = COALESCE(p_zip_address, dentist_zip_address)
    WHERE 
        child_dentist_id = p_id AND is_active = TRUE;
END

--Delete record based on child dentist id
CREATE DEFINER=`admin`@`%` PROCEDURE `spDeleteDentist`(
    IN p_id INT
)
BEGIN
    UPDATE dentist
    SET is_active = FALSE
    WHERE child_dentist_id = p_id;
END

                                                        --Emergency Details CRUD--

--Create record
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

--Retrieve record based on child emergency contact id
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetEmergencyDetail`(
    IN p_emergency_id INT
)
BEGIN
    SELECT * FROM emergency_details
    WHERE child_emergency_contact_id = p_emergency_id AND is_active = TRUE;
END

--Retrieve all records
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAllEmergencyDetails`()
BEGIN
    SELECT * FROM emergency_details
    WHERE is_active = TRUE;
END

--Update record based on child emergency contact id
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
        child_emergency_contact_name = COALESCE(p_contact_name, child_emergency_contact_name),
        child_emergency_contact_relationship = COALESCE(p_contact_relationship, child_emergency_contact_relationship),
        child_emergency_contact_full_address = COALESCE(p_street_address, child_emergency_contact_full_address),
        child_emergency_contact_city_address = COALESCE(p_city_address, child_emergency_contact_city_address),
        child_emergency_contact_state_address = COALESCE(p_state_address, child_emergency_contact_state_address),
        child_emergency_contact_zip_address = COALESCE(p_zip_address, child_emergency_contact_zip_address),
        child_emergency_contact_telephone_number = COALESCE(p_contact_telephone_number, child_emergency_contact_telephone_number)
    WHERE 
        child_emergency_contact_id = p_emergency_id AND is_active = TRUE;
END

--Delete record based on child emergency contact id
CREATE DEFINER=`admin`@`%` PROCEDURE `spDeleteEmergencyDetail`(
    IN p_emergency_id INT
)
BEGIN
    UPDATE emergency_details
    SET is_active = FALSE
    WHERE child_emergency_contact_id = p_emergency_id;
END


                                                        --Class Form Repository CRUD--

--Create record
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateClassFormRepository`( 
    IN p_classId INT,
    IN p_formId INT
)
BEGIN
    INSERT INTO class_form_repository (class_id, form_id, is_active)
    VALUES (p_classId, p_formId, TRUE);
END

--Retrieve record based on class id & form id
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetClassFormRepository`(
    IN p_classId INT,
    IN p_formId INT
)
BEGIN
    SELECT * FROM class_form_repository
    WHERE 
        class_id = p_classId 
        AND form_id = p_formId
        AND is_active = TRUE;
END

--Retrieve all records
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAllClassFormRepository`()
BEGIN
    SELECT * FROM class_form_repository
    WHERE 
        is_active = TRUE;
END

--Update record based on class id & form id
CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateClassFormRepository`(
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
END

--Delete record based on class id & form id
CREATE DEFINER=`admin`@`%` PROCEDURE `spDeleteClassFormRepository`(
    IN p_classId INT,
    IN p_formId INT
)
BEGIN
    UPDATE class_form_repository
    SET is_active = FALSE
    WHERE 
        class_id = p_classId 
        AND form_id = p_formId;
END


                                                        --Admission Form CRUD--

--Create record
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

--Retrieve record based on child id
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAdmissionForm`(
    IN p_child_id INT
)
BEGIN
    SELECT * FROM admission_form
    WHERE child_id = p_child_id AND is_active = TRUE;
END

--Retrieve all records
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAllAdmissionForms`()
BEGIN
    SELECT * 
    FROM admission_form 
    WHERE is_active = TRUE;
END

--Update record based on child id
CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateAdmissionForm`(
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
    IN p_admin_sign_date_admission VARCHAR(255)
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
END

--Delete record based on child id
CREATE DEFINER=`admin`@`%` PROCEDURE `spDeleteAdmissionForm`(
    IN p_childId INT
)
BEGIN
    UPDATE admission_form
    SET is_active = FALSE
    WHERE child_id = p_childId;
END


                                                            --Authorization Form CRUD--

--Create record
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

--Retrieve record based on child id
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAuthorizationForm`(
    IN p_childId INT
)
BEGIN
    SELECT * FROM authorization_form
    WHERE child_id = p_childId AND is_active = TRUE;
END

--Retrieve all records
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAllAdmissionForms`()
BEGIN
    SELECT * 
    FROM admission_form 
    WHERE is_active = TRUE;
END

--Update record based on child id
CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateAuthorizationForm`(
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
        admin_sign_date_ach = COALESCE(p_admin_sign_date_ach, admin_sign_date_ach)
        
    WHERE 
        child_id = p_childId AND is_active = TRUE;
END

--Delete record based on child id
CREATE DEFINER=`admin`@`%` PROCEDURE `spDeleteAuthorizationForm`(
    IN p_childId INT
)
BEGIN
    UPDATE authorization_form
    SET is_active = FALSE
    WHERE child_id = p_childId;
END


                                                            --Enrollment Form CRUD--

--Create record
CREATE DEFINER=`admin`@`%` PROCEDURE `spCreateEnrollmentForm`(
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
    IN p_admin_sign_date_ach_enroll VARCHAR(255)
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
END

--Retrieve record based on child form
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetEnrollmentForm`(
    IN p_child_id INT
)
BEGIN
    SELECT * FROM enrollment_form
    WHERE child_id = p_child_id AND is_active = TRUE;
END

--Retrieve all records
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAllEnrollmentForms`()
BEGIN
    SELECT * FROM enrollment_form
    WHERE is_active = TRUE;
END

--Update record based on child form
CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateEnrollmentForm`(
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
    IN p_admin_sign_date_enroll VARCHAR(255)
)
BEGIN
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
        admin_sign_date_enroll = COALESCE(p_admin_sign_date_enroll, admin_sign_date_enroll)
    WHERE 
        child_id = p_childId AND is_active = TRUE;
END

--Delete record based on child form
CREATE DEFINER=`admin`@`%` PROCEDURE `spDeleteEnrollmentForm`(
    IN p_childId INT
)
BEGIN
    UPDATE enrollment_form
    SET is_active = FALSE
    WHERE child_id = p_childId;
END


                                                        --Parent Handbook CRUD--(missing)

--Create record

	
--Retrieve record based on child id
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetParentHandbook`(
    IN p_childId INT
)
BEGIN
    SELECT * FROM parent_handbook
    WHERE child_id = p_childId AND is_active = TRUE;
END

--Retrieve all records
CREATE DEFINER=`admin`@`%` PROCEDURE `spGetAllParentHandbooks`()
BEGIN
    SELECT * FROM parent_handbook
    WHERE is_active = TRUE;
END

--Update record based on child id
CREATE DEFINER=`admin`@`%` PROCEDURE `spUpdateParentHandbook`(
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
    IN p_admin_sign_date_handbook VARCHAR(255)
)
BEGIN
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
        admin_sign_date_handbook = COALESCE(p_admin_sign_date_handbook, admin_sign_date_handbook)
        
    WHERE 
        child_id = p_child_id AND is_active = TRUE;
END

--Delete record based on child id
CREATE DEFINER=`admin`@`%` PROCEDURE `spDeleteParentHandbook`(
    IN p_child_id INT
)
BEGIN
    UPDATE parent_handbook
    SET is_active = FALSE
    WHERE child_id = p_child_id;
END

-- CRUD--
--Create record
--Retrieve record based on 
--Retrieve all records
--Update record based on 
--Delete record based on 

