import 'package:dartz/dartz.dart';

import 'package:trivia_app/core/error/failures.dart';
import 'package:trivia_app/core/platform/network_info.dart';
import 'package:trivia_app/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:trivia_app/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:trivia_app/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_app/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

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
