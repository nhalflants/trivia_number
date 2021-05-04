import 'package:dartz/dartz.dart';
import 'package:trivia_app/core/error/exceptions.dart';

import 'package:trivia_app/core/error/failures.dart';
import 'package:trivia_app/core/platform/network_info.dart';
import 'package:trivia_app/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:trivia_app/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:trivia_app/number_trivia/data/models/number_trivia_model.dart';
import 'package:trivia_app/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_app/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

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
  Future<Either<Failure, NumberTrivia>> getNumberTrivia(int number) async {
    return await _getTrivia(() {
      return remoteDataSource.getNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChooser getTriviaNumberOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getTriviaNumberOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
