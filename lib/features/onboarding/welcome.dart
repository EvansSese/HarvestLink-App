import 'package:flutter/material.dart';
import 'package:harvestlink_app/templates/constants/image.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Image(
            image: AssetImage(HLImage.hLogo),
          ),
        )
      ),
    );
  }
}
