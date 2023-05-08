import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Hello World!'),
      actions: [
        const Text('Hello World!'),
        const Text('Hello World!'),
      ],
    );
  }
}
