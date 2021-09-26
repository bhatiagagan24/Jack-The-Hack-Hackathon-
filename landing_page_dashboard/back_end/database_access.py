# This module controls the database access for the API

import sqlite3
from sqlite3.dbapi2 import Error
import time

class DatabaseConnect:
    def __init__(self, db_name):
        self.database_name = db_name


# fetches last 5 image info based upon the time stamp
class Fetch_Image_Info:
    def __init__(self, rows_required):
        self.rows_required = rows_required
        self.__result = []
    # Users have the flexibility to choose no of images to serve
    def fetching_the_result(self):
        con = sqlite3.connect('dashboard_database.db')
        cur = con.cursor()
        # select last 5 rows based upon the descending sort
        fetch_res = con.execute(f'''SELECT ID, PHOTONAME, CREATETIME from DataDashboard ORDER BY ID DESC LIMIT {self.rows_required}''')
        for res in fetch_res:
            self.__result.append(
                {
                'imageName': res[1],
                'id': res[0],
                }
                )
        con.close()
        return self.__result

class Image_Info_Insert:
    def __init__(self, image_name):
        self.image_name = image_name
        # self.__uploading_image()
        # current unix time
        self.current_time = str(time.time())
        # self.current_time = "100"
        print("constructor used properly")
    def uploading_image(self):
        con = sqlite3.connect('dashboard_database.db')
        cur = con.cursor()
        print("table connected properly")
        try:
            con.execute('''INSERT INTO DataDashboard(PHOTONAME, CREATETIME) VALUES (?, ?)''', (self.image_name, self.current_time, ))
            con.commit()
            con.close()
            print('Value uploaded successfully')
            return 1
        except:
            print('error in inserting the value in table')
            return -1

class Airport_Data_Access:
    # Normal constructor for fetching list of all airports
    def __init__(self):
        # return self.__fetch_airport_list()
        pass
    # Argument constructor for fetching deals wrt to airport
    def fetch_airport_list(self):
        # print("Inside Function")
        try:
            con = sqlite3.connect('dashboard_database.db')
            cur = con.cursor()
            # one = con.execute("INSERT INTO AirportList VALUES(1, 'Delhi')")
            # con.commit()
            results = con.execute('''SELECT * FROM AirportList''')
            final_res = []
            for res in results:
                final_res.append([res[0], res[1]])
            return final_res
        except:
            print("error occured")
            return -1
    def create_new_airport(self, airport_name):
        try:
            con = sqlite3.connect('dashboard_database.db')
            cur = con.cursor()
            one = con.execute(f"INSERT INTO AirportList(AIRPORTNAME) VALUES(?)", (airport_name, ))
            con.commit()
            con.close()
            return 1
        except:
            print("error while creating an airport")
            return -1
    def fetch_airport_code(self, airport_name):
        try:
            con = sqlite3.connect('dashboard_database.db')
            cur = con.cursor()
            one = con.execute('''SELECT ID FROM AirportList WHERE AIRPORTNAME=?''', (airport_name,))
            resp = 0
            for m in one:
                resp = m[0]
            print(resp)
            con.close()
            return resp
        except:
            print("error occured while fetching the result")
    def create_new_shop(self, airport_name, shop_name):
        try:
            airport_code = self.fetch_airport_code(airport_name)
            con = sqlite3.connect('dashboard_database.db')
            cur = con.cursor()
            one = con.execute(f"INSERT INTO ShopList (SHOPNAME, AIRPORTID) VALUES (?, ?)",(shop_name, airport_code, ))
            con.commit()
            con.close()
            return 1
        except:
            print("error occured while creating new shop")
            return -1


class Shop_Data_Acccess(Airport_Data_Access):
    def __init__(self):
        pass

    def fetch_shop_code(self, shop_name, airport_name):
        try:
            airport_code = self.fetch_airport_code(airport_name)
            print('airport code -> ', airport_code)
            con = sqlite3.connect('dashboard_database.db')
            cur = con.cursor()
            one = con.execute('''SELECT SHOPCODE FROM ShopList WHERE (SHOPNAME,AIRPORTID)=(?,?)''',(shop_name, airport_code, ))
            print(one)
            shop_code = -1
            for m in one:
                shop_code = m[0]
                print(m)
            print('In fetch_shope code:: shop_code ->', shop_code)
            con.close()
            return shop_code
        except:
            con.close()
            return -1

    def upload_shop_logo(self, shop_logo_url, shop_name, airport_name):
        # first I need to fetch the airport ID from table airportlist using fetch_airport_code from
        # class Airport_Data_Access
        try:
            shop_code = self.fetch_shop_code(shop_name, airport_name)
            if shop_code == -1:
                print("Raising Exception")
                raise Exception
            print("shop code -> ", shop_code)
            # ShopLogo (SHOPCODE INT, BRANDLOGOURL TEXT
            con = sqlite3.connect('dashboard_database.db')
            cur = con.cursor()
            one = con.execute('''INSERT INTO ShopLogo(SHOPCODE, BRANDLOGOURL) VALUES(?, ?)''', (shop_code, shop_logo_url, ))
            con.commit()
            print("value inserted into shoplogo database successfully")
            con.close()
            return 1
        except:
            print("brand logo insert fail")
            return -1

    # CREATE TABLE IF NOT EXISTS ShopDeals (SHOPCODE INT, HEADING TEXT, DEALDESCRIPTION TEXT)
    def upload_shop_deals(self, heading, shop_name, shop_location, deal_desctiption):
        try:
            shop_code = self.fetch_shop_code(shop_name, shop_location)
            if shop_code == -1:
                print("shop does not exists")
                raise Exception
            con = sqlite3.connect('dashboard_database.db')
            cur = con.cursor()
            # one = con.execute('''INSERT INTO ShopDeals(SHOPCODE, HEADING, DEALDESCRIPTION) VALUES (?, ?, ?) ON CONFLICT (SHOPCODE) DO UPDATE SET SHOPCODE=excluded.SHOPCODE''', (shop_code, heading, deal_desctiption))
            one = con.execute('''SELECT * FROM ShopDeals WHERE SHOPCODE=?''', (shop_code, ))
            print("one -> ", one)
            rows = []
            for u in one:
                rows.append(u)
            print(rows)
            # con.close()
            # if rows are None I will straightaway insert in DB
            if len(rows) == 0:
                print("Inside insert")
                one = con.execute('''INSERT INTO ShopDeals(SHOPCODE, HEADING, DEALDESCRIPTION) VALUES (?, ?, ?)''', (shop_code, heading, deal_desctiption))
                con.commit()
                print("Insert into DB successfully")
            else:
                # con = sqlite3.connect('dashboard_database.db')
                # print("inside update")
                one = con.execute('''DELETE FROM ShopDeals WHERE SHOPCODE=?''', (shop_code,))
                con.commit()
                two = con.execute('''INSERT INTO ShopDeals(SHOPCODE, HEADING, DEALDESCRIPTION) VALUES (?, ?, ?)''', (shop_code, heading, deal_desctiption))
                con.commit()
                print("updated in DB Successfully")
                # con.close()
            # con.commit()
            con.close()
            # print("Inserted into the database successfully")
            return 1
        except Error as e:
            print(e)
            print("error in uploading shop details")
            return -1
    
    # Function to Fetch Deals, Logo of Shop if it's Location is given to us
    # def fetch_deals_logo(self, shop_location):
    #     try:
    #         location_code = self.fetch_airport_code(shop_location)






temp_obj = Shop_Data_Acccess()
# temp_obj.upload_shop_logo("google1.com", "Shop2", "Mumbai")
temp_obj.upload_shop_deals("40% Off", "Shop1", "Delhi", "50 % off on everything you buy")

# temp_obj = Airport_Data_Access()
# temp_obj.create_new_shop('Delhi', 'Shop1')


# an example of how to fetch information from the table DataDashboard
# 5 represents the number of rows I need
# '''

# obj1 = Fetch_Image_Info(5)
# final_res = obj1.fetching_the_result()
# print(final_res)

# '''

# Testing the class Image_info_insert here

# obj1 = Image_Info_Insert("img_temp1")
# res = obj1.uploading_image()

# obj1 = Airport_Data_Access()
# obj1.fetch_airport_list()
