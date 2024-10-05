import 'package:flutter/material.dart';

class MovieErrorWidget extends StatelessWidget {
  final String errorMessage;
  final Function() tryAgain;

  const MovieErrorWidget({super.key, required this.errorMessage, required this.tryAgain});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage),
          ElevatedButton(onPressed: tryAgain, child: const Text("Try Again")),
        ],
      ),
    );
  }
}