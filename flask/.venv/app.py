from flask import Flask, request
from flask_cors import CORS, cross_origin

app = Flask(__name__)
CORS(app, support_credentials=True)

@app.route("/api", methods = ['GET'])
@cross_origin(supports_credentials=True)
def hello():
    data = {}
    input = str(request.args['name'])
    data['name'] = input
    return data

if __name__ == "__main__":
    app.run()