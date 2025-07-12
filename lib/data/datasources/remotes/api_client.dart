import 'package:dio/dio.dart';
import 'package:forecast/localization/app_localization.dart';
import '../../../helpers/constans.dart';
import '../../../helpers/exeptions.dart';
import '../../../helpers/helper_network.dart';
import '../../../helpers/logger.dart';
import '../../../inject_container.dart';
import '../models/error_models.dart';

enum MethodType { GET, POST, PUT, DELETE }

class ApiClient {
  static const receiveTimeout = 2 * 60 * 1000;
  static const connectTimeout = 2 * 60 * 1000;
  static const baseUrl = "https://483112b5e18c.ngrok-free.app/";
  static const forecastEndPoint = "forecast";

  static Map<MethodType, String> methods = {
    MethodType.GET: "GET",
    MethodType.POST: "POST",
    MethodType.PUT: "PUT",
    MethodType.DELETE: "DELETE"
  };
}

class Request {
  Dio _dio = getIt<Dio>();
  final NetworkInfo _networkInfo = getIt<NetworkInfo>();

  Request({required String baseUrl}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: const Duration(milliseconds: ApiClient.receiveTimeout),
      connectTimeout: const Duration(milliseconds: ApiClient.connectTimeout),
      contentType: "application/json",
    ));
  }

  Future<Object?> requestApi(
      {required MethodType method,
      required String endPoint,
      data,
      Map<String, dynamic>? queryParams,
      Map<String, dynamic>? headers}) async {
    Logger.log("URL: $endPoint\nbody: $data");
    if (!await _networkInfo.isConnected()) {
      NoInternetException('no_internet'.tr);
      return null;
    } else {
      try {
        var response = await _dio.request(ApiClient.baseUrl + endPoint,
            data: data,
            options:
                Options(method: ApiClient.methods[method], headers: headers),
            queryParameters: queryParams);
        return response.data;
      } catch (e) {
        Logger.error(e.toString());
        return handleError(e);
      }
    }
  }

  Future<ErrorModel> handleError(dynamic error) async {
    ErrorModel errorModel = ErrorModel();
    errorModel.message = error.toString();
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorModel.description = Constants.request_connect_timeout;
        break;
      case DioExceptionType.sendTimeout:
        errorModel.description = Constants.request_send_timeout;
        break;
      case DioExceptionType.receiveTimeout:
        errorModel.description = Constants.request_receive_timeout;
        break;
      case DioExceptionType.badResponse:
        Logger.error(error.response!.toString());
        try {
          errorModel.code = error.response?.statusCode ?? errorModel.code;
          errorModel.description =
              error.response?.data ?? errorModel.description;
        } catch (e) {
          Logger.error(e.toString());
        }
        break;
      case DioExceptionType.cancel:
        errorModel.description = Constants.request_cancelled;
        break;
      default:
        errorModel.description = error.toString();
    }
    return errorModel;
  }
}

abstract class KEY_CONST {
  //error description
  static const request_send_timeout = "request_send_timeout";
  static const request_cancelled = "request_cancelled";
  static const request_connect_timeout = "request_connect_timeout";
  static const no_internet = "no_internet";
  static const request_receive_timeout = "request_receive_timeout";
  static const not_found = "Not found.";
  static const error = "Error";
  static const unknown_error = "Unknown_error";
}
