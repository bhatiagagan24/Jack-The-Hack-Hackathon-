import sqlite3
from sqlite3.dbapi2 import Error
import time

# SQLite has been initially used

# class for creating the database

class Create_Database:
    def __init__(self):
        self.db_name = "image_db"
        print("The name of the table is image_db")
        # unixtime is stored as TEXT. It will be typecasted to long integer in the code.
        print("It's schema is ID Auto_increment, Photo_name TEXT, unixtime TEXT")
    def create_table(self):
        try:
            con = sqlite3.connect('dashboard_database.db')
            con.execute('''CREATE TABLE IF NOT EXISTS DataDashboard (ID INTEGER PRIMARY KEY AUTOINCREMENT, PHOTONAME TEXT NOT NULL, CREATETIME TEXT NOT NULL)''')
            con.close()
            print('table created successfully')
        except:
            print('error in creating database')
            return -1
    def create_table_airport(self):
        try:
            con = sqlite3.connect('dashboard_database.db')
            con.execute('''CREATE TABLE IF NOT EXISTS AirportList (ID INTEGER PRIMARY KEY AUTOINCREMENT, AIRPORTNAME TEXT NOT NULL)''')
            con.close()
            print("airportlist table created successfully")
        except:
            print("error in creating airportlist table")
            return -1
    
    def create_airport_shop_database(self):
        try:
            con = sqlite3.connect('dashboard_database.db')
            con.execute('''CREATE TABLE IF NOT EXISTS ShopList (SHOPNAME TEXT, AIRPORTID INT, SHOPCODE INTEGER PRIMARY KEY AUTOINCREMENT)''')
            con.close()
            print("ShopList Database Created Successfully")
        except:
            print("error in creating database ShopList")
    def create_shop_logo_database(self):
        try:
            con = sqlite3.connect('dashboard_database.db')
            con.execute('''CREATE TABLE IF NOT EXISTS ShopLogo (SHOPCODE INT, BRANDLOGOURL TEXT)''')
            con.close()
            print("ShopLogo Database Created Successfully")
        except:
            print("error in creating database ShopList")
    def shop_login_credentials(self):
        try:
            con = sqlite3.connect('dashboard_database.db')
            con.execute('''CREATE TABLE IF NOT EXISTS ShopCredentials (SHOPCODE INT, KEY TEXT)''')
            con.close()
            print("ShopCredentials Database Created Successfully")
        except:
            print("error in creating database ShopList")
    def shop_deals_database(self):
        try:
            con = sqlite3.connect('dashboard_database.db')
            con.execute('''CREATE TABLE IF NOT EXISTS ShopDeals (SHOPCODE INT, HEADING TEXT, DEALDESCRIPTION TEXT)''')
            con.close()
            print("ShopDeals Database Created Successfully")
        except:
            print("error in creating database ShopList")
    
    def user_database(self):
        try:
            con = sqlite3.connect('dashboard_database.db')
            con.execute('''CREATE TABLE IF NOT EXISTS Users (ID INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT, EMAIL TEXT)''')
            con.close()
            print("user table with fields userid, name, email created")
        except Error as e:
            print("error occured while creating table Users ----> ", e)
    def user_trip_data(self):
        try:
            con = sqlite3.connect('dashboard_database.db')
            # Time stored as INT(UNIXTIME) -> INT(time.time())
            con.execute('''CREATE TABLE IF NOT EXISTS UserTrip(USERID INTEGER, FLIGHTCODE TEXT, RECORD_UPDATE INT)''')
            # con.execute('''ALTER TABLE UserTrip DROP COLUMN DESTINATION''')
            con.close()
            print("Table UserTrip created")
        except Error as e:
            print("Error in creating table UserTrip --------> ", e)
    def flight_data(self):
        try:
            con = sqlite3.connect('dashboard_database.db')
            con.execute('''CREATE TABLE IF NOT EXISTS FlightData (SNO INTEGER PRIMARY KEY AUTOINCREMENT, FLIGHTCODE TEXT, SOURCE TEXT, DESTINATION TEXT, FLIGHT_DATE_TIME INT)''')
            con.close()
            print("FlightData created successfully")
        except Error as e:
            print("Error while creating FlightData -----------------> ", e)

    def lounge_data(self):
        try:
            con = sqlite3.connect('dashboard_database.db')
            con.execute('''CREATE TABLE IF NOT EXISTS LoungeData (LOUNGECODE INTEGER PRIMARY KEY AUTOINCREMENT, AIRPORTCODE INT, LOUNGENAME TEXT)''')
            con.close()
        except Error as e:
            print("Error while creating LoungeData -------------------> ", e)
    
    def lounge_food(self):
        try:
            con = sqlite3.connect('dashboard_database.db')
            con.execute('''CREATE TABLE IF NOT EXISTS LoungeFood (LOUNGECODE INTEGER, FOOD TEXT)''')
            con.close()
        except Error as e:
            print("The table loungefood not created due to following error ----------> ", e)

    def assistance_database(self):
        try:
            con = sqlite3.connect('dashboard_database.db')
            con.execute('''CREATE TABLE IF NOT EXISTS AssistData (USERCODE INT, SERVICE TEXT, TIMEREQUESTED INT, CURRENTSTATUS INT, AIRPORTCODE INT)''')
            con.close()
            print("assistance_database executed well")
        except Error as e:
            print("Error in assistance_database ---------------->  ", e)
    
    def lounge_requests(self):
        try:
            con = sqlite3.connect('dashboard_database.db')
            # ACCESSGIVEN IS 0 IF ACCESS NOT GIVEN. IT IS 1 IF ACCESS GIVEN
            # REQUESTTIME IS UNIX TIME
            con.execute('''CREATE TABLE IF NOT EXISTS LoungeRequests (USERCODE INT, LOUNGECODE INT, ACCESSGIVEN INT, REQUESTTIME INT)''')
            con.close()
            print("Table LoungeRequests created ")
        except Error as e:
            print("Error in lounge_requests ----------> ", e)
    def payment_tables(self):
        try:
            con = sqlite3.connect('dashboard_database.db')
            con.execute('''CREATE TABLE IF NOT EXISTS PaymentTable (USERCODE INT, CARDNUMBER INT)''')
            con.close()
            print("table PaymentTable created")
        except Error as e:
            print("error -> ", e)


# obj1 = Create_Database()
# obj1.payment_tables()

# con = sqlite3.connect('dashboard_database.db')
# con.execute('DROP TABLE LoungeRequests')

# obj1 = Create_Database()
# obj1.create_table()
    

obj2 = Create_Database()
obj2.create_table_airport()
obj2.user_database()
obj2.user_trip_data()
obj2.flight_data()
obj2.create_shop_logo_database()
obj2.shop_login_credentials()
obj2.shop_deals_database()
obj2.create_table()
obj2.create_airport_shop_database()
obj2.lounge_data()
obj2.lounge_food()
obj2.assistance_database()
obj2.lounge_requests()
obj2.payment_tables()





# def funct_to_delete_rows():
#     try:
#         con = sqlite3.connect('dashboard_database.db')
#         for m in range(9023, 9090):
#             con.execute('''DELETE FROM Users WHERE ID=?''', (m, ))
#             con.commit()
#     except Error as e:
#         print(e)

# funct_to_delete_rows()    


