from fastapi import FastAPI, HTTPException, Body
from pydantic import BaseModel
import pymysql
from typing import List, Optional

# Initialize FastAPI
app = FastAPI()

# Database connection function
def connect_to_database():
    try:
        connection = pymysql.connect(
            host="localhost",
            port=3306,
            user="root",
            password="mysqlroot",
            database="sample",
            cursorclass=pymysql.cursors.DictCursor
        )
        return connection
    except pymysql.MySQLError as err:
        print(f"Error connecting to database: {err}")
        return None

# AdmissionForm Schema
class AdmissionFormCreate(BaseModel):
    child_first_name: str
    child_last_name: str
    nick_name: Optional[str] = None
    dob: Optional[str] = None  # You might want to use a date format like 'YYYY-MM-DD'
    primary_language: Optional[str] = None
    school_age_child_school: Optional[str] = None
    custody_papers_apply: Optional[bool] = None
    gender: Optional[str] = None



class AdmissionFormUpdate(BaseModel):
    child_id: Optional[int] = None
    parent_id: Optional[int] = None
    additional_parent_id: Optional[int] = None
    classId: Optional[int] = None
    care_provider_id: Optional[int] = None
    dentist_id: Optional[int] = None
    child_first_name: Optional[str] = None
    child_last_name: Optional[str] = None
    nick_name: Optional[str] = None
    dob: Optional[str] = None
    primary_language: Optional[str] = None
    school_age_child_school: Optional[str] = None
    custody_papers_apply: Optional[bool] = None
    gender: Optional[str] = None
    special_diabilities: Optional[str] = None
    allergies_reaction: Optional[str] = None
    additional_info: Optional[str] = None
    medication: Optional[str] = None
    health_insurance: Optional[str] = None
    policy_number: Optional[str] = None
    emergency_medical_care: Optional[str] = None
    first_aid_procedures: Optional[str] = None
    above_info_is_correct: Optional[bool] = None
    physical_exam_last_date: Optional[str] = None
    dental_exam_last_date: Optional[str] = None
    allergies: Optional[str] = None
    asthma: Optional[str] = None
    bleeding_problems: Optional[str] = None
    diabetes: Optional[str] = None
    epilepsy: Optional[str] = None
    frequent_ear_infections: Optional[str] = None
    frequent_illnesses: Optional[str] = None
    hearing_problems: Optional[str] = None
    high_fevers: Optional[str] = None
    hospitalization: Optional[str] = None
    rheumatic_fever: Optional[str] = None
    seizures_convulsions: Optional[str] = None
    serious_injuries_accidents: Optional[str] = None
    surgeries: Optional[str] = None
    vision_problems: Optional[str] = None
    medical_other: Optional[str] = None
    illness_in_pregnancy: Optional[str] = None
    condition_of_newborn: Optional[str] = None
    duration_of_pregnancy: Optional[str] = None
    birth_weight_lbs: Optional[str] = None
    birth_weight_oz: Optional[str] = None
    complications: Optional[str] = None
    bottle_fed: Optional[str] = None
    breast_fed: Optional[str] = None
    other_siblings_name: Optional[str] = None
    other_siblings_age: Optional[str] = None
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
    age_group_friends: Optional[str] = None
    neighborhood_friends: Optional[str] = None
    relationship_with_mom: Optional[str] = None
    relationship_with_dad: Optional[str] = None
    relationship_with_sib: Optional[str] = None
    relationship_extended_family: Optional[str] = None
    fears_conflicts: Optional[str] = None
    c_response_frustration: Optional[str] = None
    favorite_activities: Optional[str] = None
    last_five_years_moved: Optional[str] = None
    things_used_home: Optional[str] = None
    hours_of_television_daily: Optional[str] = None
    language_at_home: Optional[str] = None
    changes_home_situation: Optional[bool] = None
    educational_expectations_of_child: Optional[str] = None
    fam_his_instructions: Optional[bool] = None
    immunization_instructions: Optional[bool] = None
    important_fam_members: Optional[str] = None
    fam_celebrations: Optional[str] = None
    childcare_before: Optional[bool] = None
    reason_for_childcare_before: Optional[str] = None
    what_child_interests: Optional[str] = None
    drop_off_time: Optional[str] = None
    pick_up_time: Optional[str] = None
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
    functioning_at_age: Optional[bool] = None
    explain_functioning_at_age: Optional[str] = None
    able_to_walk: Optional[bool] = None
    explain_able_to_walk: Optional[str] = None
    communicate_their_needs: Optional[bool] = None
    explain_communicate_their_needs: Optional[str] = None
    any_medication: Optional[bool] = None
    explain_for_any_medication: Optional[str] = None
    special_equipment: Optional[bool] = None
    explain_special_equipment: Optional[str] = None
    significant_periods: Optional[bool] = None
    explain_significant_periods: Optional[str] = None
    accommodations: Optional[bool] = None
    explain_for_accommodations: Optional[str] = None
    additional_information: Optional[str] = None
    child_info_is_correct: Optional[bool] = None
    child_pick_up_password: Optional[str] = None
    pick_up_password_form: Optional[bool] = None
    photo_video_permission_form: Optional[str] = None
    photo_permission_electronic: Optional[bool] = None
    photo_permission_post: Optional[bool] = None
    security_release_policy_form: Optional[bool] = None
    med_technicians_med_transportation_waiver: Optional[str] = None
    medical_transportation_waiver: Optional[bool] = None
    health_policies: Optional[bool] = None
    parent_sign_outside_waiver: Optional[bool] = None
    approve_social_media_post: Optional[bool] = None
    printed_social_media_post: Optional[str] = None
    social_media_post: Optional[bool] = None
    parent_sign: Optional[str] = None
    admin_sign: Optional[str] = None
   

# --------- AdmissionForm Endpoints ---------

@app.post("/admission_form/create")  
async def create_admission_form(admission_form: AdmissionFormCreate = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateAdmissionForm(%s, %s, %s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (
                admission_form.child_first_name,
                admission_form.child_last_name,
                admission_form.nick_name,
                admission_form.dob,
                admission_form.primary_language,
                admission_form.school_age_child_school,
                admission_form.custody_papers_apply,
                admission_form.gender,
            ))
            connection.commit()

            return {"message": "Admission form created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/admission_form/get/{id}")  
async def get_admission_form(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAdmissionForm(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Admission form with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching admission form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/admission_form/getall")  
async def get_all_admission_forms():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllAdmissionForms();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching admission forms: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/admission_form/update/{child_id}")
async def update_admission_form(child_id: int, form: AdmissionFormUpdate = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            # Define the SQL query with positional placeholders
            sql = """
                CALL spUpdateAdmissionForm(
                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,
                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,
                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                );
            """
            
            # Prepare the parameters for the stored procedure
            params = (
                form.child_id, form.parent_id, form.additional_parent_id, form.classId, form.care_provider_id, 
                form.dentist_id, form.child_first_name, form.child_last_name, form.nick_name, form.dob,
                form.primary_language, form.school_age_child_school, form.custody_papers_apply, form.gender,
                form.special_diabilities, form.allergies_reaction, form.additional_info, form.medication,
                form.health_insurance, form.policy_number, form.emergency_medical_care, form.first_aid_procedures,
                form.above_info_is_correct, form.physical_exam_last_date, form.dental_exam_last_date,
                form.allergies, form.asthma, form.bleeding_problems, form.diabetes, form.epilepsy,
                form.frequent_ear_infections, form.frequent_illnesses, form.hearing_problems, form.high_fevers,
                form.hospitalization, form.rheumatic_fever, form.seizures_convulsions, form.serious_injuries_accidents,
                form.surgeries, form.vision_problems, form.medical_other, form.illness_in_pregnancy,
                form.condition_of_newborn, form.duration_of_pregnancy, form.birth_weight_lbs, form.birth_weight_oz,
                form.complications, form.bottle_fed, form.breast_fed, form.other_siblings_name, form.other_siblings_age,
                form.fam_hist_allergies, form.fam_hist_heart_problems, form.fam_hist_tuberculosis,
                form.fam_hist_asthma, form.fam_hist_high_blood_pressure, form.fam_hist_vision_problems,
                form.fam_hist_diabetes, form.fam_hist_hyperactivity, form.fam_hist_epilepsy, form.fam_hist_no_illness,
                form.age_group_friends, form.neighborhood_friends, form.relationship_with_mom, form.relationship_with_dad,
                form.relationship_with_sib, form.relationship_extended_family, form.fears_conflicts,
                form.c_response_frustration, form.favorite_activities, form.last_five_years_moved,
                form.things_used_home, form.hours_of_television_daily, form.language_at_home, form.changes_home_situation,
                form.educational_expectations_of_child, form.fam_his_instructions, form.immunization_instructions,
                form.important_fam_members, form.fam_celebrations, form.childcare_before, form.reason_for_childcare_before,
                form.what_child_interests, form.drop_off_time, form.pick_up_time, form.restricted_diet,
                form.restricted_diet_reason, form.eat_own, form.eat_own_reason, form.favorite_foods, form.rest_middle_day,
                form.reason_rest_middle_day, form.rest_routine, form.toilet_trained, form.reason_for_toilet_trained,
                form.existing_illness_allergy, form.explain_illness_allergy, form.functioning_at_age,
                form.explain_functioning_at_age, form.able_to_walk, form.explain_able_to_walk,
                form.communicate_their_needs, form.explain_communicate_their_needs, form.any_medication,
                form.explain_for_any_medication, form.special_equipment, form.explain_special_equipment,
                form.significant_periods, form.explain_significant_periods, form.accommodations,
                form.explain_for_accommodations, form.additional_information, form.child_info_is_correct,
                form.child_pick_up_password, form.pick_up_password_form, form.photo_video_permission_form,
                form.photo_permission_electronic, form.photo_permission_post, form.security_release_policy_form,
                form.med_technicians_med_transportation_waiver, form.medical_transportation_waiver, form.health_policies,
                form.parent_sign_outside_waiver, form.approve_social_media_post, form.printed_social_media_post,
                form.social_media_post, form.parent_sign, form.admin_sign
            )
            
            cursor.execute(sql, params)
            connection.commit()

            return {"message": f"Admission form with child_id {child_id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating admission form: {err}")
        raise HTTPException(status_code=500, detail=f"Database error: {err}")
    finally:
        if connection:
            connection.close()

@app.put("/admission_form/delete/{id}")  
async def delete_admission_form(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteAdmissionForm(%s);"
            cursor.execute(sql, (id,))
            connection.commit()

            return {"message": f"Admission form with id {id} deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error deleting admission form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()
