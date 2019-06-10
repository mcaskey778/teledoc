import 'package:http/http.dart' as http;
import '../service/user-service.dart';
import '../model/user-model.dart';

class BaseApi {

  final String apiBaseUrl = "https://uat.gogomeds.com/gogomedsserver60/";
  Map<String, String> headers;

  BaseApi() {
    this.headers = {} ;

    UserService.instance.onAuthStateChanged.listen((UserModel user) {
      if (user != null) {
        this.headers['authorization'] = user.accessToken;
      } else {
        this.headers.remove('authorization');
      }
    });
  }

  Future apiGet(String url) async {
    return await http.get('$apiBaseUrl/$url', headers: this.headers).then(handleResponse);
  }

  Future apiPostJson(String url, {Map body}) async {
    return http.post('$apiBaseUrl/$url', body: body, headers: this.headers).then(handleResponse);
  }

  Future apiPostString(String url, {String body}) async {
    return http.post('$apiBaseUrl/$url', body: body, headers: this.headers).then(handleResponse);
  }

  handleResponse(http.Response response) async {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400) {
      throw new Exception("Error while fetching data");
    }
    return response;
  }
}