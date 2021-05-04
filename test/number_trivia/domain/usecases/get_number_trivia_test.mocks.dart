// Mocks generated by Mockito 5.0.7 from annotations
// in trivia_app/test/number_trivia/domain/usecases/get_number_trivia_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:trivia_app/core/error/failures.dart' as _i5;
import 'package:trivia_app/number_trivia/domain/entities/number_trivia.dart'
    as _i6;
import 'package:trivia_app/number_trivia/domain/repositories/number_trivia_repository.dart'
    as _i3;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [NumberTriviaRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockNumberTriviaRepository extends _i1.Mock
    implements _i3.NumberTriviaRepository {
  MockNumberTriviaRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.NumberTrivia>> getNumberTrivia(
          int? number) =>
      (super.noSuchMethod(Invocation.method(#getNumberTrivia, [number]),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.NumberTrivia>>.value(
              _FakeEither<_i5.Failure, _i6.NumberTrivia>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.NumberTrivia>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.NumberTrivia>>
      getRandomNumberTrivia() =>
          (super.noSuchMethod(Invocation.method(#getRandomNumberTrivia, []),
                  returnValue:
                      Future<_i2.Either<_i5.Failure, _i6.NumberTrivia>>.value(
                          _FakeEither<_i5.Failure, _i6.NumberTrivia>()))
              as _i4.Future<_i2.Either<_i5.Failure, _i6.NumberTrivia>>);
}
