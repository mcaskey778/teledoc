import 'base-api.dart';
import '../service/user-service.dart';
import '../model/user-model.dart';

class UserApi extends BaseApi {
  static final instance = UserApi();

  UserApi() : super();

  Future signIn(String user, String password) async {
    return await apiPostString('token', body: "grant_type=password&username=" + Uri.encodeComponent(user) + "&password=" + Uri.encodeComponent(password));
  }

  signOut() {

  }
}