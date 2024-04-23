class APIConstants {
  static const String baseURL = 'http://localhost:9000/api/';
  // static const String baseURL = 'https://protasker.great-site.net/public/api/';

  // Endpoints
  static const String loginEndpoint = '/login';
  static const String userDataEndpoint = '/user';

  // Headers
  static const Map<String, String> jsonHeader = {
    'Content-Type': 'application/json'
  };
}
