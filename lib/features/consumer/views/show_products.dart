import 'package:flutter/material.dart';
import 'package:harvestlink_app/features/consumer/widgets/home_app_bar.dart';
import 'package:harvestlink_app/features/consumer/widgets/product_card_vertical.dart';

import '../../../templates/components/text_components.dart';
import '../../../templates/constants/image.dart';
import '../widgets/category_tile.dart';
import '../widgets/search_container.dart';

class ShowProducts extends StatelessWidget {
  ShowProducts({
    super.key,
    required this.screenSize,
    required this.allProducts,
  });

  final Size screenSize;
  final List allProducts;

  Map<String, dynamic> categoriesMap = {
    "Vegetables": HLImage.imageVegetables,
    "Cereals": HLImage.imageCereals,
    "Fruits": HLImage.imageFruits,
    "Meat": HLImage.imageMeat,
    "Milk": HLImage.imageMilk,
    "Eggs": HLImage.imageEggs,
    "Fish": HLImage.imageFish
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  itemCount: categoriesMap.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var keys = categoriesMap.keys.toList();
                    var val = categoriesMap[keys[index]];
                    return CategoryTile(
                      imagePath: val,
                      title: keys[index],
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                  itemCount: allProducts.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    childAspectRatio: 0.55,
                  ),
                  itemBuilder: (context, index) {
                    return ProductCardVertical(
                      productTitle: allProducts[index]['name'],
                      vendor: allProducts[index]['farmer'],
                      location: allProducts[index]['location'],
                      price: allProducts[index]['price'].toString(),
                      image: allProducts[index]['product_image'],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
