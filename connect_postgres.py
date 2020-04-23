#!/bin/python3

import psycopg2

conn = psycopg2.connect(database="dbname",
                        user="dbuser",
                        password="dbpass",
                        host="localhost",
                        port="5432")

print("Opened database successfully")

cur = conn.cursor()
cur.execute('''CREATE TABLE TEST_TO
       (ID INT PRIMARY KEY     NOT NULL,
        JOUR           TEXT    NOT NULL);''')

conn.commit()
conn.close()

print("Table created successfully")
