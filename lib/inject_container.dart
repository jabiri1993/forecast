import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasources/locals/forecast_local.dart';
import 'data/datasources/remotes/api_client.dart';
import 'data/datasources/remotes/forecast_remotes.dart';
import 'data/datasources/repositories/forecast_repo.dart';
import 'domaine/repositories/forecast_repo.dart';
import 'domaine/usesCases/forecast_usecase.dart';
import 'helpers/helper_network.dart';

final getIt = GetIt.instance;
late final prefs;

Future<void> initDependencies() async {
  // Register external packages
  getIt.registerSingleton<Connectivity>(Connectivity());

  // Initialize SharedPreferences
  prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Register data sources
  getIt.registerSingleton<ForecastRemoteDataSource>(
    ForecastRemoteDataSourceImpl(),
  );

  getIt.registerSingleton<ForecastLocalDataSource>(
    ForecastLocalDataSourceImpl(),
  );

  getIt.registerSingleton<ForecastRepository>(
    ForecastRepositoryImpl(
      remoteDataSource: getIt<ForecastRemoteDataSource>(),
      localDataSource: getIt<ForecastLocalDataSource>(),
      connectivity: getIt<Connectivity>(),
    ),
  );
  getIt.registerSingleton<GetForecastUseCase>(
    GetForecastUseCase(
      getIt<ForecastRepository>(),
    ),
  );

  getIt.registerSingleton<Dio>(
    Dio(),
  );
  getIt.registerSingleton<NetworkInfo>(
    NetworkInfo(),
  );
  getIt.registerSingleton<GlobalKey<ScaffoldMessengerState>>(
    GlobalKey<ScaffoldMessengerState>(),
  );
  getIt.registerSingleton<Request>(
    Request(baseUrl: ApiClient.baseUrl),
  );
}
