import 'package:shared_preferences/shared_preferences.dart';

class APIConstants {
  static const String baseURL = 'http://127.0.0.1:8000/api';
  // static const String baseURL = 'https://protasker.great-site.net/public/api/';

  // Endpoints
  // auth
  static const String loginEndpoint = '/login';
  static const String userDataEndpoint = '/user';

  // task
  static const String taskEndpoint = '/task';

  // Headers
  static const Map<String, String> jsonHeader = {
    'Content-Type': 'application/json'
  };

  static Future<Map<String, String>> getHeaderWithToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
