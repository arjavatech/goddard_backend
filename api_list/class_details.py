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
