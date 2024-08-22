from datetime import date, time
import json
from fastapi import APIRouter, Body, FastAPI, HTTPException, Path
from fastapi.responses import JSONResponse
from pydantic import BaseModel
from typing import Optional, Union
import pymysql
import mangum
import yagmail

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

# SignUpInfo Schema
class SignUpInfo(BaseModel):
    email_id: str
    invite_id: str = None
    password: str = None
    admin: bool = False
    temp_password: bool = False

# --------- SignUpInfo Endpoints ---------

@app.post("/signup_info/create")
async def create_signup_info(signup_info: SignUpInfo = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateSignUpInfo(%s, %s, %s, %s, %s);"
            cursor.execute(sql, (signup_info.email_id, signup_info.invite_id, signup_info.password, signup_info.admin, signup_info.temp_password))
            connection.commit()

            return {"message": "SignUpInfo created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/signup_info/get/{email_id}")
async def get_signup_info(email_id: str):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetSignUpInfo(%s);"
            cursor.execute(sql, (email_id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"SignUpInfo with email_id {email_id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching signup_info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/signup_info/getall")
async def get_all_signup_info():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllSignUpInfo();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching signup_info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/signup_info/update/{email_id}")
async def update_signup_info(email_id: str, signup_info: SignUpInfo = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateSignUpInfo(%s, %s, %s, %s, %s);"
            cursor.execute(sql, (email_id, signup_info.invite_id, signup_info.password, signup_info.admin, signup_info.temp_password))
            connection.commit()

            return {"message": f"SignUpInfo with email_id {email_id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating signup_info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/signup_info/delete/{email_id}")
async def delete_signup_info(email_id: str):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteSignUpInfo(%s);"
            cursor.execute(sql, (email_id,))
            connection.commit()

            return {"message": f"SignUpInfo with email_id {email_id} deleted successfully (soft delete)"}
    except pymysql.MySQLError as err:
        print(f"Error deleting signup_info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()






# ParentInvite Schema
class ParentInvite(BaseModel):
    email: str
    invite_id: str = None
    parent_name: str = None
    child_full_name: str = None
    invite_status: str = None
    signed_up_email: str = None

# --------- ParentInvite Endpoints ---------

@app.post("/parent_invite_info/create")
async def create_parent_invite(invite: ParentInvite = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateParentInvite(%s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (invite.email, invite.invite_id, invite.parent_name, invite.child_full_name, invite.invite_status, invite.signed_up_email))
            connection.commit()
            sender = 'noreply.goddard@gmail.com'
            app_password = 'ynir rnbf owdn mapx'


            subject = "Invitation to Create an Account for The Goddard school Admission"


            html_content = f"""
            <html>
            <body style="font-family: Arial, sans-serif; line-height: 1; color: #333;">
                <div style="max-width: 500px; margin: auto; padding: 0px 15px; border: 1px solid #e0e0e0; border-radius: 8px;">
                    <p>Dear {invite.parent_name},</p>
                    <p>We hope this message finds you well. We are pleased to inform you that your request to enroll your son, <strong>{invite.child_full_name}</strong>, at <strong>The Goddard School</strong> has been received and approved for the next stage of the admission process.<br><br>To facilitate the admission process, we have created a secure and user-friendly online portal. We kindly request you to create an account on our admission website, where you can complete your son’s details and proceed with the application.</p>
                    <p style="text-align: center;">
                        <a href="{invite.invite_id}" style="display: inline-block; padding: 10px 20px; margin: 10px 0; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px;">Create Your Account</a>
                    </p>
                    <p>Once your account is created, you will be guided through the steps to submit all necessary information and documents. Should you have any questions or require assistance during the process, our support team is available to help.<br><br>Thank you for choosing <strong>The Goddard School</strong> for your son’s education. We look forward to welcoming him to our school community.</p>
                    <p>Warm regards,<br>Admin Team,<br><strong>The Goddard School</strong></p>

                </div>
            </body>
            </html>
            """

            # Initialize Yagmail with the sender's Gmail credentials
            yag = yagmail.SMTP(user=sender, password=app_password)

            # Sending the email with HTML table in the body and Excel attachment
            yag.send(to=invite.email, subject=subject, contents=html_content)

            return {"message": "Parent invite created and Email sent successfully!"}

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
            sql = "CALL spGetAllParentAcceptedInviteEmails()"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
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
            sql = "CALL spGetAllParentNotAcceptedInviteEmails()"
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
async def update_parent_invite(email: str, invite: ParentInvite = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateParentInvite(%s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (email, invite.invite_id, invite.parent_name, invite.child_full_name, invite.invite_status, invite.signed_up_email))
            connection.commit()
            sender = 'noreply.goddard@gmail.com'
            app_password = 'ynir rnbf owdn mapx'


            subject = "Invitation to Create an Account for The Goddard school Admission"


            html_content = f"""
            <html>
            <body style="font-family: Arial, sans-serif; line-height: 1; color: #333;">
                <div style="max-width: 500px; margin: auto; padding: 0px 15px; border: 1px solid #e0e0e0; border-radius: 8px;">
                    <p>Dear {invite.parent_name},</p>
                    <p>We hope this message finds you well. We are pleased to inform you that your request to enroll your son, <strong>{invite.child_full_name}</strong>, at <strong>The Goddard School</strong> has been received and approved for the next stage of the admission process.<br><br>To facilitate the admission process, we have created a secure and user-friendly online portal. We kindly request you to create an account on our admission website, where you can complete your son’s details and proceed with the application.</p>
                    <p style="text-align: center;">
                        <a href="{invite.invite_id}" style="display: inline-block; padding: 10px 20px; margin: 10px 0; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px;">Create Your Account</a>
                    </p>
                    <p>Once your account is created, you will be guided through the steps to submit all necessary information and documents. Should you have any questions or require assistance during the process, our support team is available to help.<br><br>Thank you for choosing <strong>The Goddard School</strong> for your son’s education. We look forward to welcoming him to our school community.</p>
                    <p>Warm regards,<br>Admin Team,<br><strong>The Goddard School</strong></p>

                </div>
            </body>
            </html>
            """

            # Initialize Yagmail with the sender's Gmail credentials
            yag = yagmail.SMTP(user=sender, password=app_password)

            # Sending the email with HTML table in the body and Excel attachment
            yag.send(to=invite.email, subject=subject, contents=html_content)

            return {"message": f"Parent invite with email {email} updated successfully and Email sent successfully!"}

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









# AllFormInfo Schema
class AllFormInfo(BaseModel):
    main_topic: str = None
    sub_topic_one: str = None
    sub_topic_two: str = None
    sub_topic_three: str = None
    sub_topic_four: str = None
    sub_topic_five: str = None
    sub_topic_six: str = None
    sub_topic_seven: str = None
    sub_topic_eight: str = None
    sub_topic_nine: str = None
    sub_topic_ten: str = None
    sub_topic_eleven: str = None
    sub_topic_twelve: str = None
    sub_topic_thirteen: str = None
    sub_topic_fourteen: str = None
    sub_topic_fifteen: str = None
    sub_topic_sixteen: str = None
    sub_topic_seventeen: str = None
    sub_topic_eighteen: str = None
    form_type: str = None
    form_status: str = None

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
    email: str
    name: str
    street_address: str
    city_address: str
    state_address: str
    zip_address: str
    home_telephone_number: str
    home_cellphone_number: str
    business_name: str
    work_hours_from: str
    work_hours_to: str
    business_telephone_number: str
    business_street_address: str
    business_city_address: str
    business_state_address: str
    business_zip_address: str
    business_cell_number: str

# --------- ParentInfo Endpoints ---------

@app.post("/parent_info/create")  
async def add_parent_info(parentinfo: ParentInfo = Body()):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateParentInfo(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (
                parentinfo.email, parentinfo.name, parentinfo.street_address, parentinfo.city_address,
                parentinfo.state_address, parentinfo.zip_address, parentinfo.home_telephone_number,
                parentinfo.home_cellphone_number, parentinfo.business_name, parentinfo.work_hours_from,
                parentinfo.work_hours_to, parentinfo.business_telephone_number, parentinfo.business_street_address,
                parentinfo.business_city_address, parentinfo.business_state_address, parentinfo.business_zip_address,
                parentinfo.business_cell_number
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
            sql = "CALL spUpdateParentInfo(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
            cursor.execute(sql, (
                id, parentinfo.email, parentinfo.name, parentinfo.street_address, parentinfo.city_address,
                parentinfo.state_address, parentinfo.zip_address, parentinfo.home_telephone_number,
                parentinfo.home_cellphone_number, parentinfo.business_name, parentinfo.work_hours_from,
                parentinfo.work_hours_to, parentinfo.business_telephone_number, parentinfo.business_street_address,
                parentinfo.business_city_address, parentinfo.business_state_address, parentinfo.business_zip_address,
                parentinfo.business_cell_number
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
    class_name: str

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
    name: str
    telephone_number: str
    hospital_affiliation: str = None
    street_address: str = None
    city_address: str = None
    state_address: str = None
    zip_address: str = None

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
                careprovider.name,
                careprovider.telephone_number,
                careprovider.hospital_affiliation,
                careprovider.street_address,
                careprovider.city_address,
                careprovider.state_address,
                careprovider.zip_address
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
                careprovider.name,
                careprovider.telephone_number,
                careprovider.hospital_affiliation,
                careprovider.street_address,
                careprovider.city_address,
                careprovider.state_address,
                careprovider.zip_address
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
    name: str
    telephone_number: str
    street_address: str
    city_address: str
    state_address: str
    zip_address: str

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
                dentist.name,
                dentist.telephone_number,
                dentist.street_address,
                dentist.city_address,
                dentist.state_address,
                dentist.zip_address
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
                dentist.name,
                dentist.telephone_number,
                dentist.street_address,
                dentist.city_address,
                dentist.state_address,
                dentist.zip_address
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







# AuthorizationForm Schema
class AuthorizationForm(BaseModel):
    child_id: int
    bank_routing: str
    bank_account: str
    driver_license: str
    state: str
    myself: str
    parent_sign: str
    admin_sign: str

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
                form.state, form.myself, form.parent_sign, form.admin_sign
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
                %s, %s, %s, %s, %s, %s, %s, %s, %s
            );
            """
            cursor.execute(sql, (
                id, form.child_id, form.bank_routing, form.bank_account, form.driver_license,
                form.state, form.myself, form.parent_sign, form.admin_sign
            ))
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
    enrollment_name: str
    point_one_field: str
    point_two_init: str
    point_three_ini: str
    point_four_init: str
    point_five_init: str
    point_six_init: str
    point_seven_init: str
    point_eight_init: str
    point_nine_init: str
    point_ten_init: str
    point_eleven_init: str
    point_twelve_init: str
    point_thirteen_init: str
    point_fourteen_init: str
    point_fifteen_initi: str
    point_sixteen_init: str
    point_seventeen_init: str
    point_eighteen_init: str
    start_date: str
    schedule_date: str
    full_day: bool
    half_day: bool
    parent_sign: str
    admin_sign: str

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
                enrollment.child_id, enrollment.enrollment_name, enrollment.point_one_field, enrollment.point_two_init,
                enrollment.point_three_ini, enrollment.point_four_init, enrollment.point_five_init, enrollment.point_six_init,
                enrollment.point_seven_init, enrollment.point_eight_init, enrollment.point_nine_init, enrollment.point_ten_init,
                enrollment.point_eleven_init, enrollment.point_twelve_init, enrollment.point_thirteen_init, enrollment.point_fourteen_init,
                enrollment.point_fifteen_initi, enrollment.point_sixteen_init, enrollment.point_seventeen_init, enrollment.point_eighteen_init,
                enrollment.start_date, enrollment.schedule_date, enrollment.full_day, enrollment.half_day, enrollment.parent_sign,
                enrollment.admin_sign
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
                %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
            );"""
            cursor.execute(sql, (
                id, enrollment.child_id, enrollment.enrollment_name, enrollment.point_one_field, enrollment.point_two_init,
                enrollment.point_three_ini, enrollment.point_four_init, enrollment.point_five_init, enrollment.point_six_init,
                enrollment.point_seven_init, enrollment.point_eight_init, enrollment.point_nine_init, enrollment.point_ten_init,
                enrollment.point_eleven_init, enrollment.point_twelve_init, enrollment.point_thirteen_init, enrollment.point_fourteen_init,
                enrollment.point_fifteen_initi, enrollment.point_sixteen_init, enrollment.point_seventeen_init, enrollment.point_eighteen_init,
                enrollment.start_date, enrollment.schedule_date, enrollment.full_day, enrollment.half_day, enrollment.parent_sign,
                enrollment.admin_sign
            ))
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
    welcome_goddard_agmt: bool
    mission_statement_agmt: bool
    general_information_agmt: bool
    statement_confidentiality_agmt: bool
    parent_access_agmt: bool
    release_children_agmt: bool
    registration_fees_agmt: bool
    outside_engagements_agmt: bool
    health_policies_agmt: bool
    medication_procedures_agmt: bool
    bring_school_agmt: bool
    rest_time_agmt: bool
    training_philosophy_agmt: bool
    affiliation_policy_agmt: bool
    security_issue_agmt: bool
    expulsion_policy_agmt: bool
    addressing_individual_child_agmt: bool
    finalword_agmt: bool
    parent_sign: str
    admin_sign: str

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
                parent_handbook.welcome_goddard_agmt,
                parent_handbook.mission_statement_agmt,
                parent_handbook.general_information_agmt,
                parent_handbook.statement_confidentiality_agmt,
                parent_handbook.parent_access_agmt,
                parent_handbook.release_children_agmt,
                parent_handbook.registration_fees_agmt,
                parent_handbook.outside_engagements_agmt,
                parent_handbook.health_policies_agmt,
                parent_handbook.medication_procedures_agmt,
                parent_handbook.bring_school_agmt,
                parent_handbook.rest_time_agmt,
                parent_handbook.training_philosophy_agmt,
                parent_handbook.affiliation_policy_agmt,
                parent_handbook.security_issue_agmt,
                parent_handbook.expulsion_policy_agmt,
                parent_handbook.addressing_individual_child_agmt,
                parent_handbook.finalword_agmt,
                parent_handbook.parent_sign,
                parent_handbook.admin_sign
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

@app.put("/parent_handbook/update/{id}")
async def update_parent_handbook(id: int, parent_handbook: ParentHandbook = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = """
                CALL spUpdateParentHandbook(
                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                );
            """
            cursor.execute(sql, (
                id,
                parent_handbook.child_id,
                parent_handbook.welcome_goddard_agmt,
                parent_handbook.mission_statement_agmt,
                parent_handbook.general_information_agmt,
                parent_handbook.statement_confidentiality_agmt,
                parent_handbook.parent_access_agmt,
                parent_handbook.release_children_agmt,
                parent_handbook.registration_fees_agmt,
                parent_handbook.outside_engagements_agmt,
                parent_handbook.health_policies_agmt,
                parent_handbook.medication_procedures_agmt,
                parent_handbook.bring_school_agmt,
                parent_handbook.rest_time_agmt,
                parent_handbook.training_philosophy_agmt,
                parent_handbook.affiliation_policy_agmt,
                parent_handbook.security_issue_agmt,
                parent_handbook.expulsion_policy_agmt,
                parent_handbook.addressing_individual_child_agmt,
                parent_handbook.finalword_agmt,
                parent_handbook.parent_sign,
                parent_handbook.admin_sign
            ))
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











# EmergencyDetail Schema
class EmergencyDetail(BaseModel):
    contact_name: str
    contact_relationship: str
    street_address: str
    city_address: str
    state_address: str
    zip_address: str
    contact_telephone_number: str

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
                emergencydetail.contact_name,
                emergencydetail.contact_relationship,
                emergencydetail.street_address,
                emergencydetail.city_address,
                emergencydetail.state_address,
                emergencydetail.zip_address,
                emergencydetail.contact_telephone_number
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
                emergencydetail.contact_name,
                emergencydetail.contact_relationship,
                emergencydetail.street_address,
                emergencydetail.city_address,
                emergencydetail.state_address,
                emergencydetail.zip_address,
                emergencydetail.contact_telephone_number
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


# EmergencyContact Schema
class EmergencyContact(BaseModel):
    emergency_id: int
    child_id: int

# --------- EmergencyContact Endpoints ---------

@app.post("/emergency_contact/create")
async def create_emergency_contact(contact: EmergencyContact = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateEmergencyContact(%s, %s);"
            cursor.execute(sql, (contact.emergency_id, contact.child_id))
            connection.commit()
            return {"message": "Emergency contact created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/emergency_contact/get/{emergency_id}/{child_id}")
async def get_emergency_contact(emergency_id: int, child_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetEmergencyContact(%s, %s);"
            cursor.execute(sql, (emergency_id, child_id))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail="Emergency contact not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching emergency contact: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/emergency_contact/getall")
async def get_all_emergency_contacts():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllEmergencyContact();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching all emergency contacts: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/emergency_contact/update/{old_emergency_id}/{old_child_id}")
async def update_emergency_contact(
    old_emergency_id: int,
    old_child_id: int,
    contact: EmergencyContact = Body(...)
):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateEmergencyContact(%s, %s, %s, %s);"
            cursor.execute(sql, (old_emergency_id, old_child_id, contact.emergency_id, contact.child_id))
            connection.commit()
            return {"message": "Emergency contact updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating emergency contact: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/emergency_contact/delete/{emergency_id}/{child_id}")
async def delete_emergency_contact(emergency_id: int, child_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteEmergencyContact(%s, %s);"
            cursor.execute(sql, (emergency_id, child_id))
            connection.commit()
            return {"message": "Emergency contact deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error deleting emergency contact: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()















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


@app.get("/sign_up/all")
async def get_all_signup():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllSignUpInfo();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching signup_info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/sign_up/is_admin/{email}")
async def fetch_form_info(email: str):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetIsAdminEmail(%s);"
            cursor.execute(sql, (email,))
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

@app.post("/sign_up/add")
async def create_signup_info(signup_info: SignUpInfo = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateSignUpInfo(%s, %s, %s, %s, %s);"
            cursor.execute(sql, (signup_info.email_id, signup_info.invite_id, signup_info.password, signup_info.admin, signup_info.temp_password))
            connection.commit()

            return {"message": "SignUpInfo created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


# mail trigger
@app.post("/mail/send")
async def create_parent_invite_and_mail_trigger(invite: ParentInvite = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateParentInvite(%s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (invite.email, invite.invite_id, invite.parent_name, invite.child_full_name, invite.invite_status, invite.signed_up_email))
            connection.commit()
            sender = 'noreply.goddard@gmail.com'
            app_password = 'ynir rnbf owdn mapx'


            subject = "Invitation to Create an Account for The Goddard school Admission"


            html_content = f"""
            <html>
            <body style="font-family: Arial, sans-serif; line-height: 1; color: #333;">
                <div style="max-width: 500px; margin: auto; padding: 0px 15px; border: 1px solid #e0e0e0; border-radius: 8px;">
                    <p>Dear {invite.parent_name},</p>
                    <p>We hope this message finds you well. We are pleased to inform you that your request to enroll your son, <strong>{invite.child_full_name}</strong>, at <strong>The Goddard School</strong> has been received and approved for the next stage of the admission process.<br><br>To facilitate the admission process, we have created a secure and user-friendly online portal. We kindly request you to create an account on our admission website, where you can complete your son’s details and proceed with the application.</p>
                    <p style="text-align: center;">
                        <a href="{invite.invite_id}" style="display: inline-block; padding: 10px 20px; margin: 10px 0; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px;">Create Your Account</a>
                    </p>
                    <p>Once your account is created, you will be guided through the steps to submit all necessary information and documents. Should you have any questions or require assistance during the process, our support team is available to help.<br><br>Thank you for choosing <strong>The Goddard School</strong> for your son’s education. We look forward to welcoming him to our school community.</p>
                    <p>Warm regards,<br>Admin Team,<br><strong>The Goddard School</strong></p>

                </div>
            </body>
            </html>
            """

            # Initialize Yagmail with the sender's Gmail credentials
            yag = yagmail.SMTP(user=sender, password=app_password)

            # Sending the email with HTML table in the body and Excel attachment
            yag.send(to=invite.email, subject=subject, contents=html_content)

            return {"message": "Parent invite created and Email sent successfully!"}

    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


# mail trigger
@app.post("/forget_password/{email}")
async def password_change(email: str):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:

            sql = "CALL spGetSignUpInfo(%s);"
            cursor.execute(sql, (email,))
            result = cursor.fetchone()
            
            if result:
                parent_invite_sql = "CALL spGetParentInvite(%s);"
                cursor.execute(parent_invite_sql, (email,))
                parent_invite_detail = cursor.fetchone()

                if parent_invite_detail:
                    sender = 'noreply.goddard@gmail.com'
                    app_password = 'ynir rnbf owdn mapx'


                    subject = "Reset Your Password for The Goddard school Admission Portal"


                    html_content = f"""
                    <html>
                    <body style="font-family: Arial, sans-serif; line-height: 1; color: #333;">
                        <div style="max-width: 500px; margin: auto; padding: 0px 15px; border: 1px solid #e0e0e0; border-radius: 8px;">
                            <p>Dear {parent_invite_detail["parent_name"]},</p>
                            <p>We hope this message finds you well. It appears that you have requested to reset your password for your account on the <strong>The Goddard school</strong> admission portal.<br><br>To reset your password and regain access to your account, please click on the link below:</p>
                            <p style="text-align: center;">
                                <a href="{result["invite_id"]}" style="display: inline-block; padding: 10px 20px; margin: 10px 0; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px;">Reset Your Password</a>
                            </p>
                            <p>Once you have reset your password, you will be able to log in and continue with the admission process. If you did not request a password reset or have any questions, please do not hesitate to contact our support team for assistance.<br><br>hank you for your attention to this matter. We look forward to assisting you with the admission process and welcoming your son, {parent_invite_detail["child_full_name"]}, to The Goddard School.</p>
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

@app.get("/admission_child_personal/child_count")  
async def get_all_admission_forms_count():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllAdmissionFormsCount();"
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
            sql = "CALL spGetAllAdmissionFormsChildNames();"
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


 

handler=mangum.Mangum(app)