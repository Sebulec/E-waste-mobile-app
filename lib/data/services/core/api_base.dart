abstract class ApiBase {
  String get baseUrl;
  Future<dynamic> get(String url);
}
