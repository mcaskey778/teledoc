import 'package:rxdart/rxdart.dart';
import '../bloc/base-bloc.dart';
import '../model/user-model.dart';
import '../api/user-api.dart';

class UserService implements BaseBloc {
  static final instance = UserService();

  final _authStateController = BehaviorSubject<UserModel>();
  Function(UserModel) get changeAauthState => _authStateController.sink.add;
  Stream<UserModel> get onAuthStateChanged => _authStateController.stream;
  UserModel get user => _authStateController.value;

  UserService() {
    //_authStateController.sink.add(null);
    final user = UserModel();
    user.firstName = "Test";
    user.lastName = "User";
    _authStateController.sink.add(user);
  }

  Future signIn(String user, String password) async {
    final response = await UserApi.instance.signIn(user, password);
    if(response.statusCode==200) {
      UserModel user = UserModel.fromRawJson(response.body);
      UserService.instance.changeAauthState(user);
    } else {
      _authStateController.sink.addError("Username/Password is not valid");
    }
    //_authStateController.sink.add(UserModel());
  }

  signOut() {
    _authStateController.sink.add(null);
  }

  @override
  void dispose() {
    _authStateController?.close();
  }
}