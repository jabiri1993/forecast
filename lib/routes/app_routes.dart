import 'package:flutter/cupertino.dart';

import 'package:forecast/presentation/forecast_screen/forecast_screen.dart';

class AppRoutes {
  static const String initialRoute = '/forecast_screen';

  static Map<String, WidgetBuilder> get routes => {
        initialRoute: ForecastScreen.builder,
      };
}
