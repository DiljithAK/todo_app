import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/request_models/login_request_model.dart';
import '../common/api_constants.dart';
import '../common/requests.dart';

class AuthService {
  static Future<Map<String, dynamic>> loginUser(
      LoginRequestModel requestModel) async {
    final response =
        await Requests.postRequest(APIConstants.loginEndpoint, requestModel);
    String responseBody = response.body;
    Map<String, dynamic> jsonData = json.decode(responseBody);
    if (response.statusCode == 200) {
      if (jsonData['status'] == 1) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('token', jsonData['token']);
        prefs.setString('name', jsonData['name']);
        prefs.setString('email', jsonData['email']);
      }
    }
    return jsonData;
  }
}
