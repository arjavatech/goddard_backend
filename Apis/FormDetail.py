from http.client import HTTPException
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

class FormDetail(BaseModel):
    form_name: str
    
    

# FormDetail Endpoints
@app.post("/form_detail/create") # type: ignore
def create_form_detail(form_detail: FormDetail):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateFormDetail(%s)"
            cursor.execute(sql, (form_detail.form_name,))
            connection.commit()
            return {"message": "Form detail created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
        
        

@app.get("/form_detail/get/{id}")   # type: ignore
def get_form_detail(id):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetFormDetail(%s)"
            cursor.execute(sql, (id,))
            myresult = cursor.fetchone()
            if not myresult:
                raise HTTPException(status_code=404, detail="Form detail not found")
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

@app.get("/form_detail/getall")     # type: ignore
def get_all_form_details():
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllFormDetail()"
            cursor.execute(sql)
            myresult = cursor.fetchall()
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
        
        

@app.put("/form_detail/update/{id}")    # type: ignore
def update_form_detail(id: int, form_detail: FormDetail):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateFormDetail(%s, %s)"
            cursor.execute(sql, (id, form_detail.form_name))
            connection.commit()
            return {"message": "Form detail updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()


@app.delete("/form_detail/delete/{id}") # type: ignore
def delete_form_detail(id: int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteFormDetail(%s)"
            cursor.execute(sql, (id,))
            connection.commit()
            return {"message": "Form detail deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()