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

# ParentHandbook Schema
class ParentHandbook(BaseModel):
    child_id: int
    welcome_goddard_agmt: bool
    mission_statement_agmt: bool
    general_information_agmt: bool
    statement_confidentiality_agmt: bool
    parent_access_agmt: bool
    release_children_agmt: bool
    registration_fees_agmt: bool
    outside_engagements_agmt: bool
    health_policies_agmt: bool
    medication_procedures_agmt: bool
    bring_school_agmt: bool
    rest_time_agmt: bool
    training_philosophy_agmt: bool
    affiliation_policy_agmt: bool
    security_issue_agmt: bool
    expulsion_policy_agmt: bool
    addressing_individual_child_agmt: bool
    finalword_agmt: bool
    parent_sign: str
    admin_sign: str

# --------- ParentHandbook Endpoints ---------

@app.post("/parent_handbook/create")
async def create_parent_handbook(parent_handbook: ParentHandbook = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = """
                CALL spCreateParentHandbook(
                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                );
            """
            cursor.execute(sql, (
                parent_handbook.child_id,
                parent_handbook.welcome_goddard_agmt,
                parent_handbook.mission_statement_agmt,
                parent_handbook.general_information_agmt,
                parent_handbook.statement_confidentiality_agmt,
                parent_handbook.parent_access_agmt,
                parent_handbook.release_children_agmt,
                parent_handbook.registration_fees_agmt,
                parent_handbook.outside_engagements_agmt,
                parent_handbook.health_policies_agmt,
                parent_handbook.medication_procedures_agmt,
                parent_handbook.bring_school_agmt,
                parent_handbook.rest_time_agmt,
                parent_handbook.training_philosophy_agmt,
                parent_handbook.affiliation_policy_agmt,
                parent_handbook.security_issue_agmt,
                parent_handbook.expulsion_policy_agmt,
                parent_handbook.addressing_individual_child_agmt,
                parent_handbook.finalword_agmt,
                parent_handbook.parent_sign,
                parent_handbook.admin_sign
            ))
            connection.commit()

            return {"message": "Parent handbook created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/parent_handbook/get/{id}")
async def get_parent_handbook(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetParentHandbook(%s);"
            cursor.execute(sql, (id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"Parent handbook with id {id} not found")
    except pymysql.MySQLError as err:
        print(f"Error fetching parent handbook: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.get("/parent_handbook/getall")
async def get_all_parent_handbooks():
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllParentHandbooks();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error fetching parent handbooks: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/parent_handbook/update/{id}")
async def update_parent_handbook(id: int, parent_handbook: ParentHandbook = Body(...)):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = """
                CALL spUpdateParentHandbook(
                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                );
            """
            cursor.execute(sql, (
                id,
                parent_handbook.child_id,
                parent_handbook.welcome_goddard_agmt,
                parent_handbook.mission_statement_agmt,
                parent_handbook.general_information_agmt,
                parent_handbook.statement_confidentiality_agmt,
                parent_handbook.parent_access_agmt,
                parent_handbook.release_children_agmt,
                parent_handbook.registration_fees_agmt,
                parent_handbook.outside_engagements_agmt,
                parent_handbook.health_policies_agmt,
                parent_handbook.medication_procedures_agmt,
                parent_handbook.bring_school_agmt,
                parent_handbook.rest_time_agmt,
                parent_handbook.training_philosophy_agmt,
                parent_handbook.affiliation_policy_agmt,
                parent_handbook.security_issue_agmt,
                parent_handbook.expulsion_policy_agmt,
                parent_handbook.addressing_individual_child_agmt,
                parent_handbook.finalword_agmt,
                parent_handbook.parent_sign,
                parent_handbook.admin_sign
            ))
            connection.commit()

            return {"message": f"Parent handbook with id {id} updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error updating parent handbook: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()

@app.put("/parent_handbook/delete/{id}")
async def delete_parent_handbook(id: int):
    connection = connect_to_database()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteParentHandbook(%s);"
            cursor.execute(sql, (id,))
            connection.commit()

            return {"message": f"Parent handbook with id {id} deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error deleting parent handbook: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()
