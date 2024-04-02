import 'package:flutter/material.dart';
import 'package:harvestlink_app/engine/api/http_handler.dart';
import 'package:harvestlink_app/engine/storage/local_storage.dart';
import 'package:harvestlink_app/features/consumer/widgets/category_tile.dart';
import 'package:harvestlink_app/features/farmer/widgets/farmer_product_card.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';
import 'package:harvestlink_app/templates/constants/image.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({super.key});

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  final localStorage = LocalStorage();
  List allProducts = [];

  void getMyProducts() async {
    var userId = await localStorage.getUserParam('id');
    Map<String, dynamic> params = {"farmer_id": userId};
    List res = await HTTPHandler().getDataWithBody('/products', params);
    setState(() {
      allProducts = res;
    });
  }

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
  void initState() {
    getMyProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  subHeaderTextBlack("My Products"),
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
                    return FarmerProductCardVertical(
                      productId: allProducts[index]['id'],
                      productTitle: allProducts[index]['name'],
                      quantity: allProducts[index]['quantity'].toString(),
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
