class ChildInfo(BaseModel):
    parent_id: Optional[int] = None
    additional_parent_id: Optional[int] = None
    classId: Optional[int] = None
    care_provider_id: Optional[int] = None
    dentist_id: Optional[int] = None
    child_first_name: Optional[str] = None
    child_last_name: Optional[str] = None
    nick_name: Optional[str] = None
    dob: Optional[date] = None
    primary_language: Optional[str] = None
    school_age_child_school: Optional[str] = None
    custody_papers_apply: Optional[bool] = None
    gender: Optional[str] = None
    special_diabilities: Optional[bool] = None
    allergies_reaction: Optional[bool] = None
    additional_info: Optional[str] = None
    medication: Optional[str] = None
    health_insurance: Optional[str] = None
    policy_number: Optional[str] = None
    emergency_medical_care: Optional[str] = None
    first_aid_procedures: Optional[str] = None
    physical_exam_last_date: Optional[date] = None
    dental_exam_last_date: Optional[date] = None
    allergies: Optional[bool] = None
    asthma: Optional[bool] = None
    bleeding_problems: Optional[bool] = None
    diabetes: Optional[bool] = None
    epilepsy: Optional[bool] = None
    frequent_ear_infections: Optional[bool] = None
    frequent_illnesses: Optional[bool] = None
    hearing_problems: Optional[bool] = None
    high_fevers: Optional[bool] = None
    hospitalization: Optional[bool] = None
    rheumatic_fever: Optional[bool] = None
    seizures_convulsions: Optional[bool] = None
    serious_injuries_accidents: Optional[bool] = None
    surgeries: Optional[bool] = None
    vision_problems: Optional[bool] = None
    medical_other: Optional[str] = None
    illness_in_pregnancy: Optional[bool] = None
    condition_of_newborn: Optional[bool] = None
    duration_of_pregnancy: Optional[str] = None
    birth_weight_lbs: Optional[int] = None
    birth_weight_oz: Optional[int] = None
    complications: Optional[bool] = None
    bottle_fed: Optional[bool] = None
    breast_fed: Optional[bool] = None
    fam_hist_allergies: Optional[bool] = None
    fam_hist_heart_problems: Optional[bool] = None
    fam_hist_tuberculosis: Optional[bool] = None
    fam_hist_asthma: Optional[bool] = None
    fam_hist_high_blood_pressure: Optional[bool] = None
    fam_hist_vision_problems: Optional[bool] = None
    fam_hist_diabetes: Optional[bool] = None
    fam_hist_hyperactivity: Optional[bool] = None
    fam_hist_epilepsy: Optional[bool] = None
    fam_hist_no_illness: Optional[bool] = None
    other_siblings_name: Optional[str] = None
    other_siblings_age: Optional[str] = None
    age_group_friends: Optional[str] = None
    neighborhood_friends: Optional[str] = None
    relationship_with_mom: Optional[str] = None
    relationship_with_dad: Optional[str] = None
    relationship_with_sib: Optional[str] = None
    relationship_extended_family: Optional[str] = None
    fears_conflicts: Optional[str] = None
    c_response_frustration: Optional[str] = None
    favorite_activities: Optional[str] = None
    last_five_years_moved: Optional[bool] = None
    things_used_home: Optional[str] = None
    hours_of_television_daily: Optional[str] = None
    language_at_home: Optional[str] = None
    changes_home_situation: Optional[bool] = None
    educational_expectations_of_child: Optional[str] = None
    important_fam_members: Optional[str] = None
    fam_celebrations: Optional[str] = None
    childcare_before: Optional[str] = None
    reason_for_childcare_before: Optional[str] = None
    what_child_interests: Optional[str] = None
    drop_off_time: Optional[time] = None
    pick_up_time: Optional[time] = None
    restricted_diet: Optional[bool] = None
    restricted_diet_reason: Optional[str] = None
    eat_own: Optional[bool] = None
    eat_own_reason: Optional[str] = None
    favorite_foods: Optional[str] = None
    rest_middle_day: Optional[bool] = None
    reason_rest_middle_day: Optional[str] = None
    rest_routine: Optional[str] = None
    toilet_trained: Optional[bool] = None
    reason_for_toilet_trained: Optional[str] = None
    existing_illness_allergy: Optional[bool] = None
    explain_illness_allergy: Optional[str] = None
    functioning_at_age: Optional[str] = None
    explain_functioning_at_age: Optional[str] = None
    able_to_walk: Optional[bool] = None
    explain_able_to_walk: Optional[str] = None
    communicate_their_needs: Optional[bool] = None
    explain_communicate_their_needs: Optional[str] = None
    any_medication: Optional[bool] = None
    explain_for_any_medication: Optional[str] = None
    special_equipment: Optional[bool] = None
    explain_special_equipment: Optional[str] = None
    significant_periods: Optional[str] = None
    explain_significant_periods: Optional[str] = None
    accommodations: Optional[bool] = None
    explain_for_accommodations: Optional[str] = None
    additional_information: Optional[str] = None
    child_info_is_correct: Optional[bool] = None
    above_nfo_is_correct: Optional[bool] = None
    immunization_instructions: Optional[str] = None
    profile_info: Optional[str] = None
    child_pick_up_password: Optional[str] = None
    pick_up_password_form: Optional[str] = None
    photo_video_permission_form: Optional[bool] = None
    photo_permission__electronic: Optional[bool] = None
    security_release_policy_form: Optional[bool] = None
    med_technicians_med_transportation_waiver: Optional[bool] = None
    medical_transportation_waiver: Optional[bool] = None
    health_policies: Optional[bool] = None
    parent_sign_outside_waiver: Optional[bool] = None
    approve_social_media_post: Optional[bool] = None
    printed_social_media_post: Optional[bool] = None
    social_media_post: Optional[str] = None
    bank_routing: Optional[str] = None
    bank_account: Optional[str] = None
    driver_license: Optional[str] = None
    state: Optional[str] = None
    myself: Optional[str] = None
    enrollment_name: Optional[str] = None
    point_one_field: Optional[str] = None
    point_two_init: Optional[str] = None
    point_three_ini: Optional[str] = None
    point_four_init: Optional[str] = None
    point_five_init: Optional[str] = None
    point_six_init: Optional[str] = None
    point_seven_init: Optional[str] = None
    point_eight_init: Optional[str] = None
    point_nine_init: Optional[str] = None
    point_ten_init: Optional[str] = None
    point_eleven_init: Optional[str] = None
    point_twelve_init: Optional[str] = None
    point_thirteen_init: Optional[str] = None
    point_fourteen_init: Optional[str] = None
    point_fifteen_initi: Optional[str] = None
    point_sixteen_init: Optional[str] = None
    point_seventeen_init: Optional[str] = None
    point_eighteen_init: Optional[str] = None
    start_date: Optional[date] = None
    schedule_date: Optional[date] = None
    full_day: Optional[bool] = None
    half_day: Optional[bool] = None
    Welcome_Goddard_Agmt: Optional[bool] = None
    Mission_Statement_Agmt: Optional[bool] = None
    General_Information_Agmt: Optional[bool] = None
    Statement_Confidentiality_Agmt: Optional[bool] = None
    Parent_Access_Agmt: Optional[bool] = None
    Release_Children_Agmt: Optional[bool] = None
    Registration_Fees_Agmt: Optional[bool] = None
    Outside_Engagements_Agmt: Optional[bool] = None
    Health_Policies_Agmt: Optional[bool] = None
    Medication_Procedures_Agmt: Optional[bool] = None
    Bring_school_Agmt: Optional[bool] = None
    Rest_Time_Agmt: Optional[bool] = None
    Training_Philosophy_Agmt: Optional[bool] = None
    Affiliation_Policy_Agmt: Optional[bool] = None
    Security_Issue_Agmt: Optional[bool] = None
    Expulsion_Policy_Agmt: Optional[bool] = None
    Addressing_Individual_Child_Agmt: Optional[bool] = None
    Finalword_Agmt: Optional[bool] = None
    
    
class ChildDetailsUpdate(BaseModel):
    child_first_name: Optional[str] = None
    child_last_name: Optional[str] = None
    nick_name: Optional[str] = None
    dob: Optional[date] = None
    primary_language: Optional[str] = None
    school_age_child_school: Optional[str] = None
    custody_papers_apply: Optional[bool] = None
    gender: Optional[str] = None

class EnrollmentAgreementUpdate(BaseModel):
    enrollment_name: Optional[str] = None
    point_one_field: Optional[str] = None
    point_two_init: Optional[str] = None
    point_three_ini: Optional[str] = None
    point_four_init: Optional[str] = None
    point_five_init: Optional[str] = None
    point_six_init: Optional[str] = None
    point_seven_init: Optional[str] = None
    point_eight_init: Optional[str] = None
    point_nine_init: Optional[str] = None
    point_ten_init: Optional[str] = None
    point_eleven_init: Optional[str] = None
    point_twelve_init: Optional[str] = None
    point_thirteen_init: Optional[str] = None
    point_fourteen_init: Optional[str] = None
    point_fifteen_initi: Optional[str] = None
    point_sixteen_init: Optional[str] = None
    point_seventeen_init: Optional[str] = None
    point_eighteen_init: Optional[str] = None
    
    
@app.post("/child_info/create") # type: ignore
def create_child_info(child_info: ChildInfo):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateChildInfo(%s, %s, %s, %s, %s, %s, %s, %s)"
            cursor.execute(sql, (
                child_info.child_first_name,
                child_info.child_last_name,
                child_info.nick_name,
                child_info.dob,
                child_info.primary_language,
                child_info.school_age_child_school,
                child_info.custody_papers_apply,
                child_info.gender,
            ))
            connection.commit()
            return {"message": "Child information created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
        
        
@app.get("/child_info/get/{child_id}") # type: ignore
def get_child_info(child_id: int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetChildInfo(%s)"
            cursor.execute(sql, (child_id,))
            myresult = cursor.fetchone()
            if not myresult:
                raise HTTPException(status_code=404, detail="Child info not found")
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

@app.get("/child_info/getall") # type: ignore
def get_all_child_info():
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllChildInfo()"
            cursor.execute(sql)
            myresult = cursor.fetchall()
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
        
           
@app.put("/child_info/update/{child_id}") # type: ignore
def update_child_info(child_id: int, section: str, data: Union[ChildDetailsUpdate, EnrollmentAgreementUpdate]):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    update_fields = data.dict(exclude_unset=True)
    if not update_fields:
        raise HTTPException(status_code=400, detail="No data provided for update")

    if section == "child_details":
        table_name = "child_info"  # replace with your actual table name
    elif section == "enrollment_agreement":
        table_name = "child_info"  # replace with your actual table name
    else:
        raise HTTPException(status_code=400, detail="Invalid section")

    set_clause = ", ".join([f"{field} = %s" for field in update_fields])
    values = list(update_fields.values())

    try:
        with connection.cursor() as cursor:
            sql = f"UPDATE {table_name} SET {set_clause} WHERE child_id = %s"
            cursor.execute(sql, (*values, child_id))
            connection.commit()
            return {"message": "Child information updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error executing query: {err}")
        return {"error": str(err)}
    finally:
        connection.close()



@app.delete("/child_info/delete/{child_id}") # type: ignore
def delete_child_info(child_id: int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteChildInfo(%s)"
            cursor.execute(sql, (child_id,))
            connection.commit()
            return {"message": "Child information deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()