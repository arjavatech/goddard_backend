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
