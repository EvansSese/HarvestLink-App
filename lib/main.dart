import 'package:flutter/material.dart';
import 'package:harvestlink_app/features/auth/views/login.dart';
import 'package:harvestlink_app/features/auth/views/register.dart';
import 'package:harvestlink_app/features/onboarding/welcome.dart';

void main() {
  runApp(const HarvestLink());
}

class HarvestLink extends StatelessWidget {
  const HarvestLink({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
