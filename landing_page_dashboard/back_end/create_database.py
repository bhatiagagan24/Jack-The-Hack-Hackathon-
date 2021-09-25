import sqlite3


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


obj1 = Create_Database()
obj1.create_table()
    


