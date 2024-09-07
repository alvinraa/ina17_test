import 'package:dio/dio.dart';
import 'package:ina17_test/core/common/constant.dart';
import 'package:ina17_test/core/common/logger.dart';

class Client {
  late Dio dio;
  String? token;
  bool showLog = true;

  Client._internal();

  static final Client _singleton = Client._internal();
  // todo: ini apa?
  factory Client() {
    return _singleton;
  }

  Future setupClient() async {
    dio = Dio(
      BaseOptions(
        baseUrl: Constant.baseUrl,
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
        contentType: "application/json",
        responseType: ResponseType.json,
      ),
    );
    setDioRequest();
    setDioHeader();
    await setTokenHeader();
  }

  void setDioRequest() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Do something before request is sent
          if (showLog) {
            Logger.print("Send ${options.method} "
                "\nendPoint: ${options.path}, "
                "\nqueryParameters: ${options.queryParameters}, "
                "\nbody: ${options.data}, "
                "\nbaseURL: ${options.baseUrl}, "
                "\nheaders: ${options.headers}");
          }

          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          // Do something with response data
          if (showLog) {
            Logger.print("+++++++++++++++++++++++++++++++++++"
                "\nENDPOINT: ${response.requestOptions.path} "
                "\nRESPONSE: $response"
                "\n+++++++++++++++++++++++++++++++++++");
          }

          return handler.next(response); // continue
        },
        onError: (DioException e, handler) async {
          // Do something with response error
          if (showLog) {
            Logger.printError(e);
          }

          return handler.next(e); //continue
        },
      ),
    );
  }

  void setDioHeader() {
    dio.options.headers = {
      'accept': 'application/json',
    };
  }

  setTokenHeader() async {
    //jika punya token dari session
    //token = await session.getToken();

    token = null;

    if (showLog) {
      Logger.print("token: $token");
    }

    if (token != null) {
      // remove first
      dio.options.headers.remove("Authorization");
      // then add
      dio.options.headers.addAll({
        "Authorization": "Bearer $token",
      });
    }
  }

  removeTokenHeader() {
    token = null;
    dio.options.headers.remove("Authorization");
  }
}
