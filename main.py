from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def main():
    return open('templates/mock.html').read()

@app.route("/mock_files/<path:path>")
def mock_files(path):
    print path
    return open('templates/mock_files/' + path).read()

@app.route("/poll")
def poll():
    return open('templates/index.html').read()

if __name__ == "__main__":
    app.run(debug=True)
