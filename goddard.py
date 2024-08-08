from datetime import date, time
import json
from fastapi import APIRouter, Body, FastAPI, HTTPException, Path
from fastapi.responses import JSONResponse
from pydantic import BaseModel
from typing import Optional, Union
import pymysql

app = FastAPI()

def connect_to_database():
    try:
        connection = pymysql.connect(
            host="localhost",
            port=3306,
            user="root",
            password="Sandy@2025",
            database="goddardTest",
            cursorclass=pymysql.cursors.DictCursor
        )
        return connection
    except pymysql.MySQLError as err:
        print(f"Error connecting to database: {err}")
        return None
    
# ---------------------------CAREPROVIDER----------------------------------

class CareProvider(BaseModel):
    name: str
    telephone_number: str
    hospital_affiliation: str = None
    street_address: str = None
    city_address: str = None
    state_address: str = None
    zip_address: str = None
    
class EmergencyContact(BaseModel):
    emergency_id: int
    child_id:int

    
connect_to_database()
@app.get("/test")
def get_test():
    return {"response": "Test get call successfully called"}

@app.get("/care_provider/getall")
def get_all_care_providers():
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "call goddardtest.⁠ spGetAllCareProvider ⁠();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# _______________________________________________________________________________________________

@app.get("/care_provider/get/{id}")
def get_care_providers(id:str):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "call goddardtest.⁠ spGetCareProvider ⁠(%s);"
            cursor.execute(sql,(id,))
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# _______________________________________________________________________________________________

@app.post("/care_provider/create")
def create_care_provider(body: dict = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            id = body.get("id")
            name = body.get("name")
            telephone_number = body.get("telephone_number")
            hospital_affiliation = body.get("hospital_affiliation")
            street_address = body.get("street_address")
            city_address = body.get("city_address")
            state_address = body.get("state_address")
            zip_address = body.get("zip_address")
            
            sql = "call goddardtest.⁠spCreateCareProvider⁠(%s, %s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (name, telephone_number, hospital_affiliation, street_address, city_address, state_address, zip_address))
            connection.commit()
            return {"message": "Care provider created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
#   ___________________________________________________________________________________________________      

@app.put("/care_provider/update/{id}")
def update_care_provider(id: int,body: dict = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            id = body.get("id")
            name = body.get("name")
            telephone_number = body.get("telephone_number")
            hospital_affiliation = body.get("hospital_affiliation")
            street_address = body.get("street_address")
            city_address = body.get("city_address")
            state_address = body.get("state_address")
            zip_address = body.get("zip_address")
            
            sql = "CALL spUpdateCareProvider(%s, %s, %s, %s, %s, %s, %s, %s)"
            cursor.execute(sql, (id, name, telephone_number, hospital_affiliation, street_address, city_address, state_address, zip_address))

            connection.commit()
            return {"message": "Care provider updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# ________________________________________________________________________________________________

@app.delete("/care_provider/delete/{id}")
def delete_care_provider(id:int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "call goddardtest.⁠ spDeleteCareProvider ⁠(%s);"
            cursor.execute(sql,(id,))
            connection.commit()

            return {"message": "Care provider deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# --------------------------------------- CHILD_INFO---------------------------


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
    
# ________________________________________________________________________________________________

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
        
 # ________________________________________________________________________________________________

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
# ________________________________________________________________________________________________

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

# ________________________________________________________________________________________________

@app.put("/child_info/update/{child_id}") # type: ignore
def update_child_info(child_id: int, child_info: ChildInfo):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql_parts = []
            params = []

            
            for field, value in child_info.dict(exclude_unset=True).items():
                sql_parts.append(f"{field} = %s")
                params.append(value)

            if not sql_parts:
                raise HTTPException(status_code=400, detail="No fields provided for update")

            sql = f"UPDATE child_info SET {', '.join(sql_parts)} WHERE child_id = %s"
            params.append(child_id)

            cursor.execute(sql, params)
            connection.commit()
            return {"message": "Child information updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating child info: {err}")
        raise HTTPException(status_code=500, detail="Failed to update child information")
    finally:
        connection.close()

# ________________________________________________________________________________________________        
           
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

# ________________________________________________________________________________________________

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

# -----------------------------------DENTIST---------------------------------


class ParentInviteInfo(BaseModel):
    parent_email: str
    invite_id: str
    admin: bool
    parent_name: str
    child_full_name: str
    invite_status: str
    password: str
    temp_password: str

@app.get("/test")
def get_test():
    return {"response": "Test get call successfully called"}

@app.get("/dentist/getAll")
def get_all_dentists():
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "call goddardmodel.spGetAllDentist();"
            cursor.execute(sql)
            myresult = cursor.fetchall()
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error fetching data: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
# ________________________________________________________________________________________________

@app.get("/dentist/get/{id}")
def get_dentists(id):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "call goddardmodel.spGetDentist(%s);"
            cursor.execute(sql,(id,))
            myresult = cursor.fetchall()
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error fetching data: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# ________________________________________________________________________________________________

@app.post("/dentist/create")
def create_dentist(Body:dict = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}
    try:
        with connection.cursor() as cursor:
            name = Body.get("name")
            telephone_number = Body.get("telephone_number")
            street_address =Body.get("street_address")
            city_address = Body.get("city_address")
            state_address = Body.get("state_address")
            zip_address = Body.get("zip_address")
            sql = "call goddardmodel.spCreateDentist(%s,%s,%s,%s,%s,%s);"
            
            cursor.execute(sql,(name,telephone_number,street_address,city_address,state_address,zip_address,))
            connection.commit()
            return {"message": "Dentist created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# ________________________________________________________________________________________________

@app.put("/dentist/update/{id}")
def create_dentist(id:str, Body = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            name = Body.get("name")
            telephone_number = Body.get("telephone_number")
            street_address =Body.get("street_address")
            city_address = Body.get("city_address")
            state_address = Body.get("state_address")
            zip_address = Body.get("zip_address")
            sql = "CALL spUpdateDentist(%s,%s,%s,%s,%s,%s,%s)"
            
            cursor.execute(sql,(id,name,telephone_number,street_address,city_address,state_address,zip_address))
            connection.commit()
            return {"message": "Dentist updated successfully", "Dentist-ID": id}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# ________________________________________________________________________________________________

@app.delete("/dentist/delete/{id}")
def delete_dentist(id : str):
        connection = connect_to_database()
        if not connection:
            return {"error": "Failed to connect to database"}

        try:
            with connection.cursor() as cursor:
                sql = "call spDeleteDentist(%s);"
                cursor.execute(sql, id)
                connection.commit()
                return {"message": "Dentist deleted successfully" , "Dentist-ID": id}
        except pymysql.MySQLError as err:
            print(f"Error calling stored procedure: {err}")
            return {"error": str(err)}
        finally:
            connection.close()


# ----------------------------------EMERGENCY_CONTACT-----------------------------------

@app.get("/emergency_contact/get/{id}")
def get_emergency_contact(p_emergency_id: int, p_child_id: int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetEmergencyContact(%s, %s)"
            cursor.execute(sql, (p_emergency_id, p_child_id))
            myresult = cursor.fetchone()
            if not myresult:
                raise HTTPException(status_code=404, detail="Emergency contact not found")
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
        
# ________________________________________________________________________________________________

@app.get("/emergency_contact/getall")
def get_all_emergency_contacts():
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllEmergencyContact()"
            cursor.execute(sql)
            myresult = cursor.fetchall()
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# ________________________________________________________________________________________________

@app.post("/emergency_contact/create")
def create_emergency_contact(emergency_contact: EmergencyContact):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateEmergencyContact(%s, %s)"
            cursor.execute(sql, (emergency_contact.emergency_id, emergency_contact.child_id))
            connection.commit()
            return {"message": "Emergency contact created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
# ________________________________________________________________________________________________

@app.put("/emergency_contact/update")
def update_emergency_contact(p_old_emergency_id: int, p_child_id: int, p_new_emergency_id: int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateEmergencyContact(%s, %s, %s)"
            cursor.execute(sql, (p_old_emergency_id, p_child_id, p_new_emergency_id))
            connection.commit()
            return {"message": "Emergency contact updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# ________________________________________________________________________________________________

@app.delete("/emergency_contact/delete")
def delete_emergency_contact(p_emergency_id: int, p_child_id: int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteEmergencyContact(%s, %s)"
            cursor.execute(sql, (p_emergency_id, p_child_id))
            connection.commit()
            return {"message": "Emergency contact deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()


# -------------------------------EMERGENCY_INFO----------------------------
class Emergency_info(BaseModel):
    
    contact_name: str 
    contact_relationship: str 
    street_address: str 
    city_address: str 
    state_address: str 
    zip_address: str 
    contact_telephone_number: str 

@app.post("/EmergencyInfo/add")

async def add_emergencyinfo(emergency_info : Emergency_info = Body()):
    connection =  connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}
    
    try:
        
        with connection.cursor() as cursor: 
          
            sql = "CALL InsertEmergencyContact( %s,%s,%s,%s,%s,%s,%s)"
            cursor.execute(sql, (emergency_info.contact_name,emergency_info.contact_relationship,emergency_info.street_address,emergency_info.city_address,emergency_info.state_address,emergency_info.zip_address,emergency_info.contact_telephone_number,))
            connection.commit()

            return {"message": "Emergency contact  saved successfully"}  

        
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

# ________________________________________________________________________________________________
    
# PUT call
@app.put("/EmergencyInfo/update/{id}")
def update_classname( id:int, emergency_info : Emergency_info   = Body(...)):
    connection =  connect_to_database()
    if not connection:
            raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
            with connection.cursor() as cursor:
                sql = "CALL  UpdateEmergencyContact(%s,%s,%s,%s,%s,%s,%s,%s)"
                cursor.execute(sql, (id, emergency_info.contact_name,emergency_info.contact_relationship,emergency_info.street_address,emergency_info.city_address,emergency_info.state_address,emergency_info.zip_address,emergency_info.contact_telephone_number,))
                connection.commit()

                return {"message": f"Emergency contact info  updated successfully"}

    except pymysql.MySQLError as err:
            raise HTTPException(status_code=500, detail=f"MySQL Error: {err}")
    except Exception as e:
            raise HTTPException(status_code=500, detail=f"Unexpected Error: {str(e)}")
    finally:
            connection.close()

# ________________________________________________________________________________________________
            
@app.delete("/EmergencyInfo/delete/{id}")
def delete_classname( id:int):
    connection =  connect_to_database()
    if not connection:
            raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
            with connection.cursor() as cursor:
                sql = "CALL DeleteEmergencyContact(%s)"
                cursor.execute(sql, (id, ))
                connection.commit()

                return {"message": f"Emergency contact info   deleted  successfully"}

    except pymysql.MySQLError as err:
            raise HTTPException(status_code=500, detail=f"MySQL Error: {err}")
    except Exception as e:
            raise HTTPException(status_code=500, detail=f"Unexpected Error: {str(e)}")
    finally:
            connection.close()

# ________________________________________________________________________________________________


#getall call        
@app.get("/Emergencyinfo/getall", response_class=JSONResponse)
def read_myinfo():
    connection =  connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")
    
    try:
        with connection.cursor(pymysql.cursors.DictCursor) as cursor:
            cursor.execute("SELECT * FROM EmergencyContacts")
            result = cursor.fetchall()
            return JSONResponse(content=json.loads(json.dumps(result)))
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        connection.close()

# ________________________________________________________________________________________________
        
 #getbyid
@app.get ("/Emergencyinfo/getbyid/{Id}")      
def read_myinfo_by_id(Id : int):
    try:
        connection =  connect_to_database()
        with connection.cursor() as cursor:
            sql = "SELECT * FROM EmergencyContacts WHERE emergency_id= %s"
            cursor.execute(sql, (Id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"classdetails with id {id} not found")
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        connection.close()


# ---------------------------FORM DETAIL-----------------------------


class FormDetail(BaseModel):
    form_name: str

@app.post("/form_detail/create") # type: ignore
def create_form_detail(form_detail: FormDetail):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateFormDetail(%s)"
            cursor.execute(sql, (form_detail.form_name,))
            connection.commit()
            return {"message": "Form detail created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
        
# ________________________________________________________________________________________________

@app.get("/form_detail/get/{id}")   # type: ignore
def get_form_detail(id):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetFormDetail(%s)"
            cursor.execute(sql, (id,))
            myresult = cursor.fetchone()
            if not myresult:
                raise HTTPException(status_code=404, detail="Form detail not found")
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# ________________________________________________________________________________________________

@app.get("/form_detail/getall")     # type: ignore
def get_all_form_details():
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllFormDetail()"
            cursor.execute(sql)
            myresult = cursor.fetchall()
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
        
  # ________________________________________________________________________________________________      

@app.put("/form_detail/update/{id}")    # type: ignore
def update_form_detail(id: int, form_detail: FormDetail):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateFormDetail(%s, %s)"
            cursor.execute(sql, (id, form_detail.form_name))
            connection.commit()
            return {"message": "Form detail updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# ________________________________________________________________________________________________

@app.delete("/form_detail/delete/{id}") # type: ignore
def delete_form_detail(id: int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteFormDetail(%s)"
            cursor.execute(sql, (id,))
            connection.commit()
            return {"message": "Form detail deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()


# --------------------------------------PARENT INFO------------------------------------------------


class ParentInfo(BaseModel):
    email: str
    name: str = None
    street_address: str = None
    city_address: str = None
    state_address: str = None
    zip_address: str = None
    home_telephone_number: str = None
    home_cellphone_number: str = None
    business_name: str = None
    work_hours_from: str = None
    work_hours_to: str = None
    business_telephone_number: str = None
    business_street_address: str = None
    business_city_address: str = None
    business_state_address: str = None
    business_zip_address: str = None
    business_cell_number: str = None
    
    
# ________________________________________________________________________________________________

# ParentInfo Endpoints
@app.post("/parent_info/create")        # type: ignore
def create_parent_info(parent_info: ParentInfo):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = ("CALL spCreateParentInfo(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)")
            cursor.execute(sql, (parent_info.email, parent_info.name, parent_info.street_address, parent_info.city_address, 
                                 parent_info.state_address, parent_info.zip_address, parent_info.home_telephone_number, 
                                 parent_info.home_cellphone_number, parent_info.business_name, parent_info.work_hours_from, 
                                 parent_info.work_hours_to, parent_info.business_telephone_number, parent_info.business_street_address, 
                                 parent_info.business_city_address, parent_info.business_state_address, parent_info.business_zip_address, 
                                 parent_info.business_cell_number))
            connection.commit()
            return {"message": "Parent info created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
 # ________________________________________________________________________________________________
     
@app.get("/parent_info/get/{id}")       # type: ignore
def get_parent_info(id: int = Path(..., title="The ID of the parent info to retrieve")):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetParentInfo(%s)"
            cursor.execute(sql, (id,))
            myresult = cursor.fetchone()
            if not myresult:
                raise HTTPException(status_code=404, detail="Parent info not found")
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# ________________________________________________________________________________________________

@app.get("/parent_info/getall")     # type: ignore
def get_all_parent_info():
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllParentInfo()"
            cursor.execute(sql)
            myresult = cursor.fetchall()
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
        
# ________________________________________________________________________________________________

@app.put("/parent_info/update/{id}")        # type: ignore
def update_parent_info(id: int, parent_info: ParentInfo):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = ("CALL spUpdateParentInfo(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)")
            cursor.execute(sql, (id, parent_info.email, parent_info.name, parent_info.street_address, parent_info.city_address, 
                                 parent_info.state_address, parent_info.zip_address, parent_info.home_telephone_number, 
                                 parent_info.home_cellphone_number, parent_info.business_name, parent_info.work_hours_from, 
                                 parent_info.work_hours_to, parent_info.business_telephone_number, parent_info.business_street_address, 
                                 parent_info.business_city_address, parent_info.business_state_address, parent_info.business_zip_address, 
                                 parent_info.business_cell_number))
            connection.commit()
            return {"message": "Parent info updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# ________________________________________________________________________________________________

@app.delete("/parent_info/delete/{id}")     # type: ignore
def delete_parent_info(id: int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteParentInfo(%s)"
            cursor.execute(sql, (id,))
            connection.commit()
            return {"message": "Parent info deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# -----------------------------------------ParentInviteInfo-------------------------------

@app.get("/parent_invite_info/getAll")
def get_all_parent_invite_info():
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllParentInviteInfo()"
            cursor.execute(sql)
            myresult = cursor.fetchall()
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error fetching data: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# ________________________________________________________________________________________________

@app.get("/parent_invite_info/get/{parent_email}")
def get_parent_invite_info(parent_email: str):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetParentInviteInfo(%s);"
            cursor.execute(sql, (parent_email,))
            myresult = cursor.fetchall()
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error fetching data: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# ________________________________________________________________________________________________

@app.post("/parent_invite_info/create")
def create_parent_invite_info(parent_invite_info: ParentInviteInfo):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = """
                CALL spCreateParentInviteInfo(
                    %s, %s, %s, %s, %s, %s, %s, %s
                );
            """
            cursor.execute(sql, (
                parent_invite_info.parent_email, parent_invite_info.invite_id,
                parent_invite_info.admin, parent_invite_info.parent_name,
                parent_invite_info.child_full_name, parent_invite_info.invite_status,
                parent_invite_info.password, parent_invite_info.temp_password
            ))
            connection.commit()
            return {"message": "Parent invite info created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# ________________________________________________________________________________________________

@app.put("/parent_invite_info/update/{parent_email}")
def update_parent_invite_info(parent_email: str, parent_invite_info: ParentInviteInfo):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = """
                CALL spUpdateParentInviteInfo(
                    %s, %s, %s, %s, %s, %s, %s, %s
                );
            """
            cursor.execute(sql, (
                parent_invite_info.parent_email, parent_invite_info.invite_id,
                parent_invite_info.admin, parent_invite_info.parent_name,
                parent_invite_info.child_full_name, parent_invite_info.invite_status,
                parent_invite_info.password, parent_invite_info.temp_password
            ))
            connection.commit()
            return {"message": "Parent invite info updated successfully", "parent_email": parent_email}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# ________________________________________________________________________________________________

@app.delete("/parent_invite_info/delete/{parent_email}")
def delete_parent_invite_info(parent_email: str):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteParentInviteInfo(%s);"
            cursor.execute(sql, (parent_email,))
            connection.commit()
            return {"message": "Parent invite info deleted successfully", "parent_email": parent_email}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()


# ------------------------------------------SIGNATURE INFO-------------------------------------------------


class Signatureinfo(BaseModel):
    child_id :int
    form_id :int
    parent_sign : str
    parent_date : date
    admin_sign : str
    admin_date : date
    
 #post call   
@app.post("/signatureinfo/add")
def add_signatureinfo(signatureinfo:Signatureinfo = Body()):
    connection =  connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}
    
    try:
        
        with connection.cursor() as cursor:
          
            sql = "CALL spCreateSignatureInfo( %s,%s,%s,%s,%s,%s)"
            cursor.execute(sql, (signatureinfo.child_id,signatureinfo.form_id,signatureinfo.parent_sign,
                                 signatureinfo.parent_date,signatureinfo.admin_sign,signatureinfo.admin_date))
            connection.commit()

            return {"message": "Signatureinfo Saved Successfully"}  

        
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()
            
# ________________________________________________________________________________________________

# PUT call
@app.put("/signatureinfo/update/{id}")
def update_signatureinfo( id:int, signatureinfo:Signatureinfo  = Body(...)):
    connection =  connect_to_database()
    if not connection:
            raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
            with connection.cursor() as cursor:
                sql = "CALL  spUpdateSignatureInfo(%s,%s,%s,%s,%s,%s)"
                cursor.execute(sql, (id, signatureinfo.form_id,signatureinfo.parent_sign,
                                 signatureinfo.parent_date,signatureinfo.admin_sign,signatureinfo.admin_date))
                connection.commit()

                return {"message": f"Signatureinfo updated successfully"}

    except pymysql.MySQLError as err:
            raise HTTPException(status_code=500, detail=f"MySQL Error: {err}")
    except Exception as e:
            raise HTTPException(status_code=500, detail=f"Unexpected Error: {str(e)}")
    finally:
            connection.close()
            
# ________________________________________________________________________________________________

#delete call
@app.delete("/signature/delete/{id}")
def delete_classname( id:int):
    connection = connect_to_database()
    if not connection:
            raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
            with connection.cursor() as cursor:
                sql = "CALL  spDeleteSignatureInfo(%s)"
                cursor.execute(sql, (id, ))
                connection.commit()

                return {"message": f"Signatureinfo deleted  successfully"}

    except pymysql.MySQLError as err:
            raise HTTPException(status_code=500, detail=f"MySQL Error: {err}")
    except Exception as e:
            raise HTTPException(status_code=500, detail=f"Unexpected Error: {str(e)}")
    finally:
            connection.close()

 # ________________________________________________________________________________________________           
            
# GET call
@app.get("/signatureinfo/getbyid/{id}")
def get_signatureinfo_by_id(id: int):
    connection =  connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spReadSignatureInfo(%s, %s)"
            cursor.execute(sql, (id, 1))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"SignatureInfo with id {id} not found")
    except pymysql.MySQLError as err:
        raise HTTPException(status_code=500, detail=f"MySQL Error: {err}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Unexpected Error: {str(e)}")
    finally:
        connection.close()
        
# ________________________________________________________________________________________________
        
# GET all records
@app.get("/signatureinfo/getall",response_class=JSONResponse)
def get_all_signatureinfo():
    connection =  connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "SELECT * FROM signature_info"
            cursor.execute(sql)
            result = cursor.fetchall()
            return JSONResponse(content=json.loads(json.dumps(result)))
    except pymysql.MySQLError as err:
        raise HTTPException(status_code=500, detail=f"MySQL Error: {err}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Unexpected Error: {str(e)}")
    finally:
        connection.close()

# --------------------------------------------CHILD INFO------------------------------------


class childclassname(BaseModel):
    
    className : str
 
 #post call   
@app.post("/classname/add")

async def add_classname(classnameinfo : childclassname = Body()):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}
    
    try:
        
        with connection.cursor() as cursor:
          
            sql = "CALL InsertClassDetails( %s)"
            cursor.execute(sql, (classnameinfo.className))
            connection.commit()

            return {"message": "classroom saved successfully"}  

        
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()
        
#getall call        
@app.get("/classname/getall", response_class=JSONResponse)
def read_myinfo():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")
    
    try:
        with connection.cursor(pymysql.cursors.DictCursor) as cursor:
            cursor.execute("SELECT * FROM classdetails")
            result = cursor.fetchall()
            return JSONResponse(content=json.loads(json.dumps(result)))
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        connection.close()
 
 #getbyid
@app.get ("/classname/getbyid/{classId}")      
def read_myinfo_by_id(classId : int):
    try:
        connection = connect_to_database()
        with connection.cursor() as cursor:
            sql = "SELECT * FROM classdetails WHERE classId= %s"
            cursor.execute(sql, (classId,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"classdetails with id {classId} not found")
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        connection.close()

# PUT call
@app.put("/classname/update/{id}")
def update_classname( id:int, classnameinfo : childclassname  = Body(...)):
    connection = connect_to_database()
    if not connection:
            raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
            with connection.cursor() as cursor:
                sql = "CALL  UpdateClassDetails(%s, %s)"
                cursor.execute(sql, (id, classnameinfo.className,))
                connection.commit()

                return {"message": f"Classroom with id updated successfully"}

    except pymysql.MySQLError as err:
            raise HTTPException(status_code=500, detail=f"MySQL Error: {err}")
    except Exception as e:
            raise HTTPException(status_code=500, detail=f"Unexpected Error: {str(e)}")
    finally:
            connection.close()
        
#deletecall        
@app.delete("/classname/delete/{id}")
def delete_classname( id:int):
    connection = connect_to_database()
    if not connection:
            raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
            with connection.cursor() as cursor:
                sql = "CALL  DeleteClassDetails(%s)"
                cursor.execute(sql, (id, ))
                connection.commit()

                return {"message": f"Classroom with id deleted  successfully"}

    except pymysql.MySQLError as err:
            raise HTTPException(status_code=500, detail=f"MySQL Error: {err}")
    except Exception as e:
            raise HTTPException(status_code=500, detail=f"Unexpected Error: {str(e)}")
    finally:
            connection.close()


