def connect_to_database():
    try:
        connection = pymysql.connect(
            host="localhost",
            port=3306,
            user="root",
            password="Sandy@2025",
            database="goddardTest",
            cursorclass=pymysql.cursors.DictCursor
        )
        return connection
    except pymysql.MySQLError as err:
        print(f"Error connecting to database: {err}")
        return None
    
class CareProvider(BaseModel):
    name: str
    telephone_number: str
    hospital_affiliation: str = None
    street_address: str = None
    city_address: str = None
    state_address: str = None
    zip_address: str = None
    
class EmergencyContact(BaseModel):
    emergency_id: int
    child_id:int

    
connect_to_database()
@app.get("/test")
def get_test():
    return {"response": "Test get call successfully called"}

@app.get("/care_provider/getall")
def get_all_care_providers():
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "call goddardtest.⁠ spGetAllCareProvider ⁠();"
            cursor.execute(sql)
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# _______________________________________________________________________________________________

@app.get("/care_provider/get/{id}")
def get_care_providers(id:str):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "call goddardtest.⁠ spGetCareProvider ⁠(%s);"
            cursor.execute(sql,(id,))
            result = cursor.fetchall()
            return result
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# _______________________________________________________________________________________________

@app.post("/care_provider/create")
def create_care_provider(body: dict = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            id = body.get("id")
            name = body.get("name")
            telephone_number = body.get("telephone_number")
            hospital_affiliation = body.get("hospital_affiliation")
            street_address = body.get("street_address")
            city_address = body.get("city_address")
            state_address = body.get("state_address")
            zip_address = body.get("zip_address")
            
            sql = "call goddardtest.⁠spCreateCareProvider⁠(%s, %s, %s, %s, %s, %s, %s);"
            cursor.execute(sql, (name, telephone_number, hospital_affiliation, street_address, city_address, state_address, zip_address))
            connection.commit()
            return {"message": "Care provider created successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()
#   ___________________________________________________________________________________________________      

@app.put("/care_provider/update/{id}")
def update_care_provider(id: int,body: dict = Body(...)):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            id = body.get("id")
            name = body.get("name")
            telephone_number = body.get("telephone_number")
            hospital_affiliation = body.get("hospital_affiliation")
            street_address = body.get("street_address")
            city_address = body.get("city_address")
            state_address = body.get("state_address")
            zip_address = body.get("zip_address")
            
            sql = "CALL spUpdateCareProvider(%s, %s, %s, %s, %s, %s, %s, %s)"
            cursor.execute(sql, (id, name, telephone_number, hospital_affiliation, street_address, city_address, state_address, zip_address))

            connection.commit()
            return {"message": "Care provider updated successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

# ________________________________________________________________________________________________

@app.delete("/care_provider/delete/{id}")
def delete_care_provider(id:int):
    connection = connect_to_database()
    if not connection:
        return {"error": "Failed to connect to database"}

    try:
        with connection.cursor() as cursor:
            sql = "call goddardtest.⁠ spDeleteCareProvider ⁠(%s);"
            cursor.execute(sql,(id,))
            connection.commit()

            return {"message": "Care provider deleted successfully"}
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        return {"error": str(err)}
    finally:
        connection.close()

if _name_ == "_main_":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)