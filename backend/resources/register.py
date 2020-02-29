from flask_restful import Resource
from flask import request
from models import db, User
import string
import random

class Register(Resource):
    def get(self):
        users = User.query.all()
        user_list = []
        for i in range(0, len(users)):
            user_list.append(users[i].serialize())
        return { "status" : "success", "data" : str(user_list)}, 200
    def post(self):
        json_data = request.get_json(force=True)
        if not json_data:
            return {"message" : "No input data provided"}, 400

        user = User.query.filter_by(username=json_data["username"]).first()
        if user:
            return {"message" : "Username already exists"}, 400
        user = User.query.filter_by(email=json_data["email"]).first()
        if user:
            return {"message" : "Email address already exists"}, 400

        api_key = self.generate_key()
        user = User.query.filter_by(api_key=api_key).first()
        if user:
            return {"message" : "API key already exists"}, 400

        username = json_data['username']
        password = json_data['password']
        email = json_data['email']

        user = User(
            api_key = self.generate_key(),
            first_name = json_data["first_name"],
            last_name = json_data["last_name"],
            email = json_data["email"],
            password = json_data["password"],
            username = json_data["username"]
        )
        db.session.add(user)
        db.session.commit()

        result = User.serialize(user)

        return { "status" : "success", "data" : result }, 201

    def generate_key(self):
        return ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(50))