import '../repositories/forecast_repo.dart';

class GetForecastUseCase {
  final ForecastRepository forecastRepository;

  GetForecastUseCase(this.forecastRepository);

  Future<Object?> execute() async {
    return await forecastRepository.getForecast();
  }
}
