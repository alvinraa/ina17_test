import 'dart:developer';

import 'package:dio/dio.dart';

class Logger {
  static print(Object? object) {
    var ansiBlue = "\u001b[32m";
    log("$ansiBlue${object.toString()}");
  }

  static printError(DioException e) {
    var ansiRed = "\u001b[31m";
    log("$ansiRed${"Send ${e.response?.requestOptions.method} "
        "\nendPoint: ${e.response?.requestOptions.path}, "
        "\nstatusCode: ${e.response?.statusCode}, "
        "\nstatusMessage: ${e.response?.data}, "
        "\nheaders: ${e.response?.requestOptions.headers}, "
        "\nqueryParameters: ${e.response?.requestOptions.queryParameters}, "
        "\nbody: ${e.response?.requestOptions.data}"}");
  }
}
