from flask import Flask, send_file, redirect, abort
from pathlib import Path
import json
import os


app = Flask(__name__)



@app.route('/', methods=['GET'])
def dashboard_home():
    return "yo"


# route for uploading the the photos. Accessible only with POST
@app.route('/upload', methods=['POST'])
def upload_photo():
    pass

# route for seving the url of the photos. Accessible only with GET
@app.route('/url-fetch', methods=['GET'])
def serve_url():
    pass



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
