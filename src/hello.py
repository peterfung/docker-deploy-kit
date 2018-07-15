from flask import Flask, request, render_template
from flask_mail import Mail, Message
from flask_restful import Resource, Api
from app.restapi import api_blueprint

app = Flask(__name__)
api = Api(app)

@app.route('/')
def hello_world():
    user_agent = request.headers.get('User-Agent')
    return '<p>Your browser is %s</p>' % user_agent


@app.route('/user/<name>')
def user(name):
    return render_template('user.html', name=name)


app.config.update(dict(
    DEBUG = True,
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = 465,
    MAIL_USE_SSL = True,
    MAIL_USERNAME = "peterfung42@gmail.com",
    MAIL_PASSWORD = "",
    MAIL_DEFAULT_SENDER = 'peterfung42 <peterfung42@gmail.com>'
))
mail = Mail(app)
@app.route('/mail/send')
def send_mail():
    msg = Message(subject = 'subject',recipients = ['peterfung42@qq.com'])
    msg.html = '<h1>hbody</h1>'
    mail.send(msg)
    return 'mail sended.'


app.register_blueprint(api_blueprint, url_prefix='/api/v1')
