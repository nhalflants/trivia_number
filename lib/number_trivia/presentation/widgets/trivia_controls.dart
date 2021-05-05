import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/number_trivia/presentation/cubit/number_trivia_cubit.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key? key,
  }) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final TextEditingController _textController = TextEditingController();

  String get _text => _textController.text;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: _textController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onSubmitted: (_) => _getTriviaNumber(context),
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: TextButton(
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).backgroundColor,
                ),
                onPressed: () => _getTriviaNumber(context),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                child: Text('Get random trivia'),
                onPressed: _getRandomTrivia,
              ),
            ),
          ],
        )
      ],
    );
  }

  void _getTriviaNumber(BuildContext context) {
    if (_text.isEmpty) return;
    context.read<NumberTriviaCubit>().fetchTriviaForNumber(_text);
    _textController.clear();
  }

  void _getRandomTrivia() {
    context.read<NumberTriviaCubit>().fetchTriviaForRandomNumber();
    _textController.clear();
  }
}
