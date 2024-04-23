import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/request_models/login_request_model.dart';
import 'package:todo_app/services/common/api_constants.dart';
import 'package:todo_app/services/common/requests.dart';

class AuthService {
  static Future<Map<String, dynamic>> loginUser(
      LoginRequestModel requestModel) async {
    final response =
        await Requests.postRequest(APIConstants.loginEndpoint, requestModel);
    inspect(response);
    return {"Test": 1};
  }
}
