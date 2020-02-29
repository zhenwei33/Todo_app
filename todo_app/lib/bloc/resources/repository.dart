import 'dart:async';
import 'package:todo_app/bloc/resources/api.dart';
import 'package:todo_app/models/classes/user.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<User> registerUser(String username, String first_name, String last_name, String email, String password) 
    => apiProvider.registerUser(username, first_name, last_name, email, password);

  Future signinUser(String username, String password, String apiKey) 
    => apiProvider.signinUser(username, password, apiKey);
}