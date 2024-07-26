@app.get("/parent_invite_info/getAll")
def get_all_parent_invite_info():
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetAllParentInviteInfo()"
            cursor.execute(sql)
            myresult = cursor.fetchall()
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error fetching data: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

@app.get("/parent_invite_info/get/{parent_email}")
def get_parent_invite_info(parent_email: str):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spGetParentInviteInfo(%s);"
            cursor.execute(sql, (parent_email,))
            myresult = cursor.fetchall()
            return myresult
    except pymysql.MySQLError as err:
        print(f"Error fetching data: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

@app.post("/parent_invite_info/create")
def create_parent_invite_info(parent_invite_info: ParentInviteInfo):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = """
                CALL spCreateParentInviteInfo(
                    %s, %s, %s, %s, %s, %s, %s, %s
                );
            """
            cursor.execute(sql, (
                parent_invite_info.parent_email, parent_invite_info.invite_id,
                parent_invite_info.admin, parent_invite_info.parent_name,
                parent_invite_info.child_full_name, parent_invite_info.invite_status,
                parent_invite_info.password, parent_invite_info.temp_password
            ))
            connection.commit()
            return {"message": "Parent invite info created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

@app.put("/parent_invite_info/update/{parent_email}")
def update_parent_invite_info(parent_email: str, parent_invite_info: ParentInviteInfo):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = """
                CALL spUpdateParentInviteInfo(
                    %s, %s, %s, %s, %s, %s, %s, %s
                );
            """
            cursor.execute(sql, (
                parent_invite_info.parent_email, parent_invite_info.invite_id,
                parent_invite_info.admin, parent_invite_info.parent_name,
                parent_invite_info.child_full_name, parent_invite_info.invite_status,
                parent_invite_info.password, parent_invite_info.temp_password
            ))
            connection.commit()
            return {"message": "Parent invite info updated successfully", "parent_email": parent_email}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

@app.delete("/parent_invite_info/delete/{parent_email}")
def delete_parent_invite_info(parent_email: str):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "CALL spDeleteParentInviteInfo(%s);"
            cursor.execute(sql, (parent_email,))
            connection.commit()
            return {"message": "Parent invite info deleted successfully", "parent_email": parent_email}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
