import 'package:flutter/material.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        width: screenSize.width,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(
            color: Colors.green.shade900,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.green.shade900,
            ),
            const SizedBox(
              width: 16.0,
            ),
            smallTextBlack("Search the market..."),
          ],
        ),
      ),
    );
  }
}