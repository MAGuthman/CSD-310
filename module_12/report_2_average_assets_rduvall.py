# CSD_310 Module 11, Purple Team
# Case Study: Willson Financial
# Groupe Members: Dylan Bonis, Robert Duvall, Melinda Guthman, Meg Kellenberger
# Title: report_2_average_assets_rduvall.py
# Author: Robert Duvall
# Date: 7 December 2022
# Last Modified: 18 December 2022
# Description: script to show the average amount of all assets


import locale
import mysql.connector
from mysql.connector import errorcode
from datetime import date

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
    
    # Adding date of report running
    today = date.today()
    print("\n\n-- REPORT RUN: {} --".format(today)) 

    # Get Asset Data from Assets Column in asset Table and Calculate the Average
    retrieveData = "SELECT AVG(asset_worth) AS average from asset;"    
    cursor.execute(retrieveData)
    assetAmount = cursor.fetchall()
    
    # Display Output Header
    print("\n---------------------------------------------------------")
    print("\n-- Displaying Average Amount of Assets for All Clients --")
    print("\n---------------------------------------------------------")

    # Display Formatted Output
    for i in assetAmount:
        print("\n Average Amount of Assets: \t\t" + "${:0,.2f}".format(i[0]))
   
except mysql.connector.Error as err:
    if err.errno == errorcode.Er_ACCESS_DENIED_ERROR:
        print("The supplied username or password is invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("The specified database does not exist")
    else:
        print(err)

finally:

    db.close()


