# This module controls the database access for the API

import sqlite3
from sqlite3.dbapi2 import Error
import time

from copy import copy, deepcopy 

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
            # First I will check if the shopcode exists currently in th table ShopLogo or not
            res1 = con.execute('''SELECT * FROM ShopLogo WHERE SHOPCODE=?''', (shop_code,))
            resp_exists = []
            for u in res1:
                resp_exists.append(u)
            
            print("Response of select statement if exists -> ", resp_exists)

            if len(resp_exists) == 0:
                one = con.execute('''INSERT INTO ShopLogo(SHOPCODE, BRANDLOGOURL) VALUES(?, ?)''', (shop_code, shop_logo_url, ))
                con.commit()
                print("value inserted into shoplogo database successfully")
                con.close()
            
            # Simce The logo already exists, I will use Update instead of Insert
            else:
                print("Inside update")
                one = con.execute(f'''UPDATE ShopLogo SET BRANDLOGOURL=(?) WHERE SHOPCODE=(?)''', (shop_logo_url, shop_code, ))
                con.commit()
                print("update successful")
                con.close()
            return 1
        except Error as e:
            print(e)
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
    def fetch_deals_logo(self, shop_location):
        try:
            print("in fetch deals")
            con = sqlite3.connect('dashboard_database.db')
            cur = con.cursor()
            if shop_location == 'all':
                print("in all")
                resp = con.execute('''SELECT * FROM ShopDeals''')
                for res in resp:
                    print(res)
            else:
                location_code = self.fetch_airport_code(shop_location)
                # first I will find SHOP numbers in particular location
                shop_code_list = []
                resp1 = con.execute('''SELECT SHOPCODE FROM ShopList WHERE AIRPORTID=?''', (location_code,))
                for u in resp1:
                    shop_code_list.append(u[0])
                print("shop_code_list -> ", shop_code_list)
                final_result = []
    #             [{
    #     "name":"Shop_name","location":"Delhi","Heading":"abc","simple":"avd","photo":"https://raw.githubusercontent.com/Tech-closet/techclosetonline.github.io/main/logo_circular.png",
    # }]
                for shop_codes in shop_code_list:
                    temp_resp = {}
                    resp2 = con.execute('''SELECT * FROM ShopDeals WHERE SHOPCODE=?''', (shop_codes,))
                    for t in resp2:
                        print("shop code right now -> ", shop_codes, end="\n")
                        new_dict = deepcopy(temp_resp)
                        resp_url = con.execute('''SELECT BRANDLOGOURL FROM ShopLogo WHERE SHOPCODE = ?''', (shop_codes, ))
                        new_dict["Heading"] = t[1]
                        new_dict["simple"] = t[2]
                        for url in resp_url:
                            new_dict["photo"] = url[0]
                        resp_shop_name = con.execute('''SELECT SHOPNAME FROM ShopList WHERE SHOPCODE = ?''', (shop_codes, ))
                        for names in resp_shop_name:
                            new_dict["name"] =  names[0]
                        final_result.append(new_dict)
                print(final_result)
            con.close()
            return final_result
        except:
            print("Error occured")
            return -1


class Flights:
    def __init__(self):
        pass
    def fetch_flight_details(self, flight_number):
        try:
            con = sqlite3.connect('dashboard_database.db')
            cur = con.cursor()
            res1 = con.execute('''SELECT * FROM FlightData WHERE FLIGHTCODE = ?''', (flight_number, ))
            result = []
            for m in res1:
                for u in m:
                    result.append(u)
            if len(result) == 0:
                return -1
            else:
                print(result)
                return result
        except Error as e:
            print("Error in func -> fetch_flight_details", e)
            return -100
        
    # flight date and time will be in UNIX FORMAT
    def add_flight(self, flightcode, source, destination, flight_date_and_time):
        try:
            con = sqlite3.connect('dashboard_database.db')
            cur = con.cursor()
            res_lis = self.fetch_flight_details(flightcode)
            # print(res_lis[0])
            # this means that this flight code is new
            if res_lis == -1:
                con.execute('''INSERT INTO FlightData (FLIGHTCODE, SOURCE, DESTINATION, FLIGHT_DATE_TIME) VALUES (?, ?, ?, ?)''', (flightcode, source, destination, flight_date_and_time, ))
                con.commit()
            elif res_lis == -100:
                raise Exception
            else:
                con.execute('''UPDATE FlightData SET (FLIGHTCODE, SOURCE, DESTINATION, FLIGHT_DATE_TIME) = (?, ?, ?, ?) WHERE SNO=?''', (flightcode, source, destination, flight_date_and_time, res_lis[0], ))
                con.commit()
            con.close()
        except Error as e:
            print('Error in inserting in FlightData - > ', e)
            con.close()


class Users:
    def __init__(self):
        pass
    def create_or_fetch_user(self, email, name):
        try:
            con = sqlite3.connect('dashboard_database.db')
            cur = con.cursor()
            # first I will check if user exists or not
            # Users (ID INTEGER PRIMARY KEY AUTOINCREMENT, USERNAME TEXT, EMAIL TEXT)''')
            res1 = con.execute('''SELECT ID FROM Users WHERE (USERNAME, EMAIL) = (?, ?)''', (name, email))
            user_id = []
            for m in res1:
                for k in m:
                    user_id.append(k)
            # User does not exists
            # print(k)
            if len(user_id) == 0:
                print("user does not exists")
                res2 = con.execute('''INSERT INTO Users(Username, Email) VALUES (?, ?)''', (name, email, ))
                con.commit()
                con.close()
                self.create_or_fetch_user(email, name)
            print(user_id)
            return user_id
        except Error as e:
            print(e)
            return -1000

    # UserTrip(USERID INTEGER, FLIGHTCODE TEXT, RECORD_UPDATE INT
    def user_trip_upload(self, name, email, flightcode):
        try:
            user_id = self.create_or_fetch_user(email, name)
            if user_id == -1000:
                raise Exception
            else:
                con = sqlite3.connect('dashboard_database.db')
                cur = con.cursor()
                resp1 = con.execute('''INSERT INTO UserTrip(USERID, FLIGHTCODE, RECORD_UPDATE) VALUES (?, ?, ?)''', (user_id, flightcode, time.time()))
                con.commit()
                con.close()
                return 1
        except Error as e:
            print("error in user_trip_upload :: ---- > ", e)
            return -1
    
    # Returning all the past trips of the User (Returns FlightCode)
    def return_past_trips(self, name, email):
        try:
            user_id = self.create_or_fetch_user(email, name)
            print("user id -----------------------> ", user_id)
            if user_id == -1000:
                raise Exception
            else:
                con = sqlite3.connect('dashboard_database.db')
                cur = con.cursor()
                resp1 = con.execute('''SELECT FLIGHTCODE, RECORD_UPDATE FROM UserTrip WHERE USERID=?''', (user_id, ))
                final_resp = []
                for t in resp1:
                    new_list = deepcopy({})
                    new_list["flightcode"] = t[0]
                    new_list["timeuploaded"] = t[1]
                    final_resp.append(new_list)
                print(final_resp)
            return final_resp
        except Error as e:
            print("Error in return past trip ----   > ", e)
            return -1

            
            # res3 = con.execute('''INSERT IN)''')
            
# new_temp_user_obj = Users()
# # new_temp_user_obj.user_trip_upload('sampleemail@@sample.com', 'sample_name5', 'flight1')
# new_temp_user_obj.return_past_trips('sample_name5', 'sampleemail@@sample.com')
# # del new_temp_user_obj
# temp_obj1 = Flights()
# temp_obj1.add_flight('flight2', 'mumbai', 'delhi', '1632806539')
# temp_obj1.fetch_flight_details('flight1')

# temp_user_obj = Users()
# temp_user_obj.create_user('sample_name5', 'sampleemail@@sample.com')

# temp_obj = Shop_Data_Acccess()
# temp_obj.upload_shop_logo("https://assets.turbologo.com/blog/en/2020/01/19084716/armani-logo-cover.png", "Shop2", "Mumbai")
# temp_obj.upload_shop_deals("40% Off", "Shop2", "Mumbai", "50 % off on everything you buy")
# temp_obj.fetch_deals_logo('Delhi')

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
