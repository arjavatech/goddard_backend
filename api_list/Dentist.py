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
