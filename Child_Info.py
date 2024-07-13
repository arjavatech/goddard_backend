import json
from fastapi import FastAPI, Body, HTTPException
from fastapi.responses import JSONResponse
import pymysql
from pydantic import BaseModel


app = FastAPI()

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
    

