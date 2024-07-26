@app.get("/emergency_contact/get/{id}")
def get_emergency_contact(p_emergency_id: int, p_child_id: int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetEmergencyContact(%s, %s)"
            cursor.execute(sql, (p_emergency_id, p_child_id))
            myresult = cursor.fetchone()
            if not myresult:
                raise HTTPException(status_code=404, detail="Emergency contact not found")
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
        
#---------------------------------

@app.get("/emergency_contact/getall")
def get_all_emergency_contacts():
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllEmergencyContact()"
            cursor.execute(sql)
            myresult = cursor.fetchall()
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()


@app.post("/emergency_contact/create")
def create_emergency_contact(emergency_contact: EmergencyContact):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spCreateEmergencyContact(%s, %s)"
            cursor.execute(sql, (emergency_contact.emergency_id, emergency_contact.child_id))
            connection.commit()
            return {"message": "Emergency contact created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

@app.put("/emergency_contact/update")
def update_emergency_contact(p_old_emergency_id: int, p_child_id: int, p_new_emergency_id: int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spUpdateEmergencyContact(%s, %s, %s)"
            cursor.execute(sql, (p_old_emergency_id, p_child_id, p_new_emergency_id))
            connection.commit()
            return {"message": "Emergency contact updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

@app.delete("/emergency_contact/delete")
def delete_emergency_contact(p_emergency_id: int, p_child_id: int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteEmergencyContact(%s, %s)"
            cursor.execute(sql, (p_emergency_id, p_child_id))
            connection.commit()
            return {"message": "Emergency contact deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()