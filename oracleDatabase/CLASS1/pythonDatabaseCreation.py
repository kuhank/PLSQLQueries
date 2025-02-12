import sqlite3
import pandas as pd


def create_connect_db():
    conn = sqlite3.connect('temp.db')

    cursor = conn.cursor()

    cursor.execute('''
                create table if not exists employee (name varchar(100), 
                employeeid int primary key, 
                employeeEmail varchar(200)
                )
                ''')
    conn.commit()
    conn.close()
    print("Database is created")

def insert_data():
    conn = sqlite3.connect('temp.db')
    cursor = conn.cursor()
    cursor.execute('''
                   insert into employee values ('Ram', 123, 'ram@gmail.com'),
                   ('kishore', 234, 'kishore@gmail.com')
                   ''')
    conn.commit()
    conn.close()
    print("Inserted 2 rows")

def retrieve_data():
    conn = sqlite3.connect('temp.db')
    cursor = conn.cursor()
    cursor.execute('''
                   select * from employee
                   ''')
    rows = cursor.fetchall()
    df = pd.DataFrame(rows)
    # print(type(rows)) # list

    print("Print as dataframe")
    print("\n=========\n")
    print(df)
    print("\n=========\n")

    for row in rows:
        print(row)
        # print(type(row)) # tuple
    conn.commit()
    conn.close()
    print("Fetched all rows")

if __name__ == "__main__":
    #create_connect_db()
    #insert_data()
    retrieve_data()


