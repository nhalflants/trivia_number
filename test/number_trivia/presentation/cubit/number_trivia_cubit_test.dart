import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_app/core/error/failures.dart';
import 'package:trivia_app/core/utils/input_converter.dart';
import 'package:trivia_app/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_app/number_trivia/domain/usecases/get_number_trivia.dart';
import 'package:trivia_app/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:trivia_app/number_trivia/presentation/cubit/number_trivia_cubit.dart';

import 'number_trivia_cubit_test.mocks.dart';

@GenerateMocks([GetNumberTrivia, GetRandomNumberTrivia, InputConverter])
void main() {
  MockGetNumberTrivia mockGetNumberTrivia = MockGetNumberTrivia();
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia =
      MockGetRandomNumberTrivia();
  MockInputConverter mockInputConverter = MockInputConverter();

  NumbertriviaCubit cubit = NumbertriviaCubit(
    concrete: mockGetNumberTrivia,
    random: mockGetRandomNumberTrivia,
    inputConverter: mockInputConverter,
  );

  test('initialState should be empty', () {
    expect(cubit.state, equals(Initial()));
  });

  group('GetTriviaForNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

    test('should call InputConverter to validate and convert input', () async {
      // Arrange
      setUpMockInputConverterSuccess();
      // Act
      cubit.fetchTriviaForNumber(tNumberString);
      // await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      // Assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('should emit [Error] when the input is invalid', () async {
      // Arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));
      // Assert later
      expectLater(
        cubit.state,
        emitsInOrder(
          [Initial(), Error(message: INVALID_INPUT_FAILURE_MESSAGE)],
        ),
      );
      // Act
      cubit.fetchTriviaForNumber(tNumberString);
    });

    test('should get data from use case', () async {
      // Arrange
      setUpMockInputConverterSuccess();
      when(mockGetNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      // Act
      cubit.fetchTriviaForNumber(tNumberString);
      // Assert
      verify(mockGetNumberTrivia(Params(number: tNumberParsed)));
    });

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        // assert later
        final expected = [
          Initial(),
          Loading(),
          Success(trivia: tNumberTrivia),
        ];
        expectLater(cubit.state, emitsInOrder(expected));
        // act
        cubit.fetchTriviaForNumber(tNumberString);
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Initial(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(cubit.state, emitsInOrder(expected));
        // act
        cubit.fetchTriviaForNumber(tNumberString);
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Initial(),
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(cubit.state, emitsInOrder(expected));
        // act
        cubit.fetchTriviaForNumber(tNumberString);
      },
    );
  });
}
