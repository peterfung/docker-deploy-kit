from flask_restful import Resource, Api
from flask import request, Blueprint

todos = {
    'sss':12
}

def make_result(ecode=0, msg='ok', data=None):
    return {"ecode":ecode, "msg":msg, "data":data}

class TodoSimple(Resource):
    def get(self, todo_id):
        return make_result(data={todo_id:todos[todo_id]})

    def post(self, todo_id):
        todos[todo_id] = request.form['data']
        return {todo_id: todos[todo_id]}
