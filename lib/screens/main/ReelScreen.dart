import 'package:flutter/material.dart';

class ReelScreen extends StatelessWidget {
  const ReelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reel"),
      ),
      body: const Center(
        child: Text("Reel"),
      ),
    );
  }
}
