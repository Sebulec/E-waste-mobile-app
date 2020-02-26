class AppException implements Exception {
  final _message;

  AppException([this._message]);

  String toString() {
    return _message;
  }
}

class FetchDataException extends AppException {
  FetchDataException() : super("no_internet_connection");
}

class BadRequestException extends AppException {
  BadRequestException() : super("server_error");
}

class UnauthorisedException extends AppException {
  UnauthorisedException() : super("server_error");
}

class InvalidInputException extends AppException {
  InvalidInputException() : super("server_error");
}
