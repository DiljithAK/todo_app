import 'package:http/http.dart' as http;

import 'package:todo_app/services/common/api_constants.dart';

class Requests {
  static Future<http.Response> getRequest(String url) async {
    try {
      return await http.get(Uri.parse("${APIConstants.baseURL}$url"));
    } catch (e) {
      // Handle error
      throw Exception('Failed to perform GET request');
    }
  }

  static Future<http.Response> postRequest(String url, dynamic body) async {
    try {
      return await http.post(
        Uri.parse("${APIConstants.baseURL}$url"),
        body: body,
        headers: APIConstants.jsonHeader,
      );
    } catch (e) {
      // Handle error
      throw Exception('Failed to perform POST request');
    }
  }

  static Future<http.Response> updateRequest(String url, dynamic body) async {
    try {
      return await http.put(
        Uri.parse("${APIConstants.baseURL}$url"),
        body: body,
        headers: APIConstants.jsonHeader,
      );
    } catch (e) {
      // Handle error
      throw Exception('Failed to perform PUT request');
    }
  }

  static Future<http.Response> deleteRequest(String url) async {
    try {
      return await http.delete(Uri.parse("${APIConstants.baseURL}$url"));
    } catch (e) {
      // Handle error
      throw Exception('Failed to perform DELETE request');
    }
  }
}
