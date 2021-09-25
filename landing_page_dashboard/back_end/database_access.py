# This module controls the database access for the API

import sqlite3
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