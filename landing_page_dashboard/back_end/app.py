from flask import Flask, send_file, redirect
from pathlib import Path
import json


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
    __exists = Path(f'/images/{image_tag}')
    if __exists.is_file():
        return send_file(f'/images/{image_tag}', mimetype='image/gif')
    else:
        # redirect to 404 error
        return redirect(error404)


# error 404
@app.route(404)
def error404():
    return json.dumps("404 error")


if __name__ == '__main__':
    app.run()
