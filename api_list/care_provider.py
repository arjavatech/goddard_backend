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
