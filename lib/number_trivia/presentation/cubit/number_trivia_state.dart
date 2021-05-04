part of 'number_trivia_cubit.dart';

@immutable
abstract class NumbertriviaState extends Equatable {
  const NumbertriviaState();

  @override
  List<Object> get props => [];
}

class Initial extends NumbertriviaState {}

class Loading extends NumbertriviaState {}

class Success extends NumbertriviaState {
  final NumberTrivia trivia;
  Success({required this.trivia});

  @override
  List<Object> get props => [trivia];
}

class Error extends NumbertriviaState {
  final String message;
  Error({required this.message});

  @override
  List<Object> get props => [message];
}
