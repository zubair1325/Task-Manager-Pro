class Urls {
  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static const String registration = "$_baseUrl/registration";
  static const String login = "$_baseUrl/login";
  static const String createTask = "$_baseUrl/createTask";
  static const String allTaskList = "$_baseUrl/listTaskByStatus/New";
  static const String taskStatusCount = "$_baseUrl/taskStatusCount";
  static String updateTaskStatus(String taskId, String status) =>
      "$_baseUrl/updateTaskStatus/$taskId/$status";
}
