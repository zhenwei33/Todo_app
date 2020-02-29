import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/classes/user.dart';

class ApiProvider {
  Client client = Client();
  final _apiKey = '';

  Future signinUser(String username, String password, String apiKey) async {
    print(username);
    print(apiKey);
    final response = await client.post("http://127.0.0.1:5000/api/signin",
      headers: {
        "Authorization" : "pn8V5Aoyc11pW5nGaaZkyZlZbPzMWMU7DlkXfnTxl56RG2MWXx" //apiKey
      },
      body: jsonEncode({
        "username" : username,
        "password" : password
      })
    );
    final Map result = json.decode(response.body);
    
    if (response.statusCode == 201) {
      print(result);
      await saveApiKey(result["data"]["api_key"]);
      return User.fromJson(result["data"]);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<User> registerUser(String username, String first_name, String last_name, String email, String password) async {
    final response = await client.post("http://127.0.0.1:5000/api/register",
      body: jsonEncode({
        "username" : username,
        "first_name" : first_name,
        "last_name" : last_name,
        "email" : email,
        "password" : password
      })
    );
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      await saveApiKey(result["data"]["api_key"]);
      return User.fromJson(result["data"]);
    } else {
      throw Exception('Failed to load post');
    }
  }

  saveApiKey(String api_key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('API_Token', api_key);
  }
}