import 'package:flutter/material.dart';

void main() {
  runApp(const HarvestLink());
}

class HarvestLink extends StatelessWidget {
  const HarvestLink({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "HarvestLink",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green.shade900,
          ),
          body: const Center(
            child: Text("Welcome to harvestlink!"),
          ),
        ),
      ),
    );
  }
}
