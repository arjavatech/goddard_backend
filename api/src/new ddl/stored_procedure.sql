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

--Retrieve record based on email-id
--Retrieve all records
--Update record based on email-id
--Delete record based on email-id


--Parent Invite CRUD--
--Create record
--Retrieve record based on email-id
--Retrieve all records
--Update record based on email-id
--Delete record based on email-id