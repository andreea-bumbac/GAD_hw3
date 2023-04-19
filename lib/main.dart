import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const GuessPage(title: 'Guess my number'),
    );
  }
}

class GuessPage extends StatefulWidget {
  const GuessPage({super.key, required this.title});

  final String title;

  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage> {

  String _resultMessage = '';
  final num _resultingNumber = 0;

  Random random = Random();
  int _randomNr = 0;

  final TextEditingController gsController = TextEditingController();

  void _generateRandomNumber() {
    setState(() {
      _randomNr = random.nextInt(100);
    });

  }


  void _showResult() {
    setState(() {
      if (_randomNr == 0) {
        _generateRandomNumber();
      }
      if (gsController.text.isEmpty) {
        _resultMessage = 'Please enter a number.';
      } else {
        if (_resultingNumber < _randomNr) {
          _resultMessage = 'You tried $_resultingNumber\n Try higher';
        }
        if (_resultingNumber > _randomNr) {
          _resultMessage = 'You tried $_resultingNumber\n Try lower';
        }
        if (_resultingNumber == _randomNr) {
          _resultMessage = 'You tried $_resultingNumber\n You guessed right';

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('You guessed right!'),
                  content: Text('It was $_randomNr'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Try again'),
                      onPressed: () {
                        _resultMessage = '';
                        _generateRandomNumber();
                      },
                    ),
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'I am thinking of a number between 1 and 100\n Is your turn to guess my number',

            ),
            Text(
              _resultMessage,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ColoredBox(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Try a number!',
                  ),
                  TextField(
                    controller: gsController,
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),

                  ),
                  ElevatedButton(
                    onPressed: _showResult,
                    child: const Text('Guess'),
                  ),
                ]
              )



            ),
          ],
        ),
      ),
      );
  }
}
