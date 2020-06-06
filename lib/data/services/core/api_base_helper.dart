import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_base.dart';
import 'app_exception.dart';

class ApiBaseHelper implements ApiBase {
  final String _baseUrl;

  ApiBaseHelper(this._baseUrl);

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      String targetUrl = _baseUrl + url;
      print(targetUrl);
      final response = await http.get(targetUrl);
      responseJson = _returnResponse(response);
    } catch (e) {
      throw FetchDataException();
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException();
      case 401:
      case 403:
        throw UnauthorisedException();
      case 500:
      default:
        throw FetchDataException();
    }
  }
}
