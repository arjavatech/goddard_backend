from fastapi import FastAPI, HTTPException, Body
from pydantic import BaseModel
import pymysql

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

            return {"message": "Parent invite created successfully"}
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
async def update_parent_invite(email: str, invite: ParentInvite = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateParentInvite(%s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (email, invite.invite_id, invite.parent_name, invite.child_full_name, invite.invite_status, invite.signed_up_email))
            connection.commit()

            return {"message": f"Parent invite with email {email} updated successfully"}
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
