from ntpath import join
from sqlite3.dbapi2 import Error
from flask import Flask, send_file, redirect, abort
from pathlib import Path
import json
import os 
from os.path import join, dirname, realpath
from flask.globals import request
import database_access
from werkzeug.serving import WSGIRequestHandler
# import 

# config.py stores password for mongoDB
import config

app = Flask(__name__)

FILE_PATH = join(dirname(realpath(__file__)), 'images')


@app.route('/', methods=['GET'])
def dashboard_home():
    return "yo"



# route for uploading the the photos. Accessible only with POST
@app.route('/upload', methods=['POST'])
def upload_photo():
    # the name of the file in the form will be __file_to_be_uploaded
    try:
        __file_to_be_uploaded = request.files['__file_to_be_uploaded']
        file_name = __file_to_be_uploaded.filename
        print(file_name)
        try:
            __file_to_be_uploaded.save(os.path.join(FILE_PATH, file_name))
        except:
            print("error while svaing file")
        # try except for uploading information to SQLite database
        try:
            db_upload_object = database_access.Image_Info_Insert(file_name)
            db_upload_response = db_upload_object.uploading_image()
            del db_upload_object
            if db_upload_response == 1:
                return json.dumps("File uploaded successfully and DB updated successfully")
            else:
                return json.dumps("error in script database_access as exception was encountered there")
        except:
            return json.dumps("error while inserting in the table")
        return json.dumps("file successfully uploaded")
    except:
        return json.dumps("An error occured while uploading the file")
    return "This return statement shouldn't have been accessed. Possible Error"



# route for seving the url of the photos. Accessible only with GET request. 
# Route will be used by the mobile app
@app.route('/urlfetch/getlinks', methods=['GET'])
def serve_url():
    # 5 specified here because I am returning only 5 images.
    # There willl be option to send more images
    obj1 = database_access.Fetch_Image_Info(5)
    final_res = obj1.fetching_the_result()
    del obj1
    return json.dumps(final_res)
    # pass



# serves the image when URL is called
# image_tag is the name of the image and the image_tag is served
@app.route('/static/media/<image_tag>', methods=['GET'])
def serve_image(image_tag):
    # first I have to check if the image exists
    __exists = os.path.isfile(f'{Path(__file__).parent.absolute()}\\images\\{image_tag}')
    # if __exists:
        # print("exists")
    if __exists:
        return send_file((f'{Path(__file__).parent.absolute()}\\images\\{image_tag}'), mimetype='image/gif')
        # return "image sent here"
    else:
        return abort(404)





# route to fetch all the airport data
@app.route('/airports/get', methods=['GET'])
def get_airports():
    airport_res_object = database_access.Airport_Data_Access()
    airport_res = airport_res_object.fetch_airport_list()
    # print(airport_res)
    del airport_res_object
    return json.dumps(airport_res)


# route to add an airport
@app.route('/airports/add', methods=['GET'])
def add_airport():
    new_airport_name = request.args.get('name')
    airport_res_object = database_access.Airport_Data_Access()
    airport_add_res = airport_res_object.create_new_airport(new_airport_name)
    del airport_res_object
    if airport_add_res == 1:
        print("successfully added")
        return json.dumps("1")
    else:
        print("add attempt unsuccessful")
        return json.dumps("-1")

    # pass
@app.route('/deals/shopping', methods=['GET'])
def return_deals():
    try:
        airport_name = request.args.get('airport')
        if airport_name == 'All':
            print("No argument passed")
            obj1 = database_access.Shop_Data_Acccess()
            res = obj1.fetch_deals_logo('all')
            print(res)
            if res == -1:
                raise Exception
            else:
                del obj1
                return json.dumps(res)
        else:
            print("airport name -> ", airport_name)
            obj1 = database_access.Shop_Data_Acccess()
            res = obj1.fetch_deals_logo(airport_name)
            if res == -1:
                raise Exception
            else:
                del obj1
                return json.dumps(res)
    except Error as e:
        return json.dumps("Error")


# route to add the details of the user
@app.route('/user/add/info')
def add_user():
    try:
        user_name = request.args.get('username')
        user_email = request.args.get('email')
        print("username ------->  ", user_name)
        print("user_email -------------> ", user_email)
        adding_users_obj = database_access.Users()
        final_resp_from_obj = adding_users_obj.create_or_fetch_user(user_email, user_name)
        if final_resp_from_obj == -1000:
            raise Exception
        print(f"user_name -> {user_name} :: user_email -> {user_email}")
        del final_resp_from_obj
        return "1"
    except Error as e:
        print("error --------------------------> ", e)
        del adding_users_obj
        print("error here")
        return json.dumps("Error in registering the user on the platform")


# route to add trip of the user
@app.route('/user/add/trip')
def add_trip():
    try:
        user_name = request.args.get('username')
        user_email = request.args.get('email')
        flight_code = request.args.get('flightcode')
        add_trip_obj = database_access.Users()
        final_resp_from_obj = add_trip_obj.user_trip_upload(user_name, user_email, flight_code)
        del add_trip_obj
        if final_resp_from_obj == -1:
            raise Exception
        else:
            return json.dumps("Uploaded Successfully")
    except:
        del add_trip_obj
        return json.dumps("Error in adding the trip")



# route returns the past trips
@app.route('/user/info/fetch')
def fetch_all_users():
    try:
        user_name = request.args.get('username')
        user_email = request.args.get('email')
        print("username ------------------------------>       ", user_name)
        obj1 = database_access.Users()
        final_response = obj1.return_past_trips(user_name, user_email)
        if final_response == -1:
            # del obj1
            raise Exception
        else:
            # del obj1
            return json.dumps(final_response)
    except Error as e:
        # del obj1
        print("error fetched ----> ", e)
        return json.dumps("ERROR IN FETCHING PAST TRIP DATA FROM SOURCE")



@app.route('/lounge/fetch', methods=['GET'])
def return_lounge():
    try:
        airport_name = request.args.get('airport')
        obj1 = database_access.Airport_Data_Access()
        res = obj1.fetch_lounge(airport_name)
        if res == -1:
            raise Exception
        del obj1
        return json.dumps(res)
    except Error as e:
        print('Error in route /lounge/fetch -----------> ', e)
        return json.dumps("Error while returning Lounge")


@app.route('/food/fetch', methods=['GET'])
def return_lounge_food():
    try:
        lounge_name = request.args.get('loungename')
        obj1 = database_access.Airport_Data_Access()
        res = obj1.fetch_food(lounge_name)
        if res == -1:
            raise Exception
        else:
            return json.dumps(res)
    except Error as e:
        print("Error while fetching food /food/fetch   -----------> ", e)
        return json.dumps("Error while fetching food")


@app.route('/assistance/request', methods=['GET'])
def make_assistance_request():
    try:
        # service, airport_name, user_name, user_email
        services = request.args.get('service')
        airport_name = request.args.get('airportname')
        user_name = request.args.get('username')
        user_email = request.args.get('email')
        obj1 = database_access.Assistance()
        request_obj_return_exp = obj1.request_assistance()
        if request_obj_return_exp == -1:
            raise Exception
        else:
            return json.dumps("1")
    except Error as e:
        print("Error in assistance request ----------> ", e)
        return json.dumps("Error in making assistance request")


# when the route is not defined
@app.errorhandler(404)
def not_found(e):
    return json.dumps("URL not found")


if __name__ == '__main__':
    WSGIRequestHandler.protocol_version = "HTTP/1.1"
    app.run(host='0.0.0.0' , debug=True)
