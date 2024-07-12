import json
from fastapi import FastAPI,Body,HTTPException
from fastapi.responses import JSONResponse
import pymysql
from pydantic import BaseModel

app = FastAPI()

class childclassname(BaseModel):
    
    className : str
    
    


def database_connectivity():
    
    try:
        connection = pymysql.connect(
            host="localhost", 
            port=3306,
            user= "root",
            password="12345678",
            database="goddard_local",
            cursorclass=pymysql.cursors.DictCursor 
        )
        return connection
    except pymysql.MySQLError as err:
        print(f"Error connecting to database: {err}")
        return None
 
 #post call   
@app.post("/classname/add")

async def add_classname(classnameinfo : childclassname = Body()):
    connection = database_connectivity()
    if not connection:
        return {"error": "Failed to connect to database"}
    
    try:
        
        with connection.cursor() as cursor:
          
            sql = "CALL InsertClassDetails( %s)"
            cursor.execute(sql, (classnameinfo.className))
            connection.commit()

            return {"message": "classroom saved successfully"}  

        
    except pymysql.MySQLError as err:
        print(f"Error calling stored procedure: {err}")
        raise HTTPException(status_code=500, detail="Database error")
    finally:
        if connection:
            connection.close()
        
#getall call        
@app.get("/classname/getall", response_class=JSONResponse)
def read_myinfo():
    connection = database_connectivity()
    if not connection:
        raise HTTPException(status_code=500, detail="Failed to connect to database")
    
    try:
        with connection.cursor(pymysql.cursors.DictCursor) as cursor:
            cursor.execute("SELECT * FROM classdetails")
            result = cursor.fetchall()
            return JSONResponse(content=json.loads(json.dumps(result)))
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        connection.close()
 
 #getbyid
@app.get ("/classname/getbyid/{classId}")      
def read_myinfo_by_id(classId : int):
    try:
        connection = database_connectivity()
        with connection.cursor() as cursor:
            sql = "SELECT * FROM classdetails WHERE classId= %s"
            cursor.execute(sql, (classId,))
            result = cursor.fetchone()
            if result:
                return result
            else:
                raise HTTPException(status_code=404, detail=f"classdetails with id {classId} not found")
    except pymysql.MySQLError as e:
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        connection.close()

# PUT call
@app.put("/classname/update/{id}")
def update_classname( id:int, classnameinfo : childclassname  = Body(...)):
    connection = database_connectivity()
    if not connection:
            raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
            with connection.cursor() as cursor:
                sql = "CALL  UpdateClassDetails(%s, %s)"
                cursor.execute(sql, (id, classnameinfo.className,))
                connection.commit()

                return {"message": f"Classroom with id updated successfully"}

    except pymysql.MySQLError as err:
            raise HTTPException(status_code=500, detail=f"MySQL Error: {err}")
    except Exception as e:
            raise HTTPException(status_code=500, detail=f"Unexpected Error: {str(e)}")
    finally:
            connection.close()
        
#deletecall        
@app.delete("/classname/delete/{id}")
def delete_classname( id:int):
    connection = database_connectivity()
    if not connection:
            raise HTTPException(status_code=500, detail="Failed to connect to database")

    try:
            with connection.cursor() as cursor:
                sql = "CALL  DeleteClassDetails(%s)"
                cursor.execute(sql, (id, ))
                connection.commit()

                return {"message": f"Classroom with id deleted  successfully"}

    except pymysql.MySQLError as err:
            raise HTTPException(status_code=500, detail=f"MySQL Error: {err}")
    except Exception as e:
            raise HTTPException(status_code=500, detail=f"Unexpected Error: {str(e)}")
    finally:
            connection.close()

