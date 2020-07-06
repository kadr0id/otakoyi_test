import 'package:dio/dio.dart';
import 'package:otakoyi_test/models/login_reqest.dart';
import 'package:otakoyi_test/models/token_response.dart';
import 'package:otakoyi_test/repositories/rest_client.dart';
import 'package:otakoyi_test/ui/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:otakoyi_test/models/errors.dart';

class UserRepository {
  SharedPreferences preferences;
  RestClient restClient;

  UserRepository(this.preferences) {
    restClient = RestClient(preferences);
  }

  Future<dynamic> login(
    LoginRequest request,
  ) async {
    Response response =
        await restClient.post("/auth/login/", data: request.toJson());
    if (response.statusCode < 300) {
      return TokenResponse.fromJsonMap(response.data);
    } else {
      return Error.fromJson(response.data);
    }
  }

  Future<bool> storeToken(String token) async {
    return preferences.setString(TOKEN, token);
  }

  String getToken() {
    return preferences.getString(TOKEN);
  }

  Future<bool> removeToken(String key) {
    return preferences.remove(key);
  }
}
