# CSD_310 Module 10, Purple Team
# Case Study: Willson Financial
# Groupe Members: Dylan Bonis, Robert Duvall, Melinda Guthman, Meg Kellenberger
# Title: db_display_mguthman.py
# Author: Melinda Guthman
# Date: 4 December 2022
# Description: willson_financial python script for displaying database content


import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "willson_owner",
    "password": "finances",
    "host": "localhost",
    "database": "willson_financial",
    "raise_on_warnings": True
}

try:
    db = mysql.connector.connect(**config)
    cursor = db.cursor()

    print("\n Database user {} connected to MySQL on host {} with databse {}".format(config["user"], config["host"], config["database"]))
    input("\n\n Press any key to continue...")

    # Queries selecting all from tables within DB to display
    employee = "SELECT * FROM employee" 
    job = "SELECT * FROM job" 
    functions = "SELECT * FROM functions"
    customer = "SELECT * FROM customer" 
    asset = "SELECT customer_id, asset_id, asset_name, asset_worth FROM asset"
    transactions = """SELECT transactions.customer_id, customer_name, transaction_id, transaction_date, transaction_with_id, function_name, transaction_amount FROM transactions
     INNER JOIN customer on customer.customer_id = transactions.customer_id INNER JOIN functions on functions.function_id = transactions.function_id ORDER BY transaction_id;"""

    # Displaying Employee Table
    print("\n-- DISPLAYING Employee RECORDS --") 
    cursor.execute(employee)
    record = cursor.fetchall() 
    for x in record: 
        print("Employee ID: {}\nEmployee Name: {}\nEmployee Address: {}\nEmployee Phone: {}\n".format(x[0], x[1],x[2],x[3]))

    # Displaying Job Table
    print("\n-- DISPLAYING Job RECORDS --") 
    cursor.execute(job)  
    record = cursor.fetchall() 
    for x in record: 
        print("Job ID: {}\nJob Name: {}\nHours: {}\n".format(x[0], x[1],x[2]))

    # Displaying Function Table
    print("\n-- DISPLAYING Function RECORDS --") 
    cursor.execute(functions)
    record = cursor.fetchall() 
    for x in record:
        print("Function ID: {}\nFunction Name: {}\n".format(x[0],x[1]))

    # Displaying Customer Table
    print("\n-- DISPLAYING Customer RECORDS --") 
    cursor.execute(customer)
    record = cursor.fetchall() 
    for x in record:
        print("Customer ID: {}\nCustomer Name: {}\nCustomer Address: {}\nCustomer Phone: {}\nDate Added: {}\n".format(x[0],x[1],x[2],x[3],x[4]))

    # Displaying Assest Table
    print("\n-- DISPLAYING Asset RECORDS --")
    cursor.execute(asset)
    record = cursor.fetchall() 
    for x in record:
        print("Customer ID: {}\nAsset ID: {}\nAsset Name: {}\nAssest Worth: {:.{prec}f}\n".format(x[0],x[1],x[2],x[3], prec=2))


    # Display Transaction Table
    print("\n-- DISPLAYING Transaction RECORDS --")
    cursor.execute(transactions)
    record = cursor.fetchall() 
    for x in record:
        print("Customer ID: {}\nCustomer Name: {}\nTransaction ID: {}\nTransaction Date: {}\nTransaction With ID: {}\nFunction: {}\nTransaction Amount: {:.{prec}f}\n".format(x[0],x[1],x[2],x[3],x[4],x[5],x[6],prec=2))

except mysql.connector.Error as err:
    if err.errno == errorcode.Er_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print(" The specified database does not exist")
    else:
        print(err)

finally:

    db.close()


