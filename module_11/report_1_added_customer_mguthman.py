# CSD_310 Module 11, Purple Team
# Case Study: Willson Financial
# Groupe Members: Dylan Bonis, Robert Duvall, Melinda Guthman, Meg Kellenberger
# Title: report_1_added_customer_mguthman.py
# Author: Melinda Guthman, adapted from DBonis - Report 3
# Date: 11 December 2022
# Last Modified: 11 December 2022
# Description: Script to show all customers added for each month in the last six months 

import mysql.connector
from mysql.connector import errorcode
import datetime


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

    # Setting year var for easy year-to-year reporting
    year = 2022

    
    for month in range(1, 13, 1):
        # Makes a datetime object to reference for what month and year for display
        datemonth = datetime.datetime(year, month, 1)

        # Range is 12 months, looking for those in the last six months 
        if month > 6:
            print("\n\n-- DISPLAYING Aquired Customer RECORD FOR  {}--\n".format(datemonth.strftime("%B %Y")))
            
            # Selecting customers per month by count
            cursor.execute("SELECT count(customer_name) FROM customer where MONTH(date_added) = {}".format(month))
            count = cursor.fetchall()

            for x in count:
                print("There were {} customers added.\n".format(x[0]))

            # Selecting customer information per month
            cursor.execute("SELECT customer_name, date_added FROM customer where MONTH(date_added) = {} and YEAR(date_added) = {}".format(month,year))
            record = cursor.fetchall()

            for x in record:
                print("Customer Name: {}\nDate Added: {}\n".format(x[0], x[1]))
 
except mysql.connector.Error as err:
    if err.errno == errorcode.Er_ACCESS_DENIED_ERROR:
        print("The supplied username or password is invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("The specified database does not exist")
    else:
        print(err)

finally:

    db.close()