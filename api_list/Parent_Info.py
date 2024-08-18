from fastapi import FastAPI, HTTPException, Body, Depends
from fastapi.responses import JSONResponse
from pydantic import BaseModel
import pymysql
import json

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
