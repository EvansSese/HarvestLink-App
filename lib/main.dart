import 'package:flutter/material.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';

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
            title: largeTextWhite("HarvestLink"),
            backgroundColor: Colors.green.shade900,
          ),
          body: Center(
            child: smallTextBlack("Welcome to HarvestLink!"),
          ),
        ),
      ),
    );
  }
}
