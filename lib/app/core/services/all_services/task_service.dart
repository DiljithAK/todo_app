import 'dart:convert';

import '../common/api_constants.dart';
import '../common/requests.dart';

class TaskService {
  static Future<Map<String, dynamic>> getTaskList() async {
    final response = await Requests.getRequest(APIConstants.taskEndpoint);
    String responseBody = response.body;
    Map<String, dynamic> responseData = json.decode(responseBody);
    return responseData;
  }
}
