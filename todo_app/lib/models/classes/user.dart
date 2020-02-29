class User {
  String username;
  String first_name;
  String last_name;
  String email;
  String password;
  String api_key;
  int id;

  User(this.username, this.first_name, this.last_name, this.email, this.password, this.api_key, this.id);

  User.fromJson(Map<String, dynamic> parsedJson) {
    User user = new User(
      parsedJson['username'],
      parsedJson['first_name'],
      parsedJson['last_name'],
      parsedJson['email'],
      parsedJson['password'],
      parsedJson['api_key'],
      parsedJson['id']
    );
  }
}