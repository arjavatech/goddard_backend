@app.post("/EmergencyInfo/add")
async def add_emergencyinfo(emergency_info : Emergency_info = Body()):
    connection = database_connectivity()
    if not connection:
        return {"error": "Failed to connect to database"}
    
    try:
        
        with connection.cursor() as cursor:
          
            sql = "CALL InsertEmergencyContact( %s,%s,%s,%s,%s,%s,%s)"
            cursor.execute(sql, (emergency_info.contact_name,emergency_info.contact_relationship,emergency_info.street_address,emergency_info.city_address,emergency_info.state_address,emergency_info.zip_address,emergency_info.contact_telephone_number,))
            connection.commit()

            return {"message": "Emergency contact  saved successfully"}  

        
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()
    
# PUT call
@app.put("/EmergencyInfo/update/{id}")
def update_classname( id:int, emergency_info : Emergency_info   = Body(...)):
    connection = database_connectivity()
    if not connection:
            raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
            with connection.cursor() as cursor:
                sql = "CALL  UpdateEmergencyContact(%s,%s,%s,%s,%s,%s,%s,%s)"
                cursor.execute(sql, (id, emergency_info.contact_name,emergency_info.contact_relationship,emergency_info.street_address,emergency_info.city_address,emergency_info.state_address,emergency_info.zip_address,emergency_info.contact_telephone_number,))
                connection.commit()

                return {"message": f"Emergency contact info  updated successfully"}

    except pymysql.MySQLError as err:
            raise HTTPException(status_code=500, detail=f"MySQL Error: {err}")
    except Exception as e:
            raise HTTPException(status_code=500, detail=f"Unexpected Error: {str(e)}")
    finally:
            connection.close()
            
@app.delete("/EmergencyInfo/delete/{id}")
def delete_classname( id:int):
    connection = database_connectivity()
    if not connection:
            raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
            with connection.cursor() as cursor:
                sql = "CALL DeleteEmergencyContact(%s)"
                cursor.execute(sql, (id, ))
                connection.commit()

                return {"message": f"Emergency contact info   deleted  successfully"}

    except pymysql.MySQLError as err:
            raise HTTPException(status_code=500, detail=f"MySQL Error: {err}")
    except Exception as e:
            raise HTTPException(status_code=500, detail=f"Unexpected Error: {str(e)}")
    finally:
            connection.close()


#getall call        
@app.get("/Emergencyinfo/getall", response_class=JSONResponse)
def read_myinfo():
    connection = database_connectivity()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")
    
    try:
        with connection.cursor(pymysql.cursors.DictCursor) as cursor:
            cursor.execute("SELECT * FROM EmergencyContacts")
            result = cursor.fetchall()
            return JSONResponse(content=json.loads(json.dumps(result)))
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        connection.close()
        
 #getbyid
@app.get ("/Emergencyinfo/getbyid/{Id}")      
def read_myinfo_by_id(Id : int):
    try:
        connection = database_connectivity()
        with connection.cursor() as cursor:
            sql = "SELECT * FROM EmergencyContacts WHERE emergency_id= %s"
            cursor.execute(sql, (Id,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"classdetails with id {id} not found")
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        connection.close()