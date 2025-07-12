import '../../../inject_container.dart';
import 'api_client.dart';

abstract class ForecastRemoteDataSource {
  Future<Object?> getForecast({Map<String, String?>? queryParams});
}

class ForecastRemoteDataSourceImpl implements ForecastRemoteDataSource {
  @override
  Future<Object?> getForecast({Map<String, String?>? queryParams}) {
    return getIt<Request>().requestApi(
        method: MethodType.GET,
        endPoint: ApiClient.forecastEndPoint,
        queryParams: queryParams);
  }
}
