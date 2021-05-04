import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/number_trivia/domain/entities/number_trivia.dart';

part 'number_trivia_state.dart';

class NumbertriviaCubit extends Cubit<NumbertriviaState> {
  NumbertriviaCubit() : super(Initial());
}
