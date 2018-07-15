from flask import Flask
from flask_sqlalchemy import SQLAlchemy


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://user:password@host:port/dbname'
mysql_db = SQLAlchemy(app)


class User(db.Model):
    id = mysql_db.Column(db.Integer, primary_key=True)
    username = mysql_db.Column(db.String(80), unique=True, nullable=False)
    email = mysql_db.Column(db.String(120), unique=True, nullable=False)

    def __repr__(self):
        return '<User %r>' % self.username