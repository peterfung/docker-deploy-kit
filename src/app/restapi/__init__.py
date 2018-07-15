from flask_restful import Api
from flask import Blueprint
from .user import TodoSimple

api_blueprint = Blueprint("restapi", __name__)
resource = Api(api_blueprint)
resource.add_resource(TodoSimple, '/todo/<string:todo_id>')