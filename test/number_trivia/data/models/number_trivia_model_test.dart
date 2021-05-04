import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_app/number_trivia/data/models/number_trivia_model.dart';
import 'package:trivia_app/number_trivia/domain/entities/number_trivia.dart';
import 'dart:convert';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test');
  test('Be a subclass of NumberTrivia Entity', () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test(
      'Return a valid model when JSON number is an integer',
      () async {
        // Arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia.json'));
        // Act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // Assert
        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'Return a valid model when JSON number is a double',
      () async {
        // Arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia_double.json'));
        // Act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // Assert
        expect(result, tNumberTriviaModel);
      },
    );
  });

  group('toJon', () {
    test('Return a JSON map containing the data', () {
      final result = tNumberTriviaModel.toJson();
      final expectedMap = {
        "text": "test",
        "number": 1,
      };
      expect(result, expectedMap);
    });
  });
}
