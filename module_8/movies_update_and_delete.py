import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "movies_user",
    "password": "popcorn",
    "host": "localhost",
    "database": "movies",
    "raise_on_warnings": True
}

# Defining function for output 
def show_films(cursor, title):
    cursor.execute("""SELECT film_name as Name, film_director as Direcotr, genre_name as Genre, studio_name as 'Studio Name' 
    from film INNER JOIN genre ON film.genre_id=genre.genre_id INNER JOIN studio on film.studio_id=studio.studio_id ORDER BY film.film_id""")

    record = cursor.fetchall()

    print("\n -- {} --".format(title))

    for x in record:
        print("Film Name: {}\nDirector: {}\nGenre Name ID: {}\nStudio Name: {}\n".format(x[0], x[1], x[2], x[3]))



try:
    db = mysql.connector.connect(**config)
    cursor = db.cursor()

    print("\n Database user {} connected to MySQL on host {} with databse {}".format(
        config["user"], config["host"], config["database"]))
    input("\n\n Press any key to continue...")

    # Displaying inital films
    show_films(cursor,"DISPLAYING FILMS")

    # Insert and display
    cursor.execute("""INSERT INTO film (film_name, film_releaseDate, film_runtime, film_director, studio_id, genre_id)
            VALUES ('Jaws', '1975', '130', 'Steven Spielberg', '3', '1')""")
    show_films(cursor,"DISPLAYING FILMS AFTER INSERT")

    # Update and display
    cursor.execute("UPDATE film SET genre_id = 1 WHERE film_name = 'Alien'")
    show_films(cursor,"DISPLAYING FILMS AFTER UPDATE- Changed Alien to Horror")

    # # Delete and display
    cursor.execute("DELETE FROM film where film_name = 'Gladiator'")
    show_films(cursor,"DISPLAYING FILM AFTER DELETE")

    # Committing to Database to 'save' results 
    db.commit()

except mysql.connector.Error as err:
    if err.errno == errorcode.Er_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print(" The specified database does not exist")
    else:
        print(err)

finally:
    db.close()


