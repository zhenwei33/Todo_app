from flask import Blueprint
from flask_restful import Api
from resources.register import Register
from resources.signin import Signin
from resources.task import Task

api_bp = Blueprint('api', __name__)
api = Api(api_bp)

# Route
api.add_resource(Register, '/register')

api.add_resource(Signin, '/signin')

api.add_resource(Task, '/tasks')