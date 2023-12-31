import '../model/user_app.dart';

class AppData {
  UserApp? _userApp;
  UserApp? get currentUser => _userApp;
  set setUser(UserApp userApp) {
    _userApp = userApp;
  }
}
