import 'dart:convert';
import 'package:intl/intl.dart';
import '../../../inject_container.dart';

abstract class ForecastLocalDataSource {
  Future<void> cacheForecast(Object? data);

  Future<void> cacheDate();

  Future<Object?> getCachedForecast();

  Future<DateTime> getCachedDate();
}

class ForecastLocalDataSourceImpl implements ForecastLocalDataSource {
  @override
  Future<void> cacheForecast(Object? data) async {
    await prefs.setString('forecast', json.encode(data));
    cacheDate();
  }

  @override
  Future<Object?> getCachedForecast() async {
    final forecastJson = prefs.getString('forecast');
    return forecastJson != null ? json.decode(forecastJson) : null;
  }

  @override
  Future<void> cacheDate() async {
    await prefs.setString('cachedDate', DateTime.now().toString());
  }

  @override
  Future<DateTime> getCachedDate() async {
    DateFormat format = DateFormat("dd-MM-yyyy HH:mm");
    DateTime dateTime = format.parse(prefs.getString('cachedDate')!);
    return dateTime;
  }
}
