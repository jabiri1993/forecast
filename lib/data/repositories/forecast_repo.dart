import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../domaine/repositories/forecast_repo.dart';
import '../locals/forecast_local.dart';
import '../models/error_models.dart';
import '../remotes/forecast_remotes.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastRemoteDataSource remoteDataSource;
  final ForecastLocalDataSource localDataSource;
  final Connectivity connectivity;
  final Duration cacheDuration;

  ForecastRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivity,
    this.cacheDuration = const Duration(hours: 1),
  });

  @override
  Future<Object?> getForecast() async {
    try {
      // 1. Always try to get cached forecast first
      final cachedData = await localDataSource.getCachedForecast();

      // 2. Check if cached data is still valid
      final now = DateTime.now();
      if (cachedData != null) {
        final isCacheValid =
            now.difference(await localDataSource.getCachedDate()) <
                cacheDuration;
        if (isCacheValid) {
          return cachedData;
        }
      }

      // 3. Check network connectivity
      final hasConnection =
          await connectivity.checkConnectivity() != ConnectivityResult.none;

      if (!hasConnection) {
        if (cachedData != null) {
          return cachedData; // Return stale data if offline
        }
        return ErrorModel();
      }

      // 4. Fetch fresh data from API
      final remoteData = await remoteDataSource.getForecast();

      if (remoteData is! ErrorModel) {
        await localDataSource.cacheForecast(remoteData);
      }

      return remoteData;
    } catch (e) {
      // Return cached data even if it's stale as fallback
      final cachedData = await localDataSource.getCachedForecast();
      if (cachedData != null) {
        return cachedData;
      }
      throw Exception('Failed to get forecast: ${e.toString()}');
    }
  }
}
