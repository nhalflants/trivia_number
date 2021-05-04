import 'package:trivia_app/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:trivia_app/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  @override
  Future<Either<Failure, NumberTrivia>> getNumberTrivia(int number) {
    // TODO: implement getNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
}
