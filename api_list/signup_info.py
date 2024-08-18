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
