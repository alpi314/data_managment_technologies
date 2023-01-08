import time
from threading import Thread


def connect():
    pass

def insert(cursor, data):
    cursor.execute("INSERT INTO icd_slo (icd_sifra, slo_opis, ang_opis) VALUES (%s, %s, %s)", 
                    (data['icd_sifra'], data['slo_opis'], data['ang_opis']))

def update(cursor, data):
    cursor.execute("UPDATE icd_slo SET slo_opis=%s, ang_opis=%s WHERE icd_sifra=%s", 
                    (data['slo_opis'], data['ang_opis'], data['icd_sifra']))

def read(cursor):
    cursor.execute("SELECT * FROM icd_slo")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
    return rows

if __name__ == '__main__':
    connection = connect()

    all_data = [{'icd_sifra': 'A00', 'slo_opis': 'Otroška parotitis', 
                                    'ang_opis': 'Childhood parotitis'}, 
                {'icd_sifra': 'A01', 'slo_opis': 'Otroška difterija', 
                                    'ang_opis': 'Childhood diphtheria'},
                {'icd_sifra': 'A02', 'slo_opis': 'Otroški tetanus', 
                                    'ang_opis': 'Childhood tetanus'},]

    # simulate ditry read
    print("Dirty read:")
    with connection.cursor() as cursor:
        cursor.execute("SET GLOBAL TRANSACTION ISOLATION LEVEL READ UNCOMMITTED")
        Thread(target=insert, args=(cursor, all_data[0])).start()
        for i in range(1, 4):
            print(f"Read {i}:")
            Thread(target=read, args=(cursor,)).start()
            Thread(target=insert, args=(cursor, all_data[i])).start()
            time.sleep(1)

    # simulate non-repetable read
    print("Non-repetable read:")
    with connection.cursor() as cursor:
        cursor.execute("SET GLOBAL TRANSACTION ISOLATION LEVEL REPEATABLE READ")
        Thread(target=insert, args=(cursor, all_data[0])).start()
        for i in range(1, 4):
            print(f"Read {i}:")
            Thread(target=update, args=(cursor, all_data[0])).start()
            Thread(target=read, args=(cursor,)).start()
            time.sleep(1)

    # simulate phantom read
    print("Phantom read:")
    with connection.cursor() as cursor:
        cursor.execute("SET GLOBAL TRANSACTION ISOLATION LEVEL READ UNCOMMITTED")
        Thread(target=insert, args=(cursor, all_data[0])).start()
        for i in range(1, 4):
            print(f"Read {i}:")
            Thread(target=insert, args=(cursor, all_data[i])).start()
            Thread(target=read, args=(cursor,)).start()
            time.sleep(1)
    
    # simulate lost update
    print("Lost update:")
    with connection.cursor() as cursor:
        cursor.execute("SET GLOBAL TRANSACTION ISOLATION LEVEL READ UNCOMMITTED")
        Thread(target=insert, args=(cursor, all_data[0])).start()
        for i in range(1, 4):
            print(f"Update {i}:")
            Thread(target=update, args=(cursor, all_data[i])).start()
            time.sleep(1)
        read(cursor)
    
    connection.close()