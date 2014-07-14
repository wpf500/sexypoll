from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def main():
    return open('templates/index.html').read()

if __name__ == "__main__":
    app.run(debug=True)
