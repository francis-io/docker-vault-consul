from flask import Flask
import socket

app = Flask(__name__)

@app.route('/')
def display_page():
    hostname = socket.gethostname()
    return socket.gethostbyname(hostname)
    #return "hello"
    #return render_template("index.html", IP=ip, HOST=hostname)

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')