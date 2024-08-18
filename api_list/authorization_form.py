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

# AuthorizationForm Schema
class AuthorizationForm(BaseModel):
    child_id: int
    bank_routing: str
    bank_account: str
    driver_license: str
    state: str
    myself: str
    parent_sign: str
    admin_sign: str

# --------- AuthorizationForm Endpoints ---------

@app.post("/authorization_form/create")
async def create_authorization_form(form: AuthorizationForm = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = """
            CALL spCreateAuthorizationForm(
                %s, %s, %s, %s, %s, %s, %s, %s
            );
            """
            cursor.execute(sql, (
                form.child_id, form.bank_routing, form.bank_account, form.driver_license,
                form.state, form.myself, form.parent_sign, form.admin_sign
            ))
            connection.commit()

            return {"message": "Authorization form created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/authorization_form/get/{id}")
async def get_authorization_form(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAuthorizationForm(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Authorization form with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching authorization form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/authorization_form/getall")
async def get_all_authorization_forms():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllAuthorizationForms();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching authorization forms: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/authorization_form/update/{id}")
async def update_authorization_form(id: int, form: AuthorizationForm = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = """
            CALL spUpdateAuthorizationForm(
                %s, %s, %s, %s, %s, %s, %s, %s, %s
            );
            """
            cursor.execute(sql, (
                id, form.child_id, form.bank_routing, form.bank_account, form.driver_license,
                form.state, form.myself, form.parent_sign, form.admin_sign
            ))
            connection.commit()

            return {"message": f"Authorization form with id {id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating authorization form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/authorization_form/delete/{id}")
async def delete_authorization_form(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteAuthorizationForm(%s);"
            cursor.execute(sql, (id,))
            connection.commit()

            return {"message": f"Authorization form with id {id} deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error deleting authorization form: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()
