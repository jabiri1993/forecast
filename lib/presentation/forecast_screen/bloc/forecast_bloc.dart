import '../../../data/datasources/models/error_models.dart';
import '../../../domaine/repositories/forecast_repo.dart';
import '../../../helpers/app_export.dart';
import '../models/forecast_model.dart';
import '../models/response_model.dart';

part 'forecast_event.dart';

part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  ForecastBloc(ForecastState initialState, this._forecastRepository)
      : super(initialState) {
    on<OnInitialEvent>(_onInitialize);
    on<GetWeatherForecastEvent>(_getWeatherForecastInfo);
  }

  final ForecastRepository _forecastRepository;

  _onInitialize(OnInitialEvent event, Emitter<ForecastState> emit) async {}

  _getWeatherForecastInfo(
      GetWeatherForecastEvent event, Emitter<ForecastState> emit) async {
    emit(Loading());
    Object? response = await _forecastRepository.getForecast();

    if (response is! ErrorModel) {
      ResponseModel responseModel =
          ResponseModel.fromJson(response as Map<String, dynamic>);
      Timelines? filteredList = responseModel.data?.timelines?.firstWhere(
          (Timelines timeline) => timeline.timestep == event.timeStep!);
      emit(Success(forecastList: filteredList));
    } else {
      emit(Failure());
    }
  }
}
