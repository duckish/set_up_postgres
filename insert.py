#!/usr/bin/python3

import psycopg2

conn = psycopg2.connect(database="dbname",
                        user="dbuser",
                        password="dbpass",
                        host="localhost",
                        port="5432")

print("Opened database successfully")

cur = conn.cursor()

postgres_insert_query = """ INSERT INTO TEST_TO (ID, JOUR) VALUES (%s,%s)"""
record_to_insert = (5, 'One Plus 6')
cur.execute(postgres_insert_query, record_to_insert)

conn.commit()
count = cur.rowcount
print (count, "Record inserted successfully into mobile table")

conn.close()
