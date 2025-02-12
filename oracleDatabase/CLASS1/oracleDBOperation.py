# import cx_Oracle

#  Microsoft Visual C++ 14.0 or greater

import pyodbc

print(pyodbc.drivers()) 

conn_str = (
    "DRIVER={Oracle in OraDB21Home1};"
    "DBQ=localhost:1521/xepdb1;"
    "UID=login360;"
    "PWD=login360"
)
connection = pyodbc.connect(conn_str)

 # Check available drivers


try:
    # Establish connection
    connection = pyodbc.connect(conn_str)
    print("Connected to Oracle Database")

    # Create a cursor
    cursor = connection.cursor()

    # Execute a test query
    cursor.execute("SELECT * FROM customer")
    for row in cursor.fetchall():
        print(row)

    # Close the connection
    cursor.close()
    connection.close()

except pyodbc.Error as e:
    print("Error:", e)
