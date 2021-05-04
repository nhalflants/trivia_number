import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_app/core/error/exceptions.dart';
import 'package:trivia_app/core/error/failures.dart';
import 'package:trivia_app/core/network/network_info.dart';
import 'package:trivia_app/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:trivia_app/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:trivia_app/number_trivia/data/models/number_trivia_model.dart';
import 'package:trivia_app/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:trivia_app/number_trivia/domain/entities/number_trivia.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([
  NumberTriviaRemoteDataSource,
  NumberTriviaLocalDataSource,
  NetworkInfo,
])
void main() {
  MockNumberTriviaRemoteDataSource mockRemoteDataSource =
      MockNumberTriviaRemoteDataSource();
  MockNumberTriviaLocalDataSource mockLocalDataSource =
      MockNumberTriviaLocalDataSource();
  MockNetworkInfo mockNetworkInfo = MockNetworkInfo();
  NumberTriviaRepositoryImpl repository = NumberTriviaRepositoryImpl(
    remoteDataSource: mockRemoteDataSource,
    localDataSource: mockLocalDataSource,
    networkInfo: mockNetworkInfo,
  );

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel(text: 'test', number: tNumber);
    final NumberTrivia tNumberTriviaEntity = tNumberTriviaModel;

    test('should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // Act
      repository.getNumberTrivia(tNumber);
      // Assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successfull',
          () async {
        when(mockRemoteDataSource.getNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getNumberTrivia(tNumber);
        verify(mockRemoteDataSource.getNumberTrivia(tNumber));
        expect(result, equals(Right(tNumberTriviaEntity)));
      });

      test(
          'should cache the data locally when the call to remote data source is successfull',
          () async {
        when(mockRemoteDataSource.getNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        await repository.getNumberTrivia(tNumber);
        verify(mockRemoteDataSource.getNumberTrivia(tNumber));
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });

      test(
          'should server failure when the call to remote data source is unsuccessfull',
          () async {
        when(mockRemoteDataSource.getNumberTrivia(any))
            .thenThrow((_) async => ServerException());
        final result = await repository.getNumberTrivia(tNumber);
        verify(mockRemoteDataSource.getNumberTrivia(tNumber));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getNumberTrivia(tNumber);
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Right(tNumberTriviaEntity)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow((_) async => CacheException());
        final result = await repository.getNumberTrivia(tNumber);
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel(text: 'test', number: 123);
    final NumberTrivia tNumberTriviaEntity = tNumberTriviaModel;

    test('should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // Act
      repository.getRandomNumberTrivia();
      // Assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successfull',
          () async {
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getRandomNumberTrivia();
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        expect(result, equals(Right(tNumberTriviaEntity)));
      });

      test(
          'should cache the data locally when the call to remote data source is successfull',
          () async {
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        await repository.getRandomNumberTrivia();
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });

      test(
          'should server failure when the call to remote data source is unsuccessfull',
          () async {
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenThrow((_) async => ServerException());
        final result = await repository.getRandomNumberTrivia();
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getRandomNumberTrivia();
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Right(tNumberTriviaEntity)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow((_) async => CacheException());
        final result = await repository.getRandomNumberTrivia();
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
