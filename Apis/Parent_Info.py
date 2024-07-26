from http.client import HTTPException
from pathlib import Path
import pymysql # type: ignore
from pydantic import BaseModel # type: ignore


def connect_to_database():
    try:
        connection = pymysql.connect(
            host="localhost",
            port=3306,
            user="root",
            password="mysqlroot",
            database="goddard",
            cursorclass=pymysql.cursors.DictCursor
        )
        return connection
    except pymysql.MySQLError as err:
        print(f"Error connecting to database: {err}")
        return None


class ParentInfo(BaseModel):
    email: str
    name: str = None
    street_address: str = None
    city_address: str = None
    state_address: str = None
    zip_address: str = None
    home_telephone_number: str = None
    home_cellphone_number: str = None
    business_name: str = None
    work_hours_from: str = None
    work_hours_to: str = None
    business_telephone_number: str = None
    business_street_address: str = None
    business_city_address: str = None
    business_state_address: str = None
    business_zip_address: str = None
    business_cell_number: str = None
    
    


# ParentInfo Endpoints
@app.post("/parent_info/create")        # type: ignore
def create_parent_info(parent_info: ParentInfo):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = ("CALL spCreateParentInfo(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)")
            cursor.execute(sql, (parent_info.email, parent_info.name, parent_info.street_address, parent_info.city_address, 
                                 parent_info.state_address, parent_info.zip_address, parent_info.home_telephone_number, 
                                 parent_info.home_cellphone_number, parent_info.business_name, parent_info.work_hours_from, 
                                 parent_info.work_hours_to, parent_info.business_telephone_number, parent_info.business_street_address, 
                                 parent_info.business_city_address, parent_info.business_state_address, parent_info.business_zip_address, 
                                 parent_info.business_cell_number))
            connection.commit()
            return {"message": "Parent info created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
 
 
 
     
@app.get("/parent_info/get/{id}")       # type: ignore
def get_parent_info(id: int = Path(..., title="The ID of the parent info to retrieve")):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetParentInfo(%s)"
            cursor.execute(sql, (id,))
            myresult = cursor.fetchone()
            if not myresult:
                raise HTTPException(status_code=404, detail="Parent info not found")
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

@app.get("/parent_info/getall")     # type: ignore
def get_all_parent_info():
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllParentInfo()"
            cursor.execute(sql)
            myresult = cursor.fetchall()
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
        
       

@app.put("/parent_info/update/{id}")        # type: ignore
def update_parent_info(id: int, parent_info: ParentInfo):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = ("CALL spUpdateParentInfo(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)")
            cursor.execute(sql, (id, parent_info.email, parent_info.name, parent_info.street_address, parent_info.city_address, 
                                 parent_info.state_address, parent_info.zip_address, parent_info.home_telephone_number, 
                                 parent_info.home_cellphone_number, parent_info.business_name, parent_info.work_hours_from, 
                                 parent_info.work_hours_to, parent_info.business_telephone_number, parent_info.business_street_address, 
                                 parent_info.business_city_address, parent_info.business_state_address, parent_info.business_zip_address, 
                                 parent_info.business_cell_number))
            connection.commit()
            return {"message": "Parent info updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

@app.delete("/parent_info/delete/{id}")     # type: ignore
def delete_parent_info(id: int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteParentInfo(%s)"
            cursor.execute(sql, (id,))
            connection.commit()
            return {"message": "Parent info deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()