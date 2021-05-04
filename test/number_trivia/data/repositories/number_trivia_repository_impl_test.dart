import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_app/core/platform/network_info.dart';
import 'package:trivia_app/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:trivia_app/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:trivia_app/number_trivia/data/repositories/number_trivia_repository_impl.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([
  NumberTriviaRemoteDataSource,
  NumberTriviaLocalDataSource,
  NetworkInfo,
])
void main() {
  NumberTriviaRemoteDataSource mockRemoteDataSource =
      MockNumberTriviaRemoteDataSource();
  NumberTriviaLocalDataSource mockLocalDataSource =
      MockNumberTriviaLocalDataSource();
  NetworkInfo mockNetworkInfo = MockNetworkInfo();
  NumberTriviaRepositoryImpl repository;

  setUp(() {
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
}
