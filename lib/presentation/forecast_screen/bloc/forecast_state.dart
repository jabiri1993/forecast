part of 'forecast_bloc.dart';

class ForecastState {
  ForecastState({this.modelObj});

  ForecastModel? modelObj;

  @override
  List<Object?> get props => [
        modelObj,
      ];

  ForecastState copyWith({ForecastModel? weatherModelObj}) {
    return ForecastState(
      modelObj: weatherModelObj ?? modelObj,
    );
  }
}

class InitialState extends ForecastState {}

class Loading extends ForecastState {}

class Success extends ForecastState {
  Success({this.forecastList});

  var forecastList;

  @override
  List<Object?> get props => [
        forecastList,
      ];
}

class Failure extends ForecastState {}
