import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:trivia_app/core/usecases/usecase.dart';
import 'package:trivia_app/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_app/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_app/number_trivia/domain/usecases/get_random_number_trivia.dart';

import 'get_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  MockNumberTriviaRepository mockNumberTriviaRepository =
      MockNumberTriviaRepository();
  GetRandomNumberTrivia usecase =
      GetRandomNumberTrivia(repository: mockNumberTriviaRepository);

  final tNumberTrivia = NumberTrivia(text: 'test', number: 1);

  test('Get random trivia from the repository', () async {
    when(mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(tNumberTrivia));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
