// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/request_models/login_request_model.dart';

class ApiService {
  static Future<Map<String, dynamic>> loginUser(LoginRequestModel request) async {
    final url = 'YOUR_API_ENDPOINT/login'; // Replace with your API endpoint

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(request.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful login
        return json.decode(response.body);
      } else {
        // Handle error cases
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
