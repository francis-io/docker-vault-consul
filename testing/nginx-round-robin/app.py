from flask import Flask
import socket
import os

app = Flask(__name__)

@app.route('/')
def display_page():
    hostname = socket.gethostname()
    return socket.gethostbyname(hostname)

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=os.environ.get('PORT'))