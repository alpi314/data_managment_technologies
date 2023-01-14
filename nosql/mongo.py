from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient("mongodb://hostname:port/")

# Select the database and collection
db = client["database_name"]
zavarovanec_collection = db["zavarovanec"]
obravnava_collection = db["obravnava"]
diagnoza_collection = db["diagnoza"]

# Perform the query and sort the results by cas_zacetka
results = obravnava_collection.aggregate([
    {
        "$lookup": {
            "from": "zavarovanec",
            "localField": "kzzs",
            "foreignField": "kzzs",
            "as": "zavarovanec_data"
        }
    },
    {
        "$lookup": {
            "from": "diagnoza",
            "localField": "st_obravnave",
            "foreignField": "st_obravnave",
            "as": "diagnoza_data"
        }
    },
    {
        "$unwind":"$zavarovanec_data"
    },
    {
        "$unwind":"$diagnoza_data"
    },
    {"$sort": {"cas_zacetka": -1}},
    {"$project": {
        "kzzs":"$zavarovanec_data.kzzs",
        "slovensko_ime":
        "$diagnoza_data.slovensko_ime"}}
])

# Print the results
for row in results:
    print(row)

# Close the MongoDB connection
client.close()