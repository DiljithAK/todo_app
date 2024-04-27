import 'dart:convert';

import 'package:todo_app/services/common/api_constants.dart';
import 'package:todo_app/services/common/requests.dart';

class TaskService {
  static Future<Map<String, dynamic>> getTaskList() async {
    final response = await Requests.getRequest(APIConstants.taskEndpoint);
    String responseBody = response.body;
    Map<String, dynamic> responseData = json.decode(responseBody);
    return responseData;
  }
}
