part of 'forecast_bloc.dart';

abstract class ForecastEvent {}

class OnInitialEvent extends ForecastEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetWeatherForecastEvent extends ForecastEvent {
  String? timeStep;

  GetWeatherForecastEvent({this.timeStep});

  @override
  List<Object?> get props => [timeStep];
}
