import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "movies_user",
    "password": "popcorn",
    "host": "localhost",
    "database": "movies",
    "raise_on_warnings": True
}

try:
    db = mysql.connector.connect(**config)
    cursor = db.cursor()

    print("\n Database user {} connected to MySQL on host {} with databse {}".format(config["user"], config["host"], config["database"]))
    input("\n\n Press any key to continue...")

    first = "SELECT * FROM studio" # Query selecting all fields for studio table
    second = "SELECT * FROM genre" # Query selecting all fields for genre table
    third = "SELECT film_name, film_runtime FROM film WHERE film_runtime < 120 " # Query selecting movie names for movies with a run time less than 2 hours
    forth = "SELECT film_name, film_director FROM film ORDER BY film_director" # Query selecting film names and directors, grouped/ordered by director 



    print("\n-- DISPLAYING Studio RECORDS --") # Running query 1
    cursor.execute(first)
    record = cursor.fetchall() 
    for x in record: 
        print("Studio ID: {}\nStudio Name: {}\n".format(x[0], x[1]))

    print("\n-- DISPLAYING Genre RECORDS --") # Runing query 2
    cursor.execute(second)  
    record = cursor.fetchall() 
    for x in record: 
        print("Genre ID: {}\nGenre Name: {}\n".format(x[0], x[1]))

    print("\n-- DISPLAYING Short Film RECORDS --") # Running query 3
    cursor.execute(third)
    record = cursor.fetchall() 
    for x in record:
        print("Film Name: {}\nRuntime: {}\n".format(x[0],x[1]))

    print("\n-- DISPLAYING Director RECORDS in Order --") # Running query 4
    cursor.execute(forth)
    record = cursor.fetchall() 
    for x in record:
        print("Film Name: {}\nDirector: {}\n".format(x[0],x[1]))

except mysql.connector.Error as err:
    if err.errno == errorcode.Er_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print(" The specified database does not exist")
    else:
        print(err)

finally:

    db.close()


