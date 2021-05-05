import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/injection_container.dart';
import 'package:trivia_app/number_trivia/presentation/cubit/number_trivia_cubit.dart';
import 'package:trivia_app/number_trivia/presentation/widgets/trivia_controls.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocProvider<NumberTriviaCubit>(
          create: (context) => sl<NumberTriviaCubit>(),
          child: NumberTriviaView(),
        ),
      ),
    );
  }
}

class NumberTriviaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TriviaControls(),
        Expanded(
          child: Center(
            child: BlocBuilder<NumberTriviaCubit, NumbertriviaState>(
              builder: (context, state) {
                if (state is Initial) {
                  return Text('Start searching');
                } else if (state is Loading) {
                  return CircularProgressIndicator();
                } else if (state is Success) {
                  return Text('${state.trivia.text}');
                } else if (state is Error) {
                  return Text(
                    state.message,
                  );
                }
                throw Exception();
              },
            ),
          ),
        ),
      ],
    );
  }
}
