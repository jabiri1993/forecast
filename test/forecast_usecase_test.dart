import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:forecast/data/datasources/locals/forecast_local.dart';
import 'package:forecast/data/datasources/remotes/forecast_remotes.dart';
import 'package:forecast/data/models/error_models.dart';
import 'package:forecast/data/repositories/forecast_repo.dart';
import 'package:forecast/domaine/usesCases/forecast_usecase.dart';
import 'package:forecast/helpers/helpers_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'MockConnectivity.dart';
import 'MockForecastLocalDataSource.dart';
import 'MockForecastRemoteDataSource.dart';

@GenerateMocks([
  ForecastRemoteDataSource,
  ForecastLocalDataSource,
  Connectivity,
])
void main() {
  late GetForecastUseCase useCase;
  late ForecastRepositoryImpl repositoryImpl;
  late MockForecastRemoteDataSource mockRemoteDataSource;
  late MockForecastLocalDataSource mockLocalDataSource;
  late MockConnectivity mockConnectivity;

  final testData = createTestForecast();
  final errorModel = ErrorModel(message: 'No connection');

  setUp(() {
    mockRemoteDataSource = MockForecastRemoteDataSource();
    mockLocalDataSource = MockForecastLocalDataSource();
    mockConnectivity = MockConnectivity();

    repositoryImpl = ForecastRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      connectivity: mockConnectivity,
    );

    useCase = GetForecastUseCase(repositoryImpl);
  });

  group('GetForecastUseCase', () {
    test('should return fresh data when online', () async {
      when(mockLocalDataSource.getCachedForecast())
          .thenAnswer((_) async => null);
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.wifi);
      when(mockRemoteDataSource.getForecast())
          .thenAnswer((_) async => testData);
      when(mockLocalDataSource.cacheForecast(testData))
          .thenAnswer((_) async => true);

      final result = await useCase.execute();

      expect(result, testData);
      verify(mockRemoteDataSource.getForecast()).called(1);
    });

    test('should return cached data when offline', () async {
      // Arrange
      when(mockLocalDataSource.getCachedForecast())
          .thenAnswer((_) async => testData);
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.none);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, testData);
      verifyNever(mockRemoteDataSource.getForecast());
    });

    test('should return ErrorModel when no cache and offline', () async {
      // Arrange
      when(mockLocalDataSource.getCachedForecast())
          .thenAnswer((_) async => null);
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.none);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, isA<ErrorModel>());
    });

    test('should return stale cache when API fails', () async {
      // Arrange
      when(mockLocalDataSource.getCachedForecast())
          .thenAnswer((_) async => testData);
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.wifi);
      when(mockRemoteDataSource.getForecast())
          .thenThrow(Exception('API failed'));

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, testData);
    });
  });
}
