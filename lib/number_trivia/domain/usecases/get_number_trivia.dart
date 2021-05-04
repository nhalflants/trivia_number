import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:trivia_app/core/error/failures.dart';
import 'package:trivia_app/core/usecases/usecase.dart';
import 'package:trivia_app/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_app/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;
  GetNumberTrivia({
    required this.repository,
  });

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;
  Params({
    required this.number,
  });

  @override
  List<Object?> get props => [number];
}