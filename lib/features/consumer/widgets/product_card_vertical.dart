import 'package:flutter/material.dart';
import 'package:harvestlink_app/templates/constants/image.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.green.shade100,
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                const Image(
                  image: AssetImage(HLImage.imageCereals),
                ),
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.green.shade900,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: const Text(
                      "2%",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
