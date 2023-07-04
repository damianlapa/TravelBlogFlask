from src import app
__requires__ = ['pip >= 23.1.2']

app = app

if __name__ == '__main__':
    app.run(debug=True)