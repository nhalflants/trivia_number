import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trivia_app/core/error/exceptions.dart';

import 'package:trivia_app/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  NumberTriviaRemoteDataSourceImpl({
    required this.client,
  });

  final http.Client client;

  @override
  Future<NumberTriviaModel> getNumberTrivia(int number) async {
    final request = Uri.http('numbersapi.com', '/$number');
    return _getTriviaFromUrl(request);
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    final request = Uri.http('numbersapi.com', '/random');
    return _getTriviaFromUrl(request);
  }

  Future<NumberTriviaModel> _getTriviaFromUrl(Uri request) async {
    final response = await client
        .get(request, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
