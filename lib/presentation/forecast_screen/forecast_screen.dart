import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forecast/localization/app_localization.dart';
import 'package:forecast/presentation/forecast_screen/bloc/forecast_bloc.dart';
import '../../domaine/repositories/forecast_repo.dart';
import '../../helpers/helpers_functions.dart';
import '../../inject_container.dart';
import 'models/forecast_model.dart';
import 'models/response_model.dart';

class ForecastScreen extends StatelessWidget {
  ForecastScreen({Key? key})
      : super(
          key: key,
        );
  List<String> timeStepList = ['current', '1d', '1h'];

  static Widget builder(BuildContext context) {
    return BlocProvider<ForecastBloc>(
      create: (context) => ForecastBloc(
        ForecastState(
          modelObj: ForecastModel(),
        ),
        getIt<ForecastRepository>(),
      ),
      child: ForecastScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<ForecastBloc>()
        .add(GetWeatherForecastEvent(timeStep: timeStepList[2]));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'weather_forecast'.tr,
            style: const TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'forecast_hours'.tr,
                    style: const TextStyle(fontSize: 20),
                  ),
                  _buildLanguageDropDown(context)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: BlocBuilder<ForecastBloc, ForecastState>(
                  builder: (context, state) {
                    if (state is Success) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<ForecastBloc>().add(
                              GetWeatherForecastEvent(
                                  timeStep: timeStepList[2]));
                        },
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return _buildItem((state.forecastList as Timelines)
                                .intervals?[index]
                                .values);
                          },
                          itemCount: (state.forecastList as Timelines)
                              .intervals
                              ?.length,
                        ),
                      );
                    } else if (state is Failure) {
                      return Center(
                        child: Column(
                          children: [
                            Text("error".tr),
                            ElevatedButton(
                                onPressed: () {
                                  context.read<ForecastBloc>().add(
                                      GetWeatherForecastEvent(
                                          timeStep: timeStepList[2]));
                                },
                                child: Text("try_again".tr))
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildItem(Values? item) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'temperature'.tr,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 20,
            ),
            Text((item?.temperature).toString()),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              'temperature_apparent'.tr,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 20,
            ),
            Text((item?.temperatureApparent).toString()),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              'vitesse'.tr,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 20,
            ),
            Text((item?.windSpeed).toString()),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider()
      ],
    ),
  );
}

_buildLanguageDropDown(context) {
  return DropdownButton<String>(
    value: 'en',
    icon: const Icon(
      Icons.language,
    ),
    onChanged: (String? newValue) {
      FunctionUtils.changeLanguage(context);
    },
    items: ['en', 'fr'].map((String language) {
      return DropdownMenuItem<String>(
        value: language,
        child: Text(language),
      );
    }).toList(),
  );
}
