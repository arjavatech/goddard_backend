from datetime import date, time
from datetime import datetime
import json
from fastapi import APIRouter, Body, FastAPI, HTTPException, Path
from fastapi.responses import JSONResponse
from pydantic import BaseModel
from typing import Optional, Union
import pymysql
import mangum
import yagmail
import shortuuid

from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware, allow_origins=["*"], allow_credentials = True, allow_methods=["*"], allow_headers=["*"]
)


def connect_to_database():
    try:
        connection = pymysql.connect(
            host="goddardtest.c6qlau4lseex.ap-south-1.rds.amazonaws.com",
            port=3306,
            user="admin",
            password="1204Mani",
            database="goddardtest",
            cursorclass=pymysql.cursors.DictCursor
        )
        return connection
    except pymysql.MySQLError as err:
        print(f"Error connecting to database: {err}")
        return None

@app.get("/test")
def get_test():
    return {"response": "Test get call successfully called"}

# AdminInfo Schema

class AdminInfo(BaseModel):
    email: str
    password: Optional[str] = None
    designation: Optional[str] = None
    apporved_by: Optional[str] = None
    is_active: Optional[bool] = None

# --------- Admin Info Endpoints ---------

@app.post("/admin_info/create")
async def create_admin_info(admin_info: AdminInfo = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateAdminInfo(%s, %s, %s, %s);"
            cursor.execute(sql, (admin_info.email, admin_info.password, admin_info.designation, admin_info.apporved_by))
            connection.commit()

            return {"message": "AdminInfo created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail={"message": "AdminInfo creation Failed!!!"})
    finally:
        if connection:
            connection.close()

@app.get("/admin_info/get/{email_id}")
async def get_admin_info(email_id: str):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAdminInfo(%s);"
            cursor.execute(sql, (email_id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Admin Info with email_id {email_id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching signup_info: {err}")
        raise HTTPException(status_code=500, detail={"error": "Admin Info get call failed (DB Error)"})
    finally:
        if connection:
            connection.close()

@app.get("/admin_info/getall")
async def get_all_admin_info():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllAdminInfo();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching signup_info: {err}")
        raise HTTPException(status_code=500, detail={"error": "Admin Info get_all call failed (DB Error)"})
    finally:
        if connection:
            connection.close()

@app.put("/admin_info/update/{email_id}")
async def update_admin_info(email_id: str, admin_info: AdminInfo = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateAdminInfo(%s, %s, %s, %s);"
            cursor.execute(sql, (email_id, admin_info.password, admin_info.designation, admin_info.apporved_by))
            connection.commit()

            return {"message": f"Admin Info with email_id {email_id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating signup_info: {err}")
        raise HTTPException(status_code=500, detail={"error": f"Admin Info with email_id {email_id} update call failed (DB Error)"})
    finally:
        if connection:
            connection.close()

@app.put("/admin_info/delete/{email_id}")
async def delete_admin_info(email_id: str):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteAdminInfo(%s);"
            cursor.execute(sql, (email_id,))
            connection.commit()

            return {"message": f"SignUpInfo with email_id {email_id} deleted successfully (soft delete)"}
    except pymysql.MySQLError as err:
        print(f"Error deleting signup_info: {err}")
        raise HTTPException(status_code=500, detail={"error": f"Admin Info with email_id {email_id} delete call failed (DB Error)"})
    finally:
        if connection:
            connection.close()


# ParentInvite Schema
class ParentInvite(BaseModel):
    invite_email: Optional[str] = None
    parent_id: int
    invite_id: Optional[str] = None
    time_stamp: Optional[str] = None


# --------- ParentInvite Endpoints ---------

@app.post("/parent_invite_info/create")
async def create_parent_invite(invite: ParentInvite = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            # Get the current UTC time
            current_utc_time = datetime.utcnow()
            uuid1 = shortuuid.uuid()
            invite_id = f"https://arjavatech.github.io/goddard-frontend-test/signup.html?invite_id={uuid1}"
            sql = "CALL spCreateParentInvite(%s, %s, %s, %s);"
            cursor.execute(sql, (invite.invite_email, invite_id, invite.parent_id, current_utc_time))
            connection.commit()

            return {"message": "Parent invite successfully created !"}

    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/parent_invite_info/get/{email}")
async def get_parent_invite(email: str):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetParentInvite(%s);"
            cursor.execute(sql, (email,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Parent invite with email {email} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching parent invite: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/parent_invite_info/getall")
async def get_all_parent_invites():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllParentInvites();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching parent invites: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/parent_invite_info/update/{email}")
async def update_parent_invite(email: str, parent_name: str, child_full_name: str,  invite: ParentInvite = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            # Get the current UTC time
            current_utc_time = datetime.utcnow()
            uuid1 = shortuuid.uuid()
            invite_id = f"https://arjavatech.github.io/goddard-frontend-test/signup.html?invite_id={uuid1}"
            sql = "CALL spUpdateParentInvite(%s, %s, %s, %s);"
            cursor.execute(sql, (email, invite_id, invite.parent_id, current_utc_time))
            connection.commit()

            return {"message": f"Parent invite with email {email} updated successfully!"}

    except pymysql.MySQLError as err:
        print(f"Error updating parent invite: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/parent_invite_info/delete/{email}")
async def delete_parent_invite(email: str):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteParentInvite(%s);"
            cursor.execute(sql, (email,))
            connection.commit()

            return {"message": f"Parent invite with email {email} deleted successfully (soft delete)"}
    except pymysql.MySQLError as err:
        print(f"Error deleting parent invite: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


# ChildInfo Schema
class ChildInfo(BaseModel):
    parent_id: Optional[str] = None
    class_id: int
    child_first_name: Optional[str] = None
    child_last_name: Optional[str] = None
    dob: Optional[str] = None 

# --------- ChildInfo Endpoints ---------

@app.post("/child_info/create")  
async def create_child_info(childinfo: ChildInfo = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            child_id = None
            sql = """
            CALL spCreateChildInfo(%s, %s, %s, %s, %s, @child_id);
            """
            cursor.execute(sql, (
                childinfo.parent_id, 
                childinfo.class_id, 
                childinfo.child_first_name, 
                childinfo.child_last_name, 
                childinfo.dob
            ))
            
            # Retrieve the child_id from the output variable
            cursor.execute("SELECT @child_id AS child_id;")
            result = cursor.fetchone()
            child_id = result['child_id']
            connection.commit()

            # # Insert into other forms using the child_id
            # insert_into_other_forms(child_id)

            return {"message": "Child information created successfully", "child_id": child_id}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()



def insert_into_other_forms(child_id):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            # Example: Insert into admission_form
            sql = "INSERT INTO admission_form (child_id) VALUES (%s);"
            cursor.execute(sql, (child_id,))
            
            sql = "INSERT INTO authorization_form (child_id) VALUES (%s);"
            cursor.execute(sql, (child_id,))
            
            sql = "INSERT INTO enrollment_form (child_id) VALUES (%s);"
            cursor.execute(sql, (child_id,))
            
            sql = "INSERT INTO parent_handbook (child_id) VALUES (%s);"
            cursor.execute(sql, (child_id,))
     
            connection.commit()
    except pymysql.MySQLError as err:
        print(f"Error inserting into other forms: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


@app.get("/child_info/get/{child_id}")  
async def get_child_info(child_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetChildInfo(%s);"
            cursor.execute(sql, (child_id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Child information with id {child_id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching child information: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/child_info/getall")  
async def get_all_child_info():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllChildInfo();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching all child information: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/child_info/update/{child_id}")  
async def update_child_info(child_id: int, childinfo: ChildInfo = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = """
            CALL spUpdateChildInfo(%s, %s, %s, %s, %s, %s);
            """
            cursor.execute(sql, (
                child_id, 
                childinfo.parent_id, 
                childinfo.class_id, 
                childinfo.child_first_name, 
                childinfo.child_last_name, 
                childinfo.dob
            ))
            connection.commit()

            return {"message": f"Child information with id {child_id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating child information: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/child_info/update_class/{child_id}")  
async def update_child_class_info(child_id: int, request: dict = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = """
            CALL spUpdateChildClassId(%s, %s);
            """
            cursor.execute(sql, (
                child_id, 
                request.get("class_id")
            ))
            connection.commit()

            return {"message": f"Child information with id {child_id} class_name was updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating child information: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/child_info/delete/{child_id}")  
async def delete_child_info(child_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteChildInfo(%s);"
            cursor.execute(sql, (child_id,))
            connection.commit()
            
            return {"message": f"Child information with id {child_id} deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error deleting child information: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

# ParentInvite Schema
class ParentInviteClass(BaseModel):
    parent_name: Optional[str] = None
    invite_email: Optional[str] = None
    child_fname: Optional[str] = None
    child_lname: Optional[str] = None
    child_classroom_id: Optional[int] = None

# AllFormInfo Schema
class AllFormInfo(BaseModel):
    main_topic: Optional[str] = None
    sub_topic_one: Optional[str] = None
    sub_topic_two: Optional[str] = None
    sub_topic_three: Optional[str] = None
    sub_topic_four: Optional[str] = None
    sub_topic_five: Optional[str] = None
    sub_topic_six: Optional[str] = None
    sub_topic_seven: Optional[str] = None
    sub_topic_eight: Optional[str] = None
    sub_topic_nine: Optional[str] = None
    sub_topic_ten: Optional[str] = None
    sub_topic_eleven: Optional[str] = None
    sub_topic_twelve: Optional[str] = None
    sub_topic_thirteen: Optional[str] = None
    sub_topic_fourteen: Optional[str] = None
    sub_topic_fifteen: Optional[str] = None
    sub_topic_sixteen: Optional[str] = None
    sub_topic_seventeen: Optional[str] = None
    sub_topic_eighteen: Optional[str] = None
    form_type: Optional[str] = None
    form_status: Optional[str] = None

# --------- AllFormInfo Endpoints ---------

@app.post("/all_form_info/create")
async def create_form_info(form_info: AllFormInfo = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateFormInfo(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s);"
            cursor.execute(sql, (
                form_info.main_topic, form_info.sub_topic_one, form_info.sub_topic_two,
                form_info.sub_topic_three, form_info.sub_topic_four, form_info.sub_topic_five,
                form_info.sub_topic_six, form_info.sub_topic_seven, form_info.sub_topic_eight,
                form_info.sub_topic_nine, form_info.sub_topic_ten, form_info.sub_topic_eleven,
                form_info.sub_topic_twelve, form_info.sub_topic_thirteen, form_info.sub_topic_fourteen,
                form_info.sub_topic_fifteen, form_info.sub_topic_sixteen, form_info.sub_topic_seventeen,
                form_info.sub_topic_eighteen, form_info.form_type, form_info.form_status
            ))
            connection.commit()
            return {"message": "Form info created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


@app.get("/all_form_info/get/{form_id}")
async def get_form_info(form_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetFormInfo(%s);"
            cursor.execute(sql, (form_id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Form info with id {form_id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/all_form_info/getall")
async def get_all_form_info():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllFormInfo();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/all_form_info/update/{form_id}")
async def update_form_info(form_id: int, form_info: AllFormInfo = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateFormInfo(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (
                form_id, form_info.main_topic, form_info.sub_topic_one, form_info.sub_topic_two,
                form_info.sub_topic_three, form_info.sub_topic_four, form_info.sub_topic_five,
                form_info.sub_topic_six, form_info.sub_topic_seven, form_info.sub_topic_eight,
                form_info.sub_topic_nine, form_info.sub_topic_ten, form_info.sub_topic_eleven,
                form_info.sub_topic_twelve, form_info.sub_topic_thirteen, form_info.sub_topic_fourteen,
                form_info.sub_topic_fifteen, form_info.sub_topic_sixteen, form_info.sub_topic_seventeen,
                form_info.sub_topic_eighteen, form_info.form_type, form_info.form_status
            ))
            connection.commit()

            return {"message": f"Form info with id {form_id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/all_form_info/delete/{form_id}")
async def delete_form_info(form_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteFormInfo(%s);"
            cursor.execute(sql, (form_id,))
            connection.commit()

            return {"message": f"Form info with id {form_id} deleted successfully (soft delete)"}
    except pymysql.MySQLError as err:
        print(f"Error deleting form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


# ParentInfo Schema
class ParentInfo(BaseModel):
    parent_email: Optional[str] = None
    parent_name: Optional[str] = None
    parent_street_address: Optional[str] = None
    parent_city_address: Optional[str] = None
    parent_state_address: Optional[str] = None
    parent_zip_address: Optional[str] = None
    home_telephone_number: Optional[str] = None
    home_cell_number: Optional[str] = None
    business_name: Optional[str] = None
    work_hours_from: Optional[str] = None
    work_hours_to: Optional[str] = None
    business_telephone_number: Optional[str] = None
    business_street_address: Optional[str] = None
    business_city_address: Optional[str] = None
    business_state_address: Optional[str] = None
    business_zip_address: Optional[str] = None
    business_cell_number: Optional[str] = None
    password: Optional[str] = None

# --------- ParentInfo Endpoints ---------

@app.post("/parent_info/create")  
async def create_parent_info(parentinfo: ParentInfo = Body()):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
         with connection.cursor() as cursor:
            sql = "CALL spCreateParentInfoWithAllDetails(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
            cursor.execute(sql, (
                parentinfo.parent_email, parentinfo.parent_name, parentinfo.parent_street_address, parentinfo.parent_city_address,
                parentinfo.parent_state_address, parentinfo.parent_zip_address, parentinfo.home_telephone_number,
                parentinfo.home_cell_number, parentinfo.business_name, parentinfo.work_hours_from,
                parentinfo.work_hours_to, parentinfo.business_telephone_number, parentinfo.business_street_address,
                parentinfo.business_city_address, parentinfo.business_state_address, parentinfo.business_zip_address,
                parentinfo.business_cell_number, parentinfo.password
            ))
            connection.commit()

            return {"message": "Parent info created successfully"}
         
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/parent_info/get/{id}") 
def get_parent_info(id: int):
    try:
        connection = connect_to_database()
        with connection.cursor(pymysql.cursors.DictCursor) as cursor:
            sql = "CALL spGetParentInfo(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Parent info with id {id} not found")
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        connection.close()

@app.get("/parent_info/getall")  
def get_all_parent_info():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor(pymysql.cursors.DictCursor) as cursor:
            sql = "CALL spGetAllParentInfo();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        connection.close()

@app.get("/admission_parent_info/all")  
def get_all_admission_parent_info():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor(pymysql.cursors.DictCursor) as cursor:
            sql = "CALL spGetAllParentInfo();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        connection.close()

@app.put("/parent_info/update/{id}")  
def update_parent_info(id: int, parentinfo: ParentInfo = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateParentInfo(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
            cursor.execute(sql, (
                id, parentinfo.parent_email, parentinfo.parent_name, parentinfo.parent_street_address, parentinfo.parent_city_address,
                parentinfo.parent_state_address, parentinfo.parent_zip_address, parentinfo.home_telephone_number,
                parentinfo.home_cell_number, parentinfo.business_name, parentinfo.work_hours_from,
                parentinfo.work_hours_to, parentinfo.business_telephone_number, parentinfo.business_street_address,
                parentinfo.business_city_address, parentinfo.business_state_address, parentinfo.business_zip_address,
                parentinfo.business_cell_number, parentinfo.password
            ))
            connection.commit()

            return {"message": f"Parent info with id {id} updated successfully"}
    except pymysql.MySQLError as err:
        raise HTTPException(status_code=500, detail=f"MySQL Error: {err}")
    finally:
        connection.close()

@app.put("/parent_info/delete/{id}")  
def delete_parent_info(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteParentInfo(%s)"
            cursor.execute(sql, (id,))
            connection.commit()

            return {"message": f"Parent info with id {id} deleted successfully"}
    except pymysql.MySQLError as err:
        raise HTTPException(status_code=500, detail=f"MySQL Error: {err}")
    finally:
        connection.close()

# ClassDetails Schema
class ClassDetails(BaseModel):
    class_name: Optional[str] = None

# --------- ClassDetails Endpoints ---------

@app.post("/class_details/create")  
async def create_class(classdetails: ClassDetails = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateClass(%s);"
            cursor.execute(sql, (classdetails.class_name,))
            connection.commit()

            return {"message": "Class created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/class_details/get/{id}")  
async def get_class(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetClass(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Class with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching class: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/class_details/getall")  
async def get_all_classes():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllClass();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching classes: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/class_details/update/{id}")  
async def update_class(id: int, classdetails: ClassDetails = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateClass(%s, %s);"
            cursor.execute(sql, (id, classdetails.class_name))
            connection.commit()

            return {"message": f"Class with id {id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating class: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/class_details/delete/{id}")  
async def delete_class(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteClass(%s);"
            cursor.execute(sql, (id,))
            connection.commit()

            return {"message": f"Class with id {id} deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error deleting class: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

# CareProvider Schema
class CareProvider(BaseModel):
    child_care_provider_name: Optional[str] = None
    child_care_provider_telephone_number: Optional[str] = None
    child_hospital_affiliation: Optional[str] = None
    child_care_provider_street_address: Optional[str] = None
    child_care_provider_city_address: Optional[str] = None
    child_care_provider_state_address: Optional[str] = None
    child_care_provider_zip_address: Optional[str] = None

# --------- CareProvider Endpoints ---------

@app.post("/care_provider/create")  
async def create_care_provider(careprovider: CareProvider = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateCareProvider(%s, %s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (
                careprovider.child_care_provider_name,
                careprovider.child_care_provider_telephone_number,
                careprovider.child_hospital_affiliation,
                careprovider.child_care_provider_street_address,
                careprovider.child_care_provider_city_address,
                careprovider.child_care_provider_state_address,
                careprovider.child_care_provider_zip_address
            ))
            connection.commit()

            return {"message": "Care provider created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/care_provider/get/{id}")  
async def get_care_provider(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetCareProvider(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Care provider with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching care provider: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/care_provider/getall")  
async def get_all_care_providers():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllCareProviders();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching care providers: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/care_provider/update/{id}")  
async def update_care_provider(id: int, careprovider: CareProvider = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateCareProvider(%s, %s, %s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (
                id,
                careprovider.child_care_provider_name,
                careprovider.child_care_provider_telephone_number,
                careprovider.child_hospital_affiliation,
                careprovider.child_care_provider_street_address,
                careprovider.child_care_provider_city_address,
                careprovider.child_care_provider_state_address,
                careprovider.child_care_provider_zip_address
            ))
            connection.commit()

            return {"message": f"Care provider with id {id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating care provider: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/care_provider/delete/{id}")  
async def delete_care_provider(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteCareProvider(%s);"
            cursor.execute(sql, (id,))
            connection.commit()

            return {"message": f"Care provider with id {id} deleted (soft delete) successfully"}
    except pymysql.MySQLError as err:
        print(f"Error deleting care provider: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

# Dentist Schema
class Dentist(BaseModel):
    child_dentist_name: Optional[str] = None
    dentist_telephone_number: Optional[str] = None
    dentist_street_address: Optional[str] = None
    dentist_city_address: Optional[str] = None
    dentist_state_address: Optional[str] = None
    dentist_zip_address: Optional[str] = None

# --------- Dentist Endpoints ---------

@app.post("/dentist/create")  
async def create_dentist(dentist: Dentist = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateDentist(%s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (
                dentist.child_dentist_name,
                dentist.dentist_telephone_number,
                dentist.dentist_street_address,
                dentist.dentist_city_address,
                dentist.dentist_state_address,
                dentist.dentist_zip_address
            ))
            connection.commit()

            return {"message": "Dentist created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/dentist/get/{id}")  
async def get_dentist(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetDentist(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Dentist with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching dentist: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/dentist/getall")  
async def get_all_dentists():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllDentists();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching dentists: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/dentist/update/{id}")  
async def update_dentist(id: int, dentist: Dentist = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateDentist(%s, %s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (
                id,
                dentist.child_dentist_name,
                dentist.dentist_telephone_number,
                dentist.dentist_street_address,
                dentist.dentist_city_address,
                dentist.dentist_state_address,
                dentist.dentist_zip_address
            ))
            connection.commit()

            return {"message": f"Dentist with id {id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating dentist: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/dentist/delete/{id}")  
async def delete_dentist(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteDentist(%s);"
            cursor.execute(sql, (id,))
            connection.commit()

            return {"message": f"Dentist with id {id} deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error deleting dentist: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

# EmergencyDetail Schema
class EmergencyDetail(BaseModel):
    child_emergency_contact_name: Optional[str] = None
    child_emergency_contact_relationship: Optional[str] = None
    child_emergency_contact_full_address: Optional[str] = None
    child_emergency_contact_city_address: Optional[str] = None
    child_emergency_contact_state_address: Optional[str] = None
    child_emergency_contact_zip_address: Optional[str] = None
    child_emergency_contact_telephone_number: Optional[str] = None

# --------- EmergencyDetails Endpoints ---------

@app.post("/emergency_details/create")  
async def create_emergency_detail(emergencydetail: EmergencyDetail = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateEmergencyDetail(%s, %s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (
                emergencydetail.child_emergency_contact_name,
                emergencydetail.child_emergency_contact_relationship,
                emergencydetail.child_emergency_contact_full_address,
                emergencydetail.child_emergency_contact_city_address,
                emergencydetail.child_emergency_contact_state_address,
                emergencydetail.child_emergency_contact_zip_address,
                emergencydetail.child_emergency_contact_telephone_number
            ))
            connection.commit()

            return {"message": "Emergency detail created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/emergency_details/get/{id}")  
async def get_emergency_detail(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetEmergencyDetail(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Emergency detail with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching emergency detail: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/emergency_details/getall")  
async def get_all_emergency_details():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllEmergencyDetails();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching emergency details: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/emergency_details/update/{id}")  
async def update_emergency_detail(id: int, emergencydetail: EmergencyDetail = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateEmergencyDetail(%s, %s, %s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (
                id,
                emergencydetail.child_emergency_contact_name,
                emergencydetail.child_emergency_contact_relationship,
                emergencydetail.child_emergency_contact_full_address,
                emergencydetail.child_emergency_contact_city_address,
                emergencydetail.child_emergency_contact_state_address,
                emergencydetail.child_emergency_contact_zip_address,
                emergencydetail.child_emergency_contact_telephone_number
            ))
            connection.commit()

            return {"message": f"Emergency detail with id {id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating emergency detail: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/emergency_details/delete/{id}")  
async def delete_emergency_detail(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteEmergencyDetail(%s);"
            cursor.execute(sql, (id,))
            connection.commit()

            return {"message": f"Emergency detail with id {id} deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error deleting emergency detail: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

# Schema for ClassFormRepository
class ClassFormRepository(BaseModel):
    class_id: int
    form_id: int

# --------- ClassFormRepository Endpoints ---------

@app.post("/class_form_repository/create")  
async def create_class_form_repository(entry: ClassFormRepository = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateClassFormRepository(%s, %s);"
            cursor.execute(sql, (entry.class_id, entry.form_id))
            connection.commit()

            return {"message": "Class-Form link created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/class_form_repository/get/{class_id}/{form_id}")  
async def get_class_form_repository(class_id: int, form_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetClassFormRepository(%s, %s);"
            cursor.execute(sql, (class_id, form_id))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Class-Form link not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching class-form link: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/class_form_repository/getall")  
async def get_all_class_form_repository():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllClassFormRepository();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching class-form links: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/class_form_repository/update/{class_id}/{form_id}")  
async def update_class_form_repository(
    class_id: int, form_id: int, 
    new_entry: ClassFormRepository = Body(...)
):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateClassFormRepository(%s, %s, %s, %s);"
            cursor.execute(sql, (class_id, form_id, new_entry.class_id, new_entry.form_id))
            connection.commit()

            return {"message": "Class-Form link updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating class-form link: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/class_form_repository/delete/{class_id}/{form_id}")  
async def delete_class_form_repository(class_id: int, form_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteClassFormRepository(%s, %s);"
            cursor.execute(sql, (class_id, form_id))
            connection.commit()

            return {"message": "Class-Form link deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error deleting class-form link: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

# AdmissionForm Schema
class AdmissionForm(BaseModel):
    child_id: int
    additional_parent_id: Optional[int] = None
    care_provider_id:  Optional[int]  = None
    dentist_id:  Optional[int]  = None
    nick_name: Optional[str] = None
    primary_language: Optional[str] = None
    school_age_child_school: Optional[str] = None
    do_relevant_custody_papers_apply: Optional[bool] = None
    gender: Optional[str] = None
    special_diabilities: Optional[str] = None
    allergies_medication_reaction: Optional[str] = None
    additional_info: Optional[str] = None
    medication: Optional[str] = None
    health_insurance: Optional[str] = None
    policy_number: Optional[str] = None
    obtaining_emergency_medical_care: Optional[str] = None
    administration_first_aid_procedures: Optional[str] = None
    agree_all_above_information_is_correct: Optional[bool] = None
    physical_exam_last_date: Optional[date] = None
    dental_exam_last_date: Optional[date] = None
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
    illness_during_pregnancy: Optional[str] = None
    condition_of_newborn: Optional[str] = None
    duration_of_pregnancy: Optional[str] = None
    birth_weight_lbs: Optional[str] = None
    birth_weight_oz: Optional[str] = None
    complications: Optional[str] = None
    bottle_fed: Optional[str] = None
    breast_fed: Optional[str] = None
    other_siblings_name: Optional[str] = None
    other_siblings_age: Optional[str] = None
    family_history_allergies: Optional[bool] = None
    family_history_heart_problems: Optional[bool] = None
    family_history_tuberculosis: Optional[bool] = None
    family_history_asthma: Optional[bool] = None
    family_history_high_blood_pressure: Optional[bool] = None
    family_history_vision_problems: Optional[bool] = None
    family_history_diabetes: Optional[bool] = None
    family_history_hyperactivity: Optional[bool] = None
    family_history_epilepsy: Optional[bool] = None
    no_illnesses_for_this_child: Optional[bool] = None
    age_group_friends: Optional[str] = None
    neighborhood_friends: Optional[str] = None
    relationship_with_mother: Optional[str] = None
    relationship_with_father: Optional[str] = None
    relationship_with_siblings: Optional[str] = None
    relationship_with_extended_family: Optional[str] = None
    fears_conflicts: Optional[str] = None
    child_response_frustration: Optional[str] = None
    favorite_activities: Optional[str] = None
    last_five_years_moved: Optional[bool] = None
    things_used_at_home: Optional[str] = None
    hours_of_television_daily: Optional[str] = None
    language_used_at_home: Optional[str] = None
    changes_at_home_situation: Optional[bool] = None
    educational_expectations_of_child: Optional[str] = None
    fam_his_instructions: Optional[bool] = None
    do_you_agree_this_immunization_instructions: Optional[bool] = None
    important_fam_members: Optional[str] = None
    about_family_celebrations: Optional[str] = None
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
    rest_in_the_middle_day: Optional[bool] = None
    reason_for_rest_in_the_middle_day: Optional[str] = None
    rest_routine: Optional[str] = None
    toilet_trained: Optional[bool] = None
    reason_for_toilet_trained: Optional[str] = None
    explain_for_existing_illness_allergy: Optional[bool] = None
    existing_illness_allergy: Optional[str] = None
    functioning_at_age: Optional[bool] = None
    explain_for_functioning_at_age: Optional[str] = None
    explain_able_to_walk: Optional[bool] = None
    able_to_walk: Optional[str] = None
    explain_communicate_their_needs: Optional[bool] = None
    communicate_their_needs: Optional[str] = None
    any_medication: Optional[bool] = None
    explain_for_any_medication: Optional[str] = None
    utilize_special_equipment: Optional[bool] = None
    explain_for_utilize_special_equipment: Optional[str] = None
    significant_periods: Optional[bool] = None
    explain_for_significant_periods: Optional[str] = None
    desire_any_accommodations: Optional[bool] = None
    explain_for_desire_any_accommodations: Optional[str] = None
    additional_information: Optional[str] = None
    do_you_agree_this: Optional[bool] = None
    child_password_pick_up_password_form: Optional[str] = None
    do_you_agree_this_pick_up_password_form: Optional[bool] = None
    photo_usage_photo_video_permission_form: Optional[str] = None
    photo_permission_agree_group_photos_electronic: Optional[bool] = None
    do_you_agree_this_photo_video_permission_form: Optional[bool] = None
    security_release_policy_form: Optional[bool] = None
    med_technicians_med_transportation_waiver: Optional[str] = None
    medical_transportation_waiver: Optional[bool] = None
    do_you_agree_this_health_policies: Optional[bool] = None
    parent_sign_admission_outside_waiver: Optional[bool] = None
    approve_social_media_post: Optional[bool] = None
    printed_name_social_media_post: Optional[str] = None
    do_you_agree_this_social_media_post: Optional[bool] = None
    parent_sign_admission: Optional[str] = None
    admin_sign_admission: Optional[str] = None
    emergency_contact_first_id: Optional[int] = None
    emergency_contact_second_id: Optional[int] = None
    emergency_contact_third_id: Optional[int] = None
    pointer:Optional[int] = None 
    agree_all_above_info_is_correct: Optional[bool] = None  

# --------- AdmissionForm Endpoints ---------

@app.post("/admission_form/create")
async def create_admission_form(admission_form: AdmissionForm = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = """
            CALL spCreateAdmissionForm(
                %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
            );
            """
            cursor.execute(sql, (
                admission_form.child_id, admission_form.additional_parent_id, admission_form.care_provider_id,
                admission_form.dentist_id, admission_form.nick_name, admission_form.primary_language,
                admission_form.school_age_child_school, admission_form.do_relevant_custody_papers_apply, admission_form.gender,
                admission_form.special_diabilities, admission_form.allergies_medication_reaction, admission_form.additional_info,
                admission_form.medication, admission_form.health_insurance, admission_form.policy_number,
                admission_form.obtaining_emergency_medical_care, admission_form.administration_first_aid_procedures,
                admission_form.agree_all_above_information_is_correct, admission_form.physical_exam_last_date,
                admission_form.dental_exam_last_date, admission_form.allergies, admission_form.asthma,
                admission_form.bleeding_problems, admission_form.diabetes, admission_form.epilepsy,
                admission_form.frequent_ear_infections, admission_form.frequent_illnesses,
                admission_form.hearing_problems, admission_form.high_fevers, admission_form.hospitalization,
                admission_form.rheumatic_fever, admission_form.seizures_convulsions,
                admission_form.serious_injuries_accidents, admission_form.surgeries, admission_form.vision_problems,
                admission_form.medical_other, admission_form.illness_during_pregnancy, admission_form.condition_of_newborn,
                admission_form.duration_of_pregnancy, admission_form.birth_weight_lbs, admission_form.birth_weight_oz,
                admission_form.complications, admission_form.bottle_fed, admission_form.breast_fed,
                admission_form.other_siblings_name, admission_form.other_siblings_age,
                admission_form.family_history_allergies, admission_form.family_history_heart_problems,
                admission_form.family_history_tuberculosis, admission_form.family_history_asthma,
                admission_form.family_history_high_blood_pressure, admission_form.family_history_vision_problems,
                admission_form.family_history_diabetes, admission_form.family_history_hyperactivity,
                admission_form.family_history_epilepsy, admission_form.no_illnesses_for_this_child, admission_form.age_group_friends,
                admission_form.neighborhood_friends, admission_form.relationship_with_mother,
                admission_form.relationship_with_father, admission_form.relationship_with_siblings,
                admission_form.relationship_with_extended_family, admission_form.fears_conflicts,
                admission_form.child_response_frustration, admission_form.favorite_activities,
                admission_form.last_five_years_moved, admission_form.things_used_at_home,
                admission_form.hours_of_television_daily, admission_form.language_used_at_home,
                admission_form.changes_at_home_situation, admission_form.educational_expectations_of_child,
                admission_form.fam_his_instructions, admission_form.do_you_agree_this_immunization_instructions,
                admission_form.important_fam_members, admission_form.about_family_celebrations,
                admission_form.childcare_before, admission_form.reason_for_childcare_before,
                admission_form.what_child_interests, admission_form.drop_off_time, admission_form.pick_up_time,
                admission_form.restricted_diet, admission_form.restricted_diet_reason, admission_form.eat_own,
                admission_form.eat_own_reason, admission_form.favorite_foods, admission_form.rest_in_the_middle_day,
                admission_form.reason_for_rest_in_the_middle_day, admission_form.rest_routine, admission_form.toilet_trained,
                admission_form.reason_for_toilet_trained, admission_form.explain_for_existing_illness_allergy,
                admission_form.existing_illness_allergy, admission_form.functioning_at_age,
                admission_form.explain_for_functioning_at_age, admission_form.explain_able_to_walk,
                admission_form.able_to_walk, admission_form.explain_communicate_their_needs,
                admission_form.communicate_their_needs, admission_form.any_medication,
                admission_form.explain_for_any_medication, admission_form.utilize_special_equipment,
                admission_form.explain_for_utilize_special_equipment, admission_form.significant_periods,
                admission_form.explain_for_significant_periods, admission_form.desire_any_accommodations,
                admission_form.explain_for_desire_any_accommodations, admission_form.additional_information,
                admission_form.do_you_agree_this, admission_form.child_password_pick_up_password_form,
                admission_form.do_you_agree_this_pick_up_password_form, admission_form.photo_usage_photo_video_permission_form,
                admission_form.photo_permission_agree_group_photos_electronic, admission_form.do_you_agree_this_photo_video_permission_form,
                admission_form.security_release_policy_form, admission_form.med_technicians_med_transportation_waiver,
                admission_form.medical_transportation_waiver, admission_form.do_you_agree_this_health_policies,
                admission_form.parent_sign_admission_outside_waiver, admission_form.approve_social_media_post,
                admission_form.printed_name_social_media_post, admission_form.do_you_agree_this_social_media_post,
                admission_form.parent_sign_admission, admission_form.admin_sign_admission, admission_form.emergency_contact_first_id, admission_form.emergency_contact_second_id, admission_form.emergency_contact_third_id,admission_form.pointer, admission_form.agree_all_above_info_is_correct
            ))
            connection.commit()

            return {"message": "Admission form created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/admission_form/get/{child_id}")
async def get_admission_form(child_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAdmissionForm(%s);"
            cursor.execute(sql, (child_id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Admission form with id {child_id} not found")
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
async def update_admission_form(child_id: int, admission_form: AdmissionForm = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = """
            CALL spUpdateAdmissionForm(
                %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
            );
            """
            cursor.execute(sql, (
                child_id, admission_form.additional_parent_id, admission_form.care_provider_id,
                admission_form.dentist_id, admission_form.nick_name, admission_form.primary_language,
                admission_form.school_age_child_school, admission_form.do_relevant_custody_papers_apply, admission_form.gender,
                admission_form.special_diabilities, admission_form.allergies_medication_reaction, admission_form.additional_info,
                admission_form.medication, admission_form.health_insurance, admission_form.policy_number,
                admission_form.obtaining_emergency_medical_care, admission_form.administration_first_aid_procedures,
                admission_form.agree_all_above_information_is_correct, admission_form.physical_exam_last_date,
                admission_form.dental_exam_last_date, admission_form.allergies, admission_form.asthma,
                admission_form.bleeding_problems, admission_form.diabetes, admission_form.epilepsy,
                admission_form.frequent_ear_infections, admission_form.frequent_illnesses,
                admission_form.hearing_problems, admission_form.high_fevers, admission_form.hospitalization,
                admission_form.rheumatic_fever, admission_form.seizures_convulsions,
                admission_form.serious_injuries_accidents, admission_form.surgeries, admission_form.vision_problems,
                admission_form.medical_other, admission_form.illness_during_pregnancy, admission_form.condition_of_newborn,
                admission_form.duration_of_pregnancy, admission_form.birth_weight_lbs, admission_form.birth_weight_oz,
                admission_form.complications, admission_form.bottle_fed, admission_form.breast_fed,
                admission_form.other_siblings_name, admission_form.other_siblings_age,
                admission_form.family_history_allergies, admission_form.family_history_heart_problems,
                admission_form.family_history_tuberculosis, admission_form.family_history_asthma,
                admission_form.family_history_high_blood_pressure, admission_form.family_history_vision_problems,
                admission_form.family_history_diabetes, admission_form.family_history_hyperactivity,
                admission_form.family_history_epilepsy, admission_form.no_illnesses_for_this_child, admission_form.age_group_friends,
                admission_form.neighborhood_friends, admission_form.relationship_with_mother,
                admission_form.relationship_with_father, admission_form.relationship_with_siblings,
                admission_form.relationship_with_extended_family, admission_form.fears_conflicts,
                admission_form.child_response_frustration, admission_form.favorite_activities,
                admission_form.last_five_years_moved, admission_form.things_used_at_home,
                admission_form.hours_of_television_daily, admission_form.language_used_at_home,
                admission_form.changes_at_home_situation, admission_form.educational_expectations_of_child,
                admission_form.fam_his_instructions, admission_form.do_you_agree_this_immunization_instructions,
                admission_form.important_fam_members, admission_form.about_family_celebrations,
                admission_form.childcare_before, admission_form.reason_for_childcare_before,
                admission_form.what_child_interests, admission_form.drop_off_time, admission_form.pick_up_time,
                admission_form.restricted_diet, admission_form.restricted_diet_reason, admission_form.eat_own,
                admission_form.eat_own_reason, admission_form.favorite_foods, admission_form.rest_in_the_middle_day,
                admission_form.reason_for_rest_in_the_middle_day, admission_form.rest_routine, admission_form.toilet_trained,
                admission_form.reason_for_toilet_trained, admission_form.explain_for_existing_illness_allergy,
                admission_form.existing_illness_allergy, admission_form.functioning_at_age,
                admission_form.explain_for_functioning_at_age, admission_form.explain_able_to_walk,
                admission_form.able_to_walk, admission_form.explain_communicate_their_needs,
                admission_form.communicate_their_needs, admission_form.any_medication,
                admission_form.explain_for_any_medication, admission_form.utilize_special_equipment,
                admission_form.explain_for_utilize_special_equipment, admission_form.significant_periods,
                admission_form.explain_for_significant_periods, admission_form.desire_any_accommodations,
                admission_form.explain_for_desire_any_accommodations, admission_form.additional_information,
                admission_form.do_you_agree_this, admission_form.child_password_pick_up_password_form,
                admission_form.do_you_agree_this_pick_up_password_form, admission_form.photo_usage_photo_video_permission_form,
                admission_form.photo_permission_agree_group_photos_electronic, admission_form.do_you_agree_this_photo_video_permission_form,
                admission_form.security_release_policy_form, admission_form.med_technicians_med_transportation_waiver,
                admission_form.medical_transportation_waiver, admission_form.do_you_agree_this_health_policies,
                admission_form.parent_sign_admission_outside_waiver, admission_form.approve_social_media_post,
                admission_form.printed_name_social_media_post, admission_form.do_you_agree_this_social_media_post,
                admission_form.parent_sign_admission, admission_form.admin_sign_admission, admission_form.emergency_contact_first_id, admission_form.emergency_contact_second_id, admission_form.emergency_contact_third_id,admission_form.pointer, admission_form.agree_all_above_info_is_correct
            ))
            connection.commit()
            if(admission_form.admin_sign_admission != None):
                auth_form_sql = "CALL spUpdateStudentFormRepository(%s, %s, %s, %s);"
                cursor.execute(auth_form_sql, (admission_form.child_id, 1, 1, 2))
                connection.commit()
                
            elif(admission_form.parent_sign_admission != None):
                auth_form_sql = "CALL spUpdateStudentFormRepository(%s,%s, %s, %s);"
                cursor.execute(auth_form_sql, (admission_form.child_id, 1, 1, 1))
                connection.commit()

            return {"message": f"Admission form with id {child_id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating admission form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/admission_form/delete/{child_id}")
async def delete_admission_form(child_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteAdmissionForm(%s);"
            cursor.execute(sql, (child_id,))
            connection.commit()

            return {"message": f"Admission Form with child id {child_id} successfully Deleted (SDoft delete)"}
    except pymysql.MySQLError as err:
        print(f"Error deleting admission form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


# AuthorizationForm Schema
class AuthorizationForm(BaseModel):
    child_id: int
    bank_routing: Optional[str] = None
    bank_account: Optional[str] = None
    driver_license: Optional[str] = None
    state: Optional[str] = None
    i: Optional[str] = None
    parent_sign_ach: Optional[str] = None
    admin_sign_ach: Optional[str] = None

# --------- AuthorizationForm Endpoints ---------


@app.post("/authorization_form/create")
async def create_authorization_form(form: AuthorizationForm = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = """
            CALL spCreateAuthorizationForm(
                %s, %s, %s, %s, %s, %s, %s, %s
            );
            """
            cursor.execute(sql, (
                form.child_id, form.bank_routing, form.bank_account, form.driver_license,
                form.state, form.i, form.parent_sign_ach, form.admin_sign_ach
            ))
            connection.commit()

            return {"message": "Authorization form created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/authorization_form/get/{id}")
async def get_authorization_form(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAuthorizationForm(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Authorization form with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching authorization form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/authorization_form/getall")
async def get_all_authorization_forms():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllAuthorizationForms();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching authorization forms: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/authorization_form/update/{id}")
async def update_authorization_form(id: int, form: AuthorizationForm = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = """
            CALL spUpdateAuthorizationForm(
                %s, %s, %s, %s, %s, %s, %s, %s
            );
            """
            cursor.execute(sql, (
                id, form.bank_routing, form.bank_account, form.driver_license,
                form.state, form.i, form.parent_sign_ach, form.admin_sign_ach
            ))
            connection.commit()
            if(form.admin_sign_ach != None):
                auth_form_sql = "CALL spUpdateStudentFormRepository(%s, %s, %s, %s);"
                cursor.execute(auth_form_sql, (id, 2, 2, 2))
                connection.commit()

            elif(form.parent_sign_ach != None):
                auth_form_sql = "CALL spUpdateStudentFormRepository(%s, %s, %s, %s);"
                cursor.execute(auth_form_sql, (id, 2, 2, 1))
                connection.commit()


            return {"message": f"Authorization form with id {id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating authorization form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/authorization_form/delete/{id}")
async def delete_authorization_form(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteAuthorizationForm(%s);"
            cursor.execute(sql, (id,))
            connection.commit()

            return {"message": f"Authorization form with id {id} deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error deleting authorization form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()



# EnrollmentForm Schema
class EnrollmentForm(BaseModel):
    child_id: int
    child_first_name: Optional[str] = None
    point_one_field_three: Optional[str] = None
    point_two_initial_here: Optional[str] = None
    point_three_initial_here: Optional[str] = None
    point_four_initial_here: Optional[str] = None
    point_five_initial_here: Optional[str] = None
    point_six_initial_here: Optional[str] = None
    point_seven_initial_here: Optional[str] = None
    point_eight_initial_here: Optional[str] = None
    point_nine_initial_here: Optional[str] = None
    point_ten_initial_here: Optional[str] = None
    point_eleven_initial_here: Optional[str] = None
    point_twelve_initial_here: Optional[str] = None
    point_thirteen_initial_here: Optional[str] = None
    point_fourteen_initial_here: Optional[str] = None
    point_fifteen_initial_here: Optional[str] = None
    point_sixteen_initial_here: Optional[str] = None
    point_seventeen_initial_here: Optional[str] = None
    point_eighteen_initial_here: Optional[str] = None
    preferred_start_date: Optional[str] = None
    preferred_schedule: Optional[str] = None
    full_day: Optional[bool] = None
    half_day: Optional[bool] = None
    parent_sign_enroll: Optional[str] = None
    admin_sign_enroll: Optional[str] = None

# --------- EnrollmentForm Endpoints ---------



@app.post("/enrollment_form/create")  
async def create_enrollment(enrollment: EnrollmentForm = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = """CALL spCreateEnrollmentForm(
                %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
            );"""
            cursor.execute(sql, (
                enrollment.child_id, enrollment.child_first_name, enrollment.point_one_field_three, enrollment.point_two_initial_here,
                enrollment.point_three_initial_here, enrollment.point_four_initial_here, enrollment.point_five_initial_here, enrollment.point_six_initial_here,
                enrollment.point_seven_initial_here, enrollment.point_eight_initial_here, enrollment.point_nine_initial_here, enrollment.point_ten_initial_here,
                enrollment.point_eleven_initial_here, enrollment.point_twelve_initial_here, enrollment.point_thirteen_initial_here, enrollment.point_fourteen_initial_here,
                enrollment.point_fifteen_initial_here, enrollment.point_sixteen_initial_here, enrollment.point_seventeen_initial_here, enrollment.point_eighteen_initial_here,
                enrollment.preferred_start_date, enrollment.preferred_schedule, enrollment.full_day, enrollment.half_day, enrollment.parent_sign_enroll,
                enrollment.admin_sign_enroll
            ))
            connection.commit()

            return {"message": "Enrollment created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/enrollment_form/get/{id}")  
async def get_enrollment(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetEnrollmentForm(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Enrollment with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching enrollment: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/enrollment_form/getall")  
async def get_all_enrollments():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllEnrollmentForms();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching enrollments: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/enrollment_form/update/{id}")  
async def update_enrollment(id: int, enrollment: EnrollmentForm = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = """CALL spUpdateEnrollmentForm(
                %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
            );"""
            cursor.execute(sql, (
                enrollment.child_id, enrollment.child_first_name, enrollment.point_one_field_three, enrollment.point_two_initial_here,
                enrollment.point_three_initial_here, enrollment.point_four_initial_here, enrollment.point_five_initial_here, enrollment.point_six_initial_here,
                enrollment.point_seven_initial_here, enrollment.point_eight_initial_here, enrollment.point_nine_initial_here, enrollment.point_ten_initial_here,
                enrollment.point_eleven_initial_here, enrollment.point_twelve_initial_here, enrollment.point_thirteen_initial_here, enrollment.point_fourteen_initial_here,
                enrollment.point_fifteen_initial_here, enrollment.point_sixteen_initial_here, enrollment.point_seventeen_initial_here, enrollment.point_eighteen_initial_here,
                enrollment.preferred_start_date, enrollment.preferred_schedule, enrollment.full_day, enrollment.half_day, enrollment.parent_sign_enroll,
                enrollment.admin_sign_enroll
            ))
            connection.commit()

            if(enrollment.admin_sign_enroll != None):
                auth_form_sql = "CALL spUpdateStudentFormRepository(%s, %s, %s, %s);"
                cursor.execute(auth_form_sql, (enrollment.child_id, 4, 4, 2))
                connection.commit()
                
            elif(enrollment.parent_sign_enroll != None):
                auth_form_sql = "CALL spUpdateStudentFormRepository(%s, %s, %s, %s);"
                cursor.execute(auth_form_sql, (enrollment.child_id, 4, 4, 1))
                connection.commit()

            return {"message": f"Enrollment with id {id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating enrollment: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/enrollment_form/delete/{id}")  
async def delete_enrollment(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteEnrollmentForm(%s);"
            cursor.execute(sql, (id,))
            connection.commit()

            return {"message": f"Enrollment with id {id} deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error deleting enrollment: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


# ParentHandbook Schema
class ParentHandbook(BaseModel):
    child_id: int
    welcome_goddard_agreement: Optional[bool] = None
    mission_statement_agreement: Optional[bool] = None
    general_information_agreement: Optional[bool] = None
    medical_care_provider_agreement: Optional[bool] = None
    parent_access_agreement: Optional[bool] = None
    release_of_children_agreement: Optional[bool] = None
    registration_fees_agreement: Optional[bool] = None
    outside_engagements_agreement: Optional[bool] = None
    health_policies_agreement: Optional[bool] = None
    medication_procedures_agreement: Optional[bool] = None
    bring_to_school_agreement: Optional[bool] = None
    rest_time_agreement: Optional[bool] = None
    training_philosophy_agreement: Optional[bool] = None
    affiliation_policy_agreement: Optional[bool] = None
    security_issue_agreement: Optional[bool] = None
    expulsion_policy_agreement: Optional[bool] = None
    addressing_individual_child_agreement: Optional[bool] = None
    finalword_agreement: Optional[bool] = None
    parent_sign_handbook: Optional[str] = None
    admin_sign_handbook: Optional[str] = None

# --------- ParentHandbook Endpoints ---------

@app.post("/parent_handbook/create")
async def create_parent_handbook(parent_handbook: ParentHandbook = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = """
                CALL spCreateParentHandbook(
                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                );
            """
            cursor.execute(sql, (
                parent_handbook.child_id,
                parent_handbook.welcome_goddard_agreement,
                parent_handbook.mission_statement_agreement,
                parent_handbook.general_information_agreement,
                parent_handbook.medical_care_provider_agreement,
                parent_handbook.parent_access_agreement,
                parent_handbook.release_of_children_agreement,
                parent_handbook.registration_fees_agreement,
                parent_handbook.outside_engagements_agreement,
                parent_handbook.health_policies_agreement,
                parent_handbook.medication_procedures_agreement,
                parent_handbook.bring_to_school_agreement,
                parent_handbook.rest_time_agreement,
                parent_handbook.training_philosophy_agreement,
                parent_handbook.affiliation_policy_agreement,
                parent_handbook.security_issue_agreement,
                parent_handbook.expulsion_policy_agreement,
                parent_handbook.addressing_individual_child_agreement,
                parent_handbook.finalword_agreement,
                parent_handbook.parent_sign_handbook,
                parent_handbook.admin_sign_handbook
            ))
            connection.commit()

            return {"message": "Parent handbook created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/parent_handbook/get/{id}")
async def get_parent_handbook(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetParentHandbook(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Parent handbook with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching parent handbook: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/parent_handbook/getall")
async def get_all_parent_handbooks():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllParentHandbooks();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching parent handbooks: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/parent_handbook/update/{child_id}")
async def update_parent_handbook(child_id: int, parent_handbook: ParentHandbook = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = """
                CALL spUpdateParentHandbook(
                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                );
            """
            cursor.execute(sql, (
                parent_handbook.child_id,
                parent_handbook.welcome_goddard_agreement,
                parent_handbook.mission_statement_agreement,
                parent_handbook.general_information_agreement,
                parent_handbook.medical_care_provider_agreement,
                parent_handbook.parent_access_agreement,
                parent_handbook.release_of_children_agreement,
                parent_handbook.registration_fees_agreement,
                parent_handbook.outside_engagements_agreement,
                parent_handbook.health_policies_agreement,
                parent_handbook.medication_procedures_agreement,
                parent_handbook.bring_to_school_agreement,
                parent_handbook.rest_time_agreement,
                parent_handbook.training_philosophy_agreement,
                parent_handbook.affiliation_policy_agreement,
                parent_handbook.security_issue_agreement,
                parent_handbook.expulsion_policy_agreement,
                parent_handbook.addressing_individual_child_agreement,
                parent_handbook.finalword_agreement,
                parent_handbook.parent_sign_handbook,
                parent_handbook.admin_sign_handbook
            ))
            connection.commit()

            if(parent_handbook.admin_sign_handbook != None):
                auth_form_sql = "CALL spUpdateStudentFormRepository(%s, %s, %s, %s);"
                cursor.execute(auth_form_sql, (parent_handbook.child_id, 3, 3, 2))
                connection.commit()

            elif(parent_handbook.parent_sign_handbook != None):
                auth_form_sql = "CALL spUpdateStudentFormRepository(%s, %s, %s, %s);"
                cursor.execute(auth_form_sql, (parent_handbook.child_id, 3, 3, 1))
                connection.commit()

            return {"message": f"Parent handbook with id {id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating parent handbook: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/parent_handbook/delete/{id}")
async def delete_parent_handbook(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteParentHandbook(%s);"
            cursor.execute(sql, (id,))
            connection.commit()

            return {"message": f"Parent handbook with id {id} deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error deleting parent handbook: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

# Additional APIs

@app.get("/goddard_all_form/all")
async def get_goddard_all_form_info():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllFormInfo();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/goddard_all_form/fetch/{form_id}")
async def fetch_form_info(form_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetFormInfo(%s);"
            cursor.execute(sql, (form_id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Form info with id {form_id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/goddard_all_form/all_active_forms")
async def get_goddard_all_form_info():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllActiveFormInfo()"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/goddard_all_form/all_inactive_forms")
async def get_goddard_all_form_info():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllInActiveFormInfo()"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/goddard_all_form/all_main_topic")
async def get_goddard_all_form_info():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllMainTopicFormInfo()"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/goddard_all_form/form_status/{form_id}")
async def fetch_form_info(form_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetFormInfoStatus(%s);"
            cursor.execute(sql, (form_id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Form info with id {form_id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()




@app.get("/admission_child_personal/child_count")  
async def get_all_child_info_count():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllChildCount();"
            cursor.execute(sql)
            result = cursor.fetchone()
            if result:
                return result["count"]
            else:
                return 0
    except pymysql.MySQLError as err:
        print(f"Error fetching admission forms: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/admission_child_personal/all_child_names")  
async def get_all_admission_forms_child_names():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllChildNames();"
            cursor.execute(sql)
            result = cursor.fetchall()
            if result:
                return result
            else:
                return 0
    except pymysql.MySQLError as err:
        print(f"Error fetching admission forms: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/bill_ach/form_status/{id}")
async def get_authorization_form_status(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAuthorizationFormStatus(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Authorization form with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching authorization form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/enrollment_agreement/form_status/{id}")
async def get_enrollment_form_status(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetEnrollmentFormStatus(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Authorization form with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching Enrollment Info form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/parent_handbook/form_status/{id}")
async def get_parent_handbook_status(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetParentHandbookStatus(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Authorization form with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching Parent Handbook form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


@app.get("/admission_child_personal/incomplete_form_status/{id}")
async def get_personal_info_all_incomplete_form_status(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetStudentFormRepository(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchall()
            incomplete_form_list = []
            if result:
                for data in result:
                    if(data["form_status"] == 0):
                        form_name_get_sql = "CALL spGetFormInfo(%s);"
                        cursor.execute(form_name_get_sql, data["form_id"])

                        form_detail = cursor.fetchone()
                        incomplete_form_list.append(form_detail["main_topic"])
                return {
                    "InCompletedFormStatus": incomplete_form_list
                }
            else:
                raise HTTPException(status_code=404, detail=f"Authorization form with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching authorization form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/admission_child_personal/completed_form_status/{id}")
async def get_personal_info_all_complete_form_status(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetStudentFormRepository(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchall()
            incomplete_form_list = []
            if result:
                for data in result:
                    if(data["form_status"] == 2):
                        form_name_get_sql = "CALL spGetFormInfo(%s);"
                        cursor.execute(form_name_get_sql, data["form_id"])
                        form_detail = cursor.fetchone()

                        time_stamp_get_sql = "CALL spGetAdmissionForm(%s);"
                        cursor.execute(time_stamp_get_sql, id)
                        time_stamp_detail = cursor.fetchone()
                        
                        incomplete_form_list.append({"formname" : form_detail["main_topic"], "completedTimestamp": time_stamp_detail["admin_date"]})
                return {
                    "CompletedFormStatus": incomplete_form_list
                }
            else:
                raise HTTPException(status_code=404, detail=f"Authorization form with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching authorization form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/admission_child_personal/all_form_status/{id}")
async def get_personal_info_all__form_status(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetStudentFormRepository(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchall()
            incomplete_form_list = []
            completed_form_list = []
            pending_form_list = []
            if result:
                for data in result:
                    form_name_get_sql = "CALL spGetFormInfo(%s);"
                    cursor.execute(form_name_get_sql, data["form_id"])

                    form_detail = cursor.fetchone()
                    if(data["form_status"] == 0):
                        incomplete_form_list.append(form_detail["main_topic"])
                    elif(data["form_status"] == 2):
                        completed_form_list.append(form_detail["main_topic"])
                    else:
                        pending_form_list.append(form_detail["main_topic"])
                return {
                    "Completed Forms": completed_form_list,
                    "Incomplete Forms": incomplete_form_list,
                    "Approval Pending Forms": pending_form_list
                }
            else:
                raise HTTPException(status_code=404, detail=f"Authorization form with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching authorization form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


@app.get("/admission_child_personal/parent_email/{id}")
async def get_parent_all__child(id: str):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetParentBasedChildList(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchall()
            children = []
            parent = ""
            if result:
                for data in result:
                    parent = data["parent_name"]
                    children.append({
                        "child_id": data["child_id"],
                        "child_first_name": data["child_first_name"],
                        "child_last_name": data["child_last_name"]

                    })
                return { "children": children,
                        "parent_name": parent
                }
            else:
                raise HTTPException(status_code=404, detail=f"Authorization form with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching authorization form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/admission_child_personal/all_child_personal")  
async def get_all_personal_forms():
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

@app.get("/admission_child_personal/completed_form_status_year/{id}/{year}")
async def get_personal_info_all_complete_form_status_based_on_year(id: int, year: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetYearBasedAllFormStatus(%s, %s);"
            cursor.execute(sql, (id,year))
            result = cursor.fetchall()
            completed_form_list = []
            if result:
                for data in result:
                    if(data["form_status"] == "Completed"):
                        completed_form_list.append({"formname" :data["formname"], "completedTimestamp": data["completedTimestamp"]})
                return {
                    "CompletedFormStatus": completed_form_list
                }
            else:
                raise HTTPException(status_code=404, detail=f"Authorization form with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching authorization form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()




@app.get("/admission_child_personal/form_status/{form_name}")
async def get_all_status_based_on_form(form_name: str):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spAllStatusBasedOnForm(%s);"
            cursor.execute(sql, (form_name,))
            result = cursor.fetchall()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"{form_name} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching signup_info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/admission_child_personal/all_child_status")
async def get_all_child_overall_form_status():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllChildOverAllFormStatus();"
            cursor.execute(sql,)
            result = cursor.fetchall()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail="No child found!!!!!")
    except pymysql.MySQLError as err:
        print(f"Error fetching signup_info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


# 3rd Phase APIs



@app.post("/parent_invite_with_mail_trigger/create")
async def parent_invite_create(parent_invite: ParentInviteClass = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:

            parent_table_sql = """
            CALL spCreateParentInfoAndGetID(%s, @parent_id);
            """
            cursor.execute(parent_table_sql, (parent_invite.parent_name,))

            # Fetch the result of the stored procedure (OUT parameter)
            cursor.execute("SELECT @parent_id AS parent_id;")
            res = cursor.fetchone()
            parent_id = res["parent_id"]
            

            # Call another stored procedure for child info
            child_table_sql = """
            CALL spCreateChildInfo(%s, %s, %s, %s, %s, @child_id);
            """
            cursor.execute(child_table_sql, (
                parent_id, 
                parent_invite.child_classroom_id, 
                parent_invite.child_fname, 
                parent_invite.child_lname,  
                None
            ))
            
            # Retrieve the child_id from the output variable
            cursor.execute("SELECT @child_id AS child_id;")
            result = cursor.fetchone()
            child_id = result['child_id']
            connection.commit()

            form_sql = "CALL spGetDefaultForm();"
            cursor.execute(form_sql)
            default_form_result = cursor.fetchall()

            form_set = set()
            for form_detail in default_form_result:
                form_set.add(form_detail["form_id"])


            class_form_get_sql = """
            CALL spGetClassFormRepositoryBasedClassID(%s);
            """
            cursor.execute(class_form_get_sql, parent_invite.child_classroom_id)
            form_result = cursor.fetchall()

            for form_detail in form_result:
                form_set.add(form_detail["form_id"])

            for form_id in form_set:
                if(form_id == 1):
                    cursor.execute("CALL spCreateEmptyAdmissionForm(%s)", child_id)
                    connection.commit()

                elif(form_id == 2):
                    cursor.execute("CALL spCreateEmptyAuthorizationForm(%s)", child_id)
                    connection.commit()
                elif(form_id == 3):
                    cursor.execute("CALL spCreateEmptyParentHandbook(%s)", child_id)
                    connection.commit()
                elif(form_id == 4):
                    cursor.execute("CALL spCreateEmptyEnrollmentForm(%s)", child_id)
                    connection.commit()

                student_form_create_sql = """
                CALL spCreateStudentFormRepository(%s, %s, %s);
                """
                cursor.execute(student_form_create_sql, (child_id, form_id, 0))
                connection.commit()

            # Get the current UTC time
            current_utc_time = datetime.utcnow()
            uuid1 = shortuuid.uuid()
            invite_id = f"https://arjavatech.github.io/goddard-frontend-dev/signup.html?invite_id={uuid1}"

            # Call stored procedure to trigger email invite
            email_trigger_sql = "CALL spCreateParentInvite(%s, %s, %s, %s);"
            cursor.execute(email_trigger_sql, (parent_invite.invite_email, invite_id, parent_id, current_utc_time))
            connection.commit()

            # Set up email parameters
            sender = 'noreply.goddard@gmail.com'
            app_password = 'ynir rnbf owdn mapx'
            subject = "Invitation to Create an Account for The Goddard School Admission"

            # Email content in HTML
            html_content = f"""
            <html>
            <body style="font-family: Arial, sans-serif; line-height: 1; color: #333;">
                <div style="max-width: 500px; margin: auto; padding: 0px 15px; border: 1px solid #e0e0e0; border-radius: 8px;">
                    <p>Dear {parent_invite.parent_name},</p>
                    <p>We hope this message finds you well. We are pleased to inform you that your request to enroll your son, <strong>{parent_invite.child_fname + " " + parent_invite.child_lname }</strong>, at <strong>The Goddard School</strong> has been received and approved for the next stage of the admission process.<br><br>To facilitate the admission process, we have created a secure and user-friendly online portal. We kindly request you to create an account on our admission website, where you can complete your son’s details and proceed with the application.</p>
                    <p style="text-align: center;">
                        <a href="{invite_id}" style="display: inline-block; padding: 10px 20px; margin: 10px 0; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px;">Create Your Account</a>
                    </p>
                    <p>Once your account is created, you will be guided through the steps to submit all necessary information and documents. Should you have any questions or require assistance during the process, our support team is available to help.<br><br>Thank you for choosing <strong>The Goddard School</strong> for your son’s education. We look forward to welcoming him to our school community.</p>
                    <p>Warm regards,<br>Admin Team,<br><strong>The Goddard School</strong></p>
                </div>
            </body>
            </html>
            """

            # Initialize Yagmail with the sender's Gmail credentials
            yag = yagmail.SMTP(user=sender, password=app_password)

            # Sending the email
            yag.send(to=parent_invite.invite_email, subject=subject, contents=html_content)

            return {"message": "Parent invite created and Email sent successfully!"}

    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()



@app.get("/parent_invite_mail/resend/{invite_email}")
async def parent_invite_create(invite_email: str):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:

            parent_table_sql = """
            CALL spGetParentInvite(%s);
            """
            cursor.execute(parent_table_sql, (invite_email,))
            res = cursor.fetchone()
            parent_id = res["parent_id"]

            parent_info_sql = "CALL spGetParentInfo(%s);"
            cursor.execute(parent_info_sql, (parent_id,))
            res2 = cursor.fetchone()
            
            parent_name = res2["parent_name"]


            

            # Call another stored procedure for child info
            child_table_sql = """
            CALL spGetChildName(%s);
            """
            cursor.execute(child_table_sql, (
                parent_id,
            ))
            
            result = cursor.fetchone()
            child_name = result['child_first_name']+ " " + result['child_last_name']
            connection.commit()

            # Get the current UTC time
            current_utc_time = datetime.utcnow()
            uuid1 = shortuuid.uuid()
            invite_id = f"https://arjavatech.github.io/goddard-frontend-dev/signup.html?invite_id={uuid1}"

            # Call stored procedure to trigger email invite
            email_trigger_sql = "CALL spUpdateParentInvite(%s, %s, %s, %s);"
            cursor.execute(email_trigger_sql, (invite_email, invite_id, parent_id, current_utc_time))
            connection.commit()

            # Set up email parameters
            sender = 'noreply.goddard@gmail.com'
            app_password = 'ynir rnbf owdn mapx'
            subject = "Invitation to Create an Account for The Goddard School Admission"

            # Email content in HTML
            html_content = f"""
            <html>
            <body style="font-family: Arial, sans-serif; line-height: 1; color: #333;">
                <div style="max-width: 500px; margin: auto; padding: 0px 15px; border: 1px solid #e0e0e0; border-radius: 8px;">
                    <p>Dear {parent_name},</p>
                    <p>We hope this message finds you well. We are pleased to inform you that your request to enroll your son, <strong>{child_name}</strong>, at <strong>The Goddard School</strong> has been received and approved for the next stage of the admission process.<br><br>To facilitate the admission process, we have created a secure and user-friendly online portal. We kindly request you to create an account on our admission website, where you can complete your son’s details and proceed with the application.</p>
                    <p style="text-align: center;">
                        <a href="{invite_id}" style="display: inline-block; padding: 10px 20px; margin: 10px 0; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px;">Create Your Account</a>
                    </p>
                    <p>Once your account is created, you will be guided through the steps to submit all necessary information and documents. Should you have any questions or require assistance during the process, our support team is available to help.<br><br>Thank you for choosing <strong>The Goddard School</strong> for your son’s education. We look forward to welcoming him to our school community.</p>
                    <p>Warm regards,<br>Admin Team,<br><strong>The Goddard School</strong></p>
                </div>
            </body>
            </html>
            """

            # Initialize Yagmail with the sender's Gmail credentials
            yag = yagmail.SMTP(user=sender, password=app_password)

            # Sending the email
            yag.send(to=invite_email, subject=subject, contents=html_content)

            return {"message": "Parent invite Email sent successfully!"}

    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


@app.post("/sign_up/create")
async def sign_up_create(sign_up_data: dict = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            invite_id = sign_up_data.get("invite_id")
            email = sign_up_data.get("email")
            password = sign_up_data.get("password")
            sql = "CALL spGetParentIdInInviteTable(%s);"
            cursor.execute(sql, (invite_id,))
            result = cursor.fetchone()
            print(result)
            
            if result:
                parent_id = result['parent_id']
                password_update_sql = "CALL spUpdateParentInfoPassword(%s, %s, %s);"
                cursor.execute(password_update_sql, (parent_id,email, password))
                connection.commit()

                return {"message": "SignUp Data successfully updated"}
            else:
                raise HTTPException(status_code=404, detail=f"signup_id {invite_id} is not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching signup_info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


@app.post("/sign_in/check")
async def signin_check(sign_up_data: dict = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            email = sign_up_data.get("email")
            password = sign_up_data.get("password")
            sql = "CALL spGetAdminInfo(%s);"
            cursor.execute(sql, (email,))
            result = cursor.fetchone()
            if result:
                db_password = result['password']
                if(password == db_password):
                    return {"isAdmin": True}
                else:
                    return {"error" : f"admin_id {email} password was mismatch"}
            else:
               parent_check_sql = "CALL spGetParentInfoBasedEmail(%s);"
               cursor.execute(parent_check_sql, (email,))
               parent_check_result = cursor.fetchone() 
               if parent_check_result:
                   db_password = parent_check_result["password"]
                   if(password == db_password):
                     return {"isParent": True}
                   else:
                     return {"error" : f"parent_id {email} password was mismatch"}

               else:
                    raise HTTPException(status_code=404, detail={"error" : f"signin_id {email} is not found"})
    except pymysql.MySQLError as err:
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/parent_invite_status/getall")
async def get_all_invite_status():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetInviteStatus();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching student-form links: {err}")
        raise HTTPException(status_code=500, detail={"error": "DB error"})
    finally:
        if connection:
            connection.close()




@app.get("/parent_invite_info/all")
async def get_parent_invites():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllParentInvites();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching parent invites: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/parent_invite_info/all_parent_email")
async def get_parent_invite_emails():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllParentInviteEmails()"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching parent invites: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/parent_invite_info/invite_status/{email}")
async def get_parent_invite_status(email: str):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetParentInviteStatus(%s)"
            cursor.execute(sql, email)
            result = cursor.fetchone()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching parent invites: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/parent_invite_info/accepted_invite")
async def get_parent_accepted_invite_emails():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetInviteStatus()"
            cursor.execute(sql)
            result = cursor.fetchall()
            accepted_mails = []
            for data in result:
                if(data["status"] == "Active"):
                    accepted_mails.append({"parent_email": data["invite_email"]})
            return accepted_mails     
    except pymysql.MySQLError as err:
        print(f"Error fetching parent invites: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/parent_invite_info/not_accepted_invite")
async def get_parent_not_accepted_invite_emails():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetInviteStatus()"
            cursor.execute(sql)
            result = cursor.fetchall()
            not_accepted_mails = []
            for data in result:
                if(data["status"] == "Inactive"):
                    not_accepted_mails.append({"parent_email": data["invite_email"]})
            return not_accepted_mails     
    except pymysql.MySQLError as err:
        print(f"Error fetching parent invites: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/class_based_child_count/{class_id}")  
def get_class_based_child_count(class_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spClassBasedChildCount(%s);"
            cursor.execute(sql,(class_id))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Child count with class id {class_id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching emergency detail: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/child_count_with_class_name")  
def get_child_count_with_class_name():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spClassBasedChildCountWithClassName();"
            cursor.execute(sql)
            result = cursor.fetchall()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Child count not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching emergency detail: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()



# 24-09-2024 works


# Schema for StudentFormRepository
class StudentFormRepository(BaseModel):
    child_id: int
    form_id: int
    form_status: int = 0  # Optional for specific cases

# --------- StudentFormRepository Endpoints ---------

# Create a new entry in student_form_repository
@app.post("/student_form_repository/create")
async def create_student_form_repository(entry: StudentFormRepository):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")
    
    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateStudentFormRepository(%s, %s, %s);"
            cursor.execute(sql, (entry.child_id, entry.form_id, entry.form_status))
            connection.commit()
            return {"message": "Student-Form link created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

# Get a specific entry from student_form_repository
@app.get("/student_form_repository/get/{child_id}")
async def get_student_form_repository(child_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")
    
    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetStudentFormRepository(%s);"
            cursor.execute(sql, (child_id,))
            result = cursor.fetchall()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail="Student-Form link not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching student-form link: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

# Get all active entries from student_form_repository
@app.get("/student_form_repository/getall")
async def get_all_student_form_repository():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")
    
    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllStudentFormRepository();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching student-form links: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

# Update an existing student_form_repository entry
@app.put("/student_form_repository/update/{child_id}/{old_form_id}")
async def update_student_form_repository(child_id: int, old_form_id: int, new_entry: StudentFormRepository):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")
    
    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateStudentFormRepository(%s, %s, %s, %s);"
            cursor.execute(sql, (child_id, old_form_id, new_entry.form_id, new_entry.form_status))
            connection.commit()
            return {"message": "Student-Form link updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating student-form link: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

# Soft delete a specific entry in student_form_repository
@app.put("/student_form_repository/delete/{child_id}/{form_id}")
async def delete_student_form_repository(child_id: int, form_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")
    
    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteStudentFormRepository(%s, %s);"
            cursor.execute(sql, (child_id, form_id))
            connection.commit()
            return {"message": "Student-Form link deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error deleting student-form link: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

# Soft delete all forms for a child
@app.put("/student_form_repository/delete_all/{child_id}")
async def delete_all_student_form_repository(child_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")
    
    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteStudentAllFormRepository(%s);"
            cursor.execute(sql, (child_id,))
            connection.commit()
            return {"message": "All Student-Form links deleted for child_id"}
    except pymysql.MySQLError as err:
        print(f"Error deleting student-form links: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/class_based_all_child_details/{class_id}")  
def get_class_based_child_count(class_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllClassRoomBasedChildDetails(%s);"
            cursor.execute(sql,(class_id))
            result = cursor.fetchall()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"No one entry in the class id - {class_id}")
    except pymysql.MySQLError as err:
        print(f"Error fetching emergency detail: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/form_based_all_child_details/{form_id}")  
def get_form_based_child_count(form_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllFormBasedChildDetails(%s);"
            cursor.execute(sql,(form_id))
            result = cursor.fetchall()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"No one entry is in the form id - {form_id}")
    except pymysql.MySQLError as err:
        print(f"Error fetching emergency detail: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


@app.get("/child_all_details/fetch/{child_id}")
async def fetch_child_details(child_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetStudentAllDetails(%s);"
            cursor.execute(sql, (child_id,))
            result = cursor.fetchone()
            if result:
                # Deserialize the JSON strings
                filtered_result = {}
                for key, value in result.items():
                    if value is not None:
                        try:
                            # Try to load value as JSON if it's a valid JSON string
                            filtered_result[key.split('.')[-1]] = json.loads(value)
                        except (json.JSONDecodeError, TypeError):
                            # If it's not a JSON string, keep the value as it is
                            filtered_result[key.split('.')[-1]] = value

                return filtered_result
            else:
                raise HTTPException(status_code=404, detail=f"Student info with id {child_id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/child_all_form_details/fetch/{child_id}")
async def fetch_child_details(child_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetStudentAllDetailsAsNestedJson(%s);"
            cursor.execute(sql, (child_id,))
            result = cursor.fetchone()
            
            if result:
                # Deserialize the JSON strings
                filtered_result = {}
                for key, value in result.items():
                    if value is not None:
                        try:
                            # Try to load value as JSON if it's a valid JSON string
                            filtered_result[key.split('.')[-1]] = json.loads(value)
                        except (json.JSONDecodeError, TypeError):
                            # If it's not a JSON string, keep the value as it is
                            filtered_result[key.split('.')[-1]] = value

                return filtered_result
            else:
                raise HTTPException(status_code=404, detail=f"Student info with id {child_id} not found")
    
    except pymysql.MySQLError as err:
        print(f"Error fetching form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    
    finally:
        if connection:
            connection.close()


class FormRepositary(BaseModel):
    form_id: Optional[int] = None
    form_name: Optional[str] = None
    state: Optional[int] = None

@app.post("/form/create")
async def create_form(form: FormRepositary = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spInsertForm(%s, %s);"
            cursor.execute(sql, (form.form_name, form.state))
            connection.commit()
            return {"message": "Form created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


@app.put("/form/update")
async def update_form(form: FormRepositary = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateForm(%s, %s, %s);"
            cursor.execute(sql, (form.form_id, form.form_name, form.state))
            connection.commit()
            return {"message": "Form updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.delete("/form/delete/{form_id}")
async def delete_form(form_id: int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteForm(%s);"
            cursor.execute(sql, (form_id,))
            connection.commit()
            return {"message": "Form deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


@app.get("/form/{form_id}")
async def get_form(form_id: int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetForm(%s);"
            cursor.execute(sql, (form_id,))
            result = cursor.fetchone()
            return result
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/form/default")
async def get_default_forms():
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetDefaultForm();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

# mail trigger
@app.get("/forget_password_mail_trigger/{email}")
async def password_change(email: str):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:

            sql = "CALL spGetParentInfoBasedEmail(%s);"
            cursor.execute(sql, (email,))
            result = cursor.fetchone()
            
            if result:
                sender = 'noreply.goddard@gmail.com'
                app_password = 'ynir rnbf owdn mapx'

                uuid1 = shortuuid.uuid()
                invite_id = f"https://arjavatech.github.io/goddard-frontend-dev/reset_password.html?invite_id={uuid1}"


                subject = "Reset Your Password for The Goddard school Admission Portal"


                html_content = f"""
                <html>
                <body style="font-family: Arial, sans-serif; line-height: 1; color: #333;">
                    <div style="max-width: 500px; margin: auto; padding: 0px 15px; border: 1px solid #e0e0e0; border-radius: 8px;">
                        <p>Dear {result["parent_name"]},</p>
                        <p>We hope this message finds you well. It appears that you have requested to reset your password for your account on the <strong>The Goddard school</strong> admission portal.<br><br>To reset your password and regain access to your account, please click on the link below:</p>
                        <p style="text-align: center;">
                            <a href="{invite_id}" style="display: inline-block; padding: 10px 20px; margin: 10px 0; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px;">Reset Your Password</a>
                        </p>
                        <p>Once you have reset your password, you will be able to log in and continue with the admission process. If you did not request a password reset or have any questions, please do not hesitate to contact our support team for assistance.<br><br>hank you for your attention to this matter. We look forward to assisting you with the admission process, to The Goddard School.</p>
                        <p>Warm regards,<br>Admin Team,<br><strong>The Goddard School</strong></p>

                    </div>
                </body>
                </html>
                """

                # Initialize Yagmail with the sender's Gmail credentials
                yag = yagmail.SMTP(user=sender, password=app_password)

                # Sending the email with HTML table in the body and Excel attachment
                yag.send(to=email, subject=subject, contents=html_content)

                return {"message": "Password reset email sent successfully!"}
            else:
                raise HTTPException(status_code=404, detail=f"SignUpInfo with email_id {email} not found")
    except pymysql.MySQLError:
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/parent_info/update_password")
async def update_parent_password(login_info = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            email = login_info.get("email")
            password = login_info.get("password")

            parent_info_sql = "CALL spGetParentInfoBasedEmail(%s);"
            cursor.execute(parent_info_sql, (email,))
            parent_info_result = cursor.fetchone()
            
            if parent_info_result:
                sql = "CALL spUpdateParentPassword(%s, %s);"
                cursor.execute(sql, (email, password))
                connection.commit()

                return {"message": f"Parent Info with email_id {email} password updated successfully"}
            else:
                raise HTTPException(status_code=500, detail=f"Parent info with email_id {email} not found")
    except pymysql.MySQLError as err:
        print(f"Error updating signup_info: {err}")
        raise HTTPException(status_code=500, detail={"error": f"Parent Info with email_id {email} password update call failed (DB Error)"})
    finally:
        if connection:
            connection.close()


handler=mangum.Mangum(app)