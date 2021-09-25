from ntpath import join
from flask import Flask, send_file, redirect, abort
from pathlib import Path
import json
import os 
from os.path import join, dirname, realpath
from flask.globals import request
import database_access

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


# when the route is not defined
@app.errorhandler(404)
def not_found(e):
    return json.dumps("URL not found")


if __name__ == '__main__':
    app.run(debug=True)
