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

# EnrollmentForm Schema
class EnrollmentForm(BaseModel):
    child_id: int
    enrollment_name: str
    point_one_field: str
    point_two_init: str
    point_three_ini: str
    point_four_init: str
    point_five_init: str
    point_six_init: str
    point_seven_init: str
    point_eight_init: str
    point_nine_init: str
    point_ten_init: str
    point_eleven_init: str
    point_twelve_init: str
    point_thirteen_init: str
    point_fourteen_init: str
    point_fifteen_initi: str
    point_sixteen_init: str
    point_seventeen_init: str
    point_eighteen_init: str
    start_date: str
    schedule_date: str
    full_day: bool
    half_day: bool
    parent_sign: str
    admin_sign: str

# --------- EnrollmentForm Endpoints ---------

@app.post("/enrollment_form/create")  
async def create_enrollment(enrollment: EnrollmentForm = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = """CALL spCreateEnrollmentForm(
                %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
            );"""
            cursor.execute(sql, (
                enrollment.child_id, enrollment.enrollment_name, enrollment.point_one_field, enrollment.point_two_init,
                enrollment.point_three_ini, enrollment.point_four_init, enrollment.point_five_init, enrollment.point_six_init,
                enrollment.point_seven_init, enrollment.point_eight_init, enrollment.point_nine_init, enrollment.point_ten_init,
                enrollment.point_eleven_init, enrollment.point_twelve_init, enrollment.point_thirteen_init, enrollment.point_fourteen_init,
                enrollment.point_fifteen_initi, enrollment.point_sixteen_init, enrollment.point_seventeen_init, enrollment.point_eighteen_init,
                enrollment.start_date, enrollment.schedule_date, enrollment.full_day, enrollment.half_day, enrollment.parent_sign,
                enrollment.admin_sign
            ))
            connection.commit()

            return {"message": "Enrollment created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/enrollment_form/get/{id}")  
async def get_enrollment(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetEnrollmentForm(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Enrollment with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching enrollment: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/enrollment_form/getall")  
async def get_all_enrollments():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllEnrollmentForms();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching enrollments: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/enrollment_form/update/{id}")  
async def update_enrollment(id: int, enrollment: EnrollmentForm = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = """CALL spUpdateEnrollmentForm(
                %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
            );"""
            cursor.execute(sql, (
                id, enrollment.child_id, enrollment.enrollment_name, enrollment.point_one_field, enrollment.point_two_init,
                enrollment.point_three_ini, enrollment.point_four_init, enrollment.point_five_init, enrollment.point_six_init,
                enrollment.point_seven_init, enrollment.point_eight_init, enrollment.point_nine_init, enrollment.point_ten_init,
                enrollment.point_eleven_init, enrollment.point_twelve_init, enrollment.point_thirteen_init, enrollment.point_fourteen_init,
                enrollment.point_fifteen_initi, enrollment.point_sixteen_init, enrollment.point_seventeen_init, enrollment.point_eighteen_init,
                enrollment.start_date, enrollment.schedule_date, enrollment.full_day, enrollment.half_day, enrollment.parent_sign,
                enrollment.admin_sign
            ))
            connection.commit()

            return {"message": f"Enrollment with id {id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating enrollment: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/enrollment_form/delete/{id}")  
async def delete_enrollment(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteEnrollmentForm(%s);"
            cursor.execute(sql, (id,))
            connection.commit()

            return {"message": f"Enrollment with id {id} deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error deleting enrollment: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()
