import psycopg2
from pymongo import MongoClient

# Connect to the PostgreSQL database
conn = psycopg2.connect(
    host="hostname",
    database="database_name",
    user="username",
    password="password"
)

# Create a cursor object
cur = conn.cursor()

# Fetch data from tables
cur.execute("SELECT * FROM zavarovanec")
zavarovanec_data = cur.fetchall()

cur.execute("SELECT * FROM obravnava")
obravnava_data = cur.fetchall()

cur.execute("SELECT * FROM diagnoza")
diagnoza_data = cur.fetchall()

# Close the cursor and connection
cur.close()
conn.close()

# Connect to MongoDB
client = MongoClient("mongodb://hostname:port/")

# Select the database and collection
db = client["database_name"]
zavarovanec_collection = db["zavarovanec"]
obravnava_collection = db["obravnava"]
diagnoza_collection = db["diagnoza"]

# Insert data into MongoDB collections
zavarovanec_collection.insert_many(zavarovanec_data)
obravnava_collection.insert_many(obravnava_data)
diagnoza_collection.insert_many(diagnoza_data)

# Close the MongoDB connection
client.close()