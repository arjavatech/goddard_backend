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

# AllFormInfo Schema
class AllFormInfo(BaseModel):
    main_topic: str = None
    sub_topic_one: str = None
    sub_topic_two: str = None
    sub_topic_three: str = None
    sub_topic_four: str = None
    sub_topic_five: str = None
    sub_topic_six: str = None
    sub_topic_seven: str = None
    sub_topic_eight: str = None
    sub_topic_nine: str = None
    sub_topic_ten: str = None
    sub_topic_eleven: str = None
    sub_topic_twelve: str = None
    sub_topic_thirteen: str = None
    sub_topic_fourteen: str = None
    sub_topic_fifteen: str = None
    sub_topic_sixteen: str = None
    sub_topic_seventeen: str = None
    sub_topic_eighteen: str = None
    form_type: str = None
    form_status: str = None

# --------- AllFormInfo Endpoints ---------

@app.post("/all_form_info/create")
async def create_form_info(form_info: AllFormInfo = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateFormInfo(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s);"
            cursor.execute(sql, (
                form_info.main_topic, form_info.sub_topic_one, form_info.sub_topic_two,
                form_info.sub_topic_three, form_info.sub_topic_four, form_info.sub_topic_five,
                form_info.sub_topic_six, form_info.sub_topic_seven, form_info.sub_topic_eight,
                form_info.sub_topic_nine, form_info.sub_topic_ten, form_info.sub_topic_eleven,
                form_info.sub_topic_twelve, form_info.sub_topic_thirteen, form_info.sub_topic_fourteen,
                form_info.sub_topic_fifteen, form_info.sub_topic_sixteen, form_info.sub_topic_seventeen,
                form_info.sub_topic_eighteen, form_info.form_type, form_info.form_status
            ))
            connection.commit()
            return {"message": "Form info created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()


@app.get("/all_form_info/get/{form_id}")
async def get_form_info(form_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetFormInfo(%s);"
            cursor.execute(sql, (form_id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Form info with id {form_id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/all_form_info/getall")
async def get_all_form_info():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllFormInfo();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/all_form_info/update/{form_id}")
async def update_form_info(form_id: int, form_info: AllFormInfo = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateFormInfo(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (
                form_id, form_info.main_topic, form_info.sub_topic_one, form_info.sub_topic_two,
                form_info.sub_topic_three, form_info.sub_topic_four, form_info.sub_topic_five,
                form_info.sub_topic_six, form_info.sub_topic_seven, form_info.sub_topic_eight,
                form_info.sub_topic_nine, form_info.sub_topic_ten, form_info.sub_topic_eleven,
                form_info.sub_topic_twelve, form_info.sub_topic_thirteen, form_info.sub_topic_fourteen,
                form_info.sub_topic_fifteen, form_info.sub_topic_sixteen, form_info.sub_topic_seventeen,
                form_info.sub_topic_eighteen, form_info.form_type, form_info.form_status
            ))
            connection.commit()

            return {"message": f"Form info with id {form_id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/all_form_info/delete/{form_id}")
async def delete_form_info(form_id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteFormInfo(%s);"
            cursor.execute(sql, (form_id,))
            connection.commit()

            return {"message": f"Form info with id {form_id} deleted successfully (soft delete)"}
    except pymysql.MySQLError as err:
        print(f"Error deleting form info: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()
