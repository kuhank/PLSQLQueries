# import cx_Oracle # error: Microsoft Visual C++ 14.0 or greater is required.

import pyodbc
import pandas as pd

db_user = 'kuhan'
db_pwd = 'kuhan'
db_host= 'localhost'
db_port = 1521
tablename='excel_data'
excelfile='test.xlsx'
db_dsn = 'localhost:1521/xepdb1'

df= pd.read_excel('test.xlsx', engine ='openpyxl')


df["date"]=df["date"].apply(pd.to_datetime, errors='coerce').dt.strftime("%Y-%m-%d")
print(df.to_string())


# conn = pyodbc.connect(f"DSN={db_dsn};UID={db_user};PWD={db_pwd}")

# check for driver
print("Driver present in my system: ", pyodbc.drivers()) 

conn_str = (
    "DRIVER={Oracle in OraDB21Home1};"
    "DBQ=localhost:1521/xepdb1;"
    "UID=kuhan;"
    "PWD=kuhan"
)
conn = pyodbc.connect(conn_str)


cursor = conn.cursor()
columns = ', '.join([f'"{col}"' for col in df.columns]) # table column name and excel column name matches
placeholder = ", ".join(["?" for _ in df.columns])
print(" placeholder: ", placeholder)
print("column name: ",columns)

insertQuery=f"insert into {tablename}({columns}) values ({placeholder})"

print(insertQuery)

for _, row in df.iterrows():
    print("index: ",_ , " rows: ", row)
    cursor.execute(insertQuery, tuple(row.values)) # pyodbc expect values to be passed as a sequence (like a tuple or list).
    #row.values returns a NumPy array
    conn.commit()

cursor.close()
conn.close()


'''
create table excel_data("date" varchar2(100),
"name" varchar2(100)
);


select * from excel_Data;

'''