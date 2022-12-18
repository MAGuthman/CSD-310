# CSD_310 Module 11, Purple Team
# Case Study: Willson Financial
# Groupe Members: Dylan Bonis, Robert Duvall, Melinda Guthman, Meg Kellenberger
# Title: report_3_high_transactions_dbonis.py
# Author: Dylan Bonis
# Date: 7 December 2022
# Last Modified: 18 December 2022
# Description: Script to find out how many clients have a high number (>10) of transactions?


import mysql.connector
from mysql.connector import errorcode
import datetime
from datetime import date


config = {
    "user": "willson_owner",
    "password": "finances",
    "host": "127.0.0.1",
    # "port": "3006", #change this to port number 3306, or remove entirely depending on user.
    "database": "willson_financial",
    "raise_on_warnings": True
}

try:
    #Connects to the databse and makes cursor
    db = mysql.connector.connect(**config)
    cursor = db.cursor()

    print("\n Database user {} connected to MySQL on host {} with databse {}".format(config["user"], config["host"], config["database"]))
    input("\n\n Press any key to continue...")  

    # Adding date of report running
    today = date.today()
    print("\n\n-- REPORT RUN: {} --".format(today))   

    year = 2022 #Change to select what year records are from (Though in this example it's only 2022)

    for month in range(1, 13, 1):
        #Makes a datetime object to reference for what month and year for display
        datemonth = datetime.datetime(year, month, 1)

        #Selects the transaction history for each customer in a month, in this case, 1.
        cursor.execute("select customer.customer_name, count(transactions.customer_id) AS Count "
                        "FROM transactions INNER JOIN customer ON transactions.customer_id=customer.customer_id "
                        "WHERE MONTH(transaction_date)= {} AND YEAR(transaction_date)={}  "
                        "GROUP BY customer_name".format(month, year))

        #Gathers all information from query into a list
        transactions = cursor.fetchall()

        #Prints Display for Each month
        print("-- DISPLAYING transaction RECORDS >10 FOR  {}--\n".format(datemonth.strftime("%B %Y")))

        #If it's not zero, try to iterate through the list
        if transactions.__len__() > 0:
            #For each customer who had transactions in given month, if they had more than 10 transactions display it, else dont.
            for customer in transactions:
                if customer[1] > 10:
                    print("Customer Name: {}\nTransactions Made: {}\n".format(customer[0], customer[1]))

        #Clears the list and resets the cursor for a fresh start to each
        transactions.clear()
        cursor.reset()

#Given an error happens, catch it, print results
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")

    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print(" The specified database does not exist")

    else:
        print(err)

#Attempt to close the database no matter what
finally:
    db.close()