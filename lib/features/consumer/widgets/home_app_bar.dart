import 'package:flutter/material.dart';
import 'package:harvestlink_app/features/consumer/widgets/app_bar.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';

class HomeConsumerAppBar extends StatelessWidget {
  const HomeConsumerAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConsumerAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerTextBlack("HarvestLink"),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_basket),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: Container(
                width: 18.0,
                height: 18.0,
                decoration: BoxDecoration(
                  color: Colors.green.shade900,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(
                  child: Text(
                    "3",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}