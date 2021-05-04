import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:trivia_app/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_app/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_app/number_trivia/domain/usecases/get_number_trivia.dart';

import 'get_number_trivia_test.mocks.dart';

// class MockNumberTriviaRepository extends Mock
//     implements NumberTriviaRepository {}

@GenerateMocks([NumberTriviaRepository])
void main() {
  MockNumberTriviaRepository mockNumberTriviaRepository =
      MockNumberTriviaRepository();
  GetNumberTrivia usecase =
      GetNumberTrivia(repository: mockNumberTriviaRepository);

  // setUp(() {
  //   mockNumberTriviaRepository = MockNumberTriviaRepository();
  //   usecase = GetNumberTrivia(repository: mockNumberTriviaRepository);
  // });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(text: 'test', number: 1);

  test('Get trivia for the number from the repository', () async {
    when(mockNumberTriviaRepository.getNumberTrivia(any))
        .thenAnswer((_) async => Right(tNumberTrivia));

    // Act
    final result = await usecase(Params(number: tNumber));

    // Assert
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
