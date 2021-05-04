import 'package:dartz/dartz.dart';
import 'package:trivia_app/core/error/failures.dart';
import 'package:trivia_app/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
