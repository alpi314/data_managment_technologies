import psycopg2

# Connect to the database
conn = psycopg2.connect(
    host="hostname",
    database="database_name",
    user="username",
    password="password"
)

# Create a cursor object
cur = conn.cursor()

# Execute the query
query = """
SELECT zavarovanec.kzzs, diagnoza.slovensko_ime
FROM zavarovanec
LEFT JOIN obravnava ON zavarovanec.kzzs = obravnava.kzzs
LEFT JOIN diagnoza ON obravnava.st_obravnave = diagnoza.st_obravnave
ORDER BY obravnava.cas_zacetka DESC;
"""
cur.execute(query)

# Fetch and print the results
results = cur.fetchall()
for row in results:
    print(row)

# Close the cursor and connection
cur.close()
conn.close()