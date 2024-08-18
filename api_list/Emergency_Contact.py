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
