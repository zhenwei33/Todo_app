import 'package:todo_app/bloc/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_app/models/classes/user.dart';


class UserBloc {
  final _repository = Repository();
  final _userGetter = PublishSubject<User>();

  Observable<User> get getUser => _userGetter.stream;

  registerUser(String username, String first_name, String last_name, String email, String password) async {
    User user = await _repository.registerUser(username, first_name, last_name, email, password);
    _userGetter.sink.add(user);
  }

  signinUser(String username, String password, String apiKey) async {
    User user = await _repository.signinUser(username, password, apiKey);
    _userGetter.sink.add(user);
  }

  dispose() {
    _userGetter.close();
  }
}

final bloc = UserBloc();