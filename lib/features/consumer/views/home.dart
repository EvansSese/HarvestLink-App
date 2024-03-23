import 'package:flutter/material.dart';
import 'package:harvestlink_app/features/consumer/widgets/app_bar.dart';
import 'package:harvestlink_app/features/consumer/widgets/category_tile.dart';
import 'package:harvestlink_app/features/consumer/widgets/home_app_bar.dart';
import 'package:harvestlink_app/features/consumer/widgets/product_card_vertical.dart';
import 'package:harvestlink_app/features/consumer/widgets/search_container.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';
import 'package:harvestlink_app/templates/constants/image.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeConsumerAppBar(),
              const SizedBox(height: 32.0),
              SearchContainer(screenSize: screenSize),
              const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  children: [
                    subHeaderTextBlack("Categories"),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SizedBox(
                  height: 80,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return CategoryTile(
                        imagePath: HLImage.imageVegetables,
                        title: 'Vegetables',
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  children: [
                    subHeaderTextBlack("Products"),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: ProductCardVertical(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
