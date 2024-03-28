import 'package:flutter/material.dart';
import 'package:harvestlink_app/engine/api/http_handler.dart';
import 'package:harvestlink_app/engine/storage/local_storage.dart';
import 'package:harvestlink_app/features/consumer/views/home.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';
import 'package:harvestlink_app/templates/constants/image.dart';

class ProductCardVertical extends StatelessWidget {
  ProductCardVertical(
      {super.key,
      required this.productTitle,
      required this.vendor,
      required this.location,
      required this.price,
      required this.image,
      required this.productId});

  final String productTitle, vendor, location, price, image, productId;

  final localStorage = LocalStorage();

  void _addCartItem() async {
    var userId = await localStorage.getUserParam('id');
    Map<String, String> body = {
      'consumer_id': userId!,
      'product_id': productId,
      'quantity': '1'
    };
    int status = await HTTPHandler().postData('/cart/add', body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.green.shade100,
            ),
            child: Stack(
              children: [
                Image(
                  fit: BoxFit.contain,
                  image: NetworkImage("${HLImage.imgBaseUrl}$image.jpg"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0),
                Text(
                  productTitle,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      vendor,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Icon(
                      Icons.check_circle,
                      size: 14.0,
                      color: Colors.green.shade900,
                    ),
                  ],
                ),
                const SizedBox(width: 4.0),
                Text(
                  location,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Kes",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        _addCartItem();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () {
                              },
                              textColor: Colors.white,
                            ),
                            backgroundColor: Colors.green.shade900,
                            content: const Text('Added to cart'),
                          ),
                        );
                        const HomePage().refreshCartBadge();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade900,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0),
                          ),
                        ),
                        child: const SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
