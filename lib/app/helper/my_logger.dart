import 'package:logger/logger.dart';

class MyLogger {
  static final Logger _logger = Logger();

  static void printMessage(dynamic message) {
    _logger.f(message);
  }

  static void printSuccess(String message) {
    _logger.d(message);
  }

  static void printError(dynamic error) {
    _logger.e(error);
  }
}