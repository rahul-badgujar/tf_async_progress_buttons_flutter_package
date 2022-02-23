// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tf_async_progress_buttons/tf_async_progress_buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TfAsyncProgressElevatedButton(
                  action: connectToServer,
                  undoAction: connectToServer,
                  actionInitButtonChild: const Text('Connect'),
                  actionInProgressButtonChild: const Text('Connecting...'),
                  actionCompleteButtonChild: const Text('Disconnect'),
                  size: const Size(120, 40),
                  actionInitButtonStyle: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  actionInProgressButtonStyle: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                  ),
                  actionDoneButtonStyle: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onActionResulted: (result, isError) {
                    if (isError) {
                      print('Error in action: $result');
                    } else {
                      print('Result in action: $result');
                    }
                  },
                  onUndoActionResulted: (result, isError) {
                    if (isError) {
                      print('Error in undo action: $result');
                    } else {
                      print('Result in undo action: $result');
                    }
                  },
                ),
                TfAsyncProgressTextButton(
                  action: connectToServer,
                  undoAction: connectToServer,
                  actionInitButtonChild: const Text('Connect'),
                  actionInProgressButtonChild: const Text('Connecting...'),
                  actionCompleteButtonChild: const Text('Disconnect'),
                  size: const Size(120, 40),
                  actionInitButtonStyle: ButtonStyle(
                    foregroundColor:
                        ButtonStyleButton.allOrNull<Color>(Colors.green),
                  ),
                  actionInProgressButtonStyle: ButtonStyle(
                    foregroundColor:
                        ButtonStyleButton.allOrNull<Color>(Colors.amber),
                  ),
                  actionDoneButtonStyle: ButtonStyle(
                    foregroundColor:
                        ButtonStyleButton.allOrNull<Color>(Colors.red),
                  ),
                  onActionResulted: (result, isError) {
                    if (isError) {
                      print('Error in action: $result');
                    } else {
                      print('Result in action: $result');
                    }
                  },
                  onUndoActionResulted: (result, isError) {
                    if (isError) {
                      print('Error in undo action: $result');
                    } else {
                      print('Result in undo action: $result');
                    }
                  },
                ),
                TfAsyncProgressOutlinedButton(
                  action: connectToServer,
                  undoAction: connectToServer,
                  actionInitButtonChild: const Text('Connect'),
                  actionInProgressButtonChild: const Text('Connecting...'),
                  actionCompleteButtonChild: const Text('Disconnect'),
                  size: const Size(120, 40),
                  actionInitButtonStyle: ButtonStyle(
                    foregroundColor:
                        ButtonStyleButton.allOrNull<Color>(Colors.green),
                  ),
                  actionInProgressButtonStyle: ButtonStyle(
                    foregroundColor:
                        ButtonStyleButton.allOrNull<Color>(Colors.amber),
                  ),
                  actionDoneButtonStyle: ButtonStyle(
                    foregroundColor:
                        ButtonStyleButton.allOrNull<Color>(Colors.red),
                  ),
                  onActionResulted: (result, isError) {
                    if (isError) {
                      print('Error in action: $result');
                    } else {
                      print('Result in action: $result');
                    }
                  },
                  onUndoActionResulted: (result, isError) {
                    if (isError) {
                      print('Error in undo action: $result');
                    } else {
                      print('Result in undo action: $result');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<int> connectToServer() async {
    final task = Future.delayed(const Duration(seconds: 2));
    await task;
    final randInt = Random().nextInt(5);
    if (randInt == 0) {
      throw Exception('Manually generated error for testing');
    }
    return randInt;
  }
}
