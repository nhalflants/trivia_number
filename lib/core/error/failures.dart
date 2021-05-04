import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
  // Failure([List properties = const <dynamic>[]]) : super(properties);
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
