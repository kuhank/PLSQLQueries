import pandas as pd # for excel processing
import pyodbc # driver to communicate with database

print(pyodbc.drivers()) # 'Oracle in OraDB21Home1'

DB_host = 'localhost'
db_user='kuhan'
db_pwd='kuhan'
db_port = 1521
tablename='excel_data_insert'
excelfile='sample.xlsx'
driver = 'Oracle in OraDB21Home1'

df = pd.read_excel("sample.xlsx", engine='openpyxl')
print(df.to_string())

conn = pyodbc.connect("DRIVER={Oracle in OraDB21Home1};"
    "DBQ=localhost:1521/xepdb1;"
    "UID=kuhan;"
    "PWD=kuhan")
cursor = conn.cursor()
print(df.columns)

df["date"] = df["date"].apply(pd.to_datetime).dt.strftime("%Y-%m-%d")

columns = ', '.join([f'"{col}"' for col in df.columns])
print(columns)
placeholder = ', '.join(["?" for col in df.columns])
insert_query = f"insert into {tablename}({columns}) values ({placeholder})"
print(insert_query)
# insertquery =  insert into tablename ("date", "name") values (?, ?)
for _ , row in df.iterrows():
    cursor.execute(insert_query,tuple(row))
    conn.commit()
cursor.close()
conn.close()



