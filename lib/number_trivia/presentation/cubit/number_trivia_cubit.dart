import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/core/error/failures.dart';
import 'package:trivia_app/core/usecases/usecase.dart';

import 'package:trivia_app/core/utils/input_converter.dart';
import 'package:trivia_app/number_trivia/domain/entities/number_trivia.dart';
import 'package:trivia_app/number_trivia/domain/usecases/get_number_trivia.dart';
import 'package:trivia_app/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input';

class NumbertriviaCubit extends Cubit<NumbertriviaState> {
  NumbertriviaCubit({
    required concrete,
    required random,
    required this.inputConverter,
  })   : getNumberTrivia = concrete,
        getRandomNumberTrivia = random,
        super(Initial());

  final GetNumberTrivia getNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  Future<void> fetchTriviaForNumber(String input) async {
    final inputEither = inputConverter.stringToUnsignedInteger(input);
    inputEither.fold((failure) {
      emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE));
    }, (integer) async {
      emit(Loading());
      final failureOrTrivia = await getNumberTrivia(Params(number: integer));
      _handleFailureOrTrivia(failureOrTrivia);
    });
  }

  void fetchTriviaForRandomNumber() async {
    emit(Loading());
    final failureOrTrivia = await getRandomNumberTrivia(NoParams());
    _handleFailureOrTrivia(failureOrTrivia);
  }

  void _handleFailureOrTrivia(Either<Failure, NumberTrivia> failureOrTrivia) {
    failureOrTrivia.fold((failure) {
      emit(Error(message: _mapFailureToMessage(failure)));
    }, (trivia) => emit(Success(trivia: trivia)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
