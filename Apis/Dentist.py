from datetime import date
from fastapi import FastAPI, Body
import pymysql
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()


def connect_to_database():
    try:
        connection = pymysql.connect( 
            host="localhost",
            port=3306,
            user="root",
            password="Rolex_Surya07",
            database="goddardmodel",
            cursorclass=pymysql.cursors.DictCursor 
        )
        return connection
    except pymysql.MySQLError as err:
        print(f"Error connecting to database: {err}")
        return None
    
class ParentInviteInfo(BaseModel):
    parent_email: str
    invite_id: str
    admin: bool
    parent_name: str
    child_full_name: str
    invite_status: str
    password: str
    temp_password: str

@app.get("/test")
def get_test():
    return {"response": "Test get call successfully called"}

@app.get("/dentist/getAll")
def get_all_dentists():
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "call goddardmodel.spGetAllDentist();"
            cursor.execute(sql)
            myresult = cursor.fetchall()
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error fetching data: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

@app.get("/dentist/get/{id}")
def get_dentists(id):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "call goddardmodel.spGetDentist(%s);"
            cursor.execute(sql,(id,))
            myresult = cursor.fetchall()
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error fetching data: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

@app.post("/dentist/create")
def create_dentist(Body:dict = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}
    try:
        with connection.cursor() as cursor:
            name = Body.get("name")
            telephone_number = Body.get("telephone_number")
            street_address =Body.get("street_address")
            city_address = Body.get("city_address")
            state_address = Body.get("state_address")
            zip_address = Body.get("zip_address")
            sql = "call goddardmodel.spCreateDentist(%s,%s,%s,%s,%s,%s);"
            
            cursor.execute(sql,(name,telephone_number,street_address,city_address,state_address,zip_address,))
            connection.commit()
            return {"message": "Dentist created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

@app.put("/dentist/update/{id}")
def create_dentist(id:str, Body = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            name = Body.get("name")
            telephone_number = Body.get("telephone_number")
            street_address =Body.get("street_address")
            city_address = Body.get("city_address")
            state_address = Body.get("state_address")
            zip_address = Body.get("zip_address")
            sql = "CALL spUpdateDentist(%s,%s,%s,%s,%s,%s,%s)"
            
            cursor.execute(sql,(id,name,telephone_number,street_address,city_address,state_address,zip_address))
            connection.commit()
            return {"message": "Dentist updated successfully", "Dentist-ID": id}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

@app.delete("/dentist/delete/{id}")
def delete_dentist(id : str):
        connection = connect_to_database()
        if not connection:
            return {"error": "Failed to connect to database"}

        try:
            with connection.cursor() as cursor:
                sql = "call spDeleteDentist(%s);"
                cursor.execute(sql, id)
                connection.commit()
                return {"message": "Dentist deleted successfully" , "Dentist-ID": id}
        except pymysql.MySQLError as err:
            print(f"Error calling stored procedure: {err}")
            return {"error": str(err)}
        finally:
            connection.close()