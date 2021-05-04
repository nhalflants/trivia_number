import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;
import 'package:trivia_app/core/error/exceptions.dart';
import 'package:trivia_app/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:trivia_app/number_trivia/data/models/number_trivia_model.dart';

import '../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  MockClient mockHttpClient = MockClient();
  NumberTriviaRemoteDataSourceImpl dataSource =
      NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      // Arrange
      setUpMockHttpClientSuccess200();
      // Act
      dataSource.getNumberTrivia(tNumber);
      // Assert
      final request = Uri.http('numbersapi.com', '/$tNumber');
      verify(mockHttpClient
          .get(request, headers: {'Content-Type': 'application/json'}));
    });

    test('should return NumberTrivia when the response code is 200 (success)',
        () async {
      // Arrange
      setUpMockHttpClientSuccess200();
      // Act
      final result = await dataSource.getNumberTrivia(tNumber);
      // Assert
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a ServerException when the response code inidicates request status failure',
        () async {
      // Arrange
      setUpMockHttpClientFailure404();
      // Act
      final call = dataSource.getNumberTrivia;
      // Assert
      expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      // Arrange
      setUpMockHttpClientSuccess200();
      // Act
      dataSource.getRandomNumberTrivia();
      // Assert
      final request = Uri.http('numbersapi.com', '/random');
      verify(mockHttpClient
          .get(request, headers: {'Content-Type': 'application/json'}));
    });

    test('should return NumberTrivia when the response code is 200 (success)',
        () async {
      // Arrange
      setUpMockHttpClientSuccess200();
      // Act
      final result = await dataSource.getRandomNumberTrivia();
      // Assert
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a ServerException when the response code inidicates request status failure',
        () async {
      // Arrange
      setUpMockHttpClientFailure404();
      // Act
      final call = dataSource.getRandomNumberTrivia;
      // Assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
