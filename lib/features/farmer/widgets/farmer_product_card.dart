import 'package:flutter/material.dart';
import 'package:harvestlink_app/engine/api/http_handler.dart';
import 'package:harvestlink_app/engine/storage/local_storage.dart';
import 'package:harvestlink_app/features/farmer/views/dashboard.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';
import 'package:harvestlink_app/templates/constants/image.dart';

class FarmerProductCardVertical extends StatelessWidget {
  FarmerProductCardVertical(
      {super.key,
      required this.productTitle,
      required this.quantity,
      required this.location,
      required this.price,
      required this.image,
      required this.productId});

  final String productTitle, quantity, location, price, image, productId;

  final localStorage = LocalStorage();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  _isFilled(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter information';
    }
    return null;
  }

  Future<int> _editProduct(String productId, String newPrice, String newQuantity) async {
    var userId = await localStorage.getUserParam('id');
    Map<String, String> body = {
      'farmer_id': userId!,
      'product_id': productId,
      'quantity': newQuantity,
      'price': newPrice
    };
    int status = await HTTPHandler().postData('/products/update', body);
    return status;
  }

  Future<int> _deleteProduct(String productId) async {
    var userId = await localStorage.getUserParam('id');
    Map<String, String> body = {'farmer_id': userId!, 'product_id': productId};
    int status = await HTTPHandler().deleteData('/products/delete', body);
    return status;
  }

  Future _showEditProductDialog(
      context, double currentPrice, int currentQuantity) {
    quantityController.text = currentQuantity.toString();
    priceController.text = currentPrice.toString();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: subHeaderTextBlack("Edit Product"),
        content: SizedBox(
          height: 200.0,
          child: Column(
            children: [
              TextFormField(
                validator: (value) => _isFilled(value),
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  labelText: "Price",
                  hintText: priceController.text,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (value) => _isFilled(value),
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  labelText: "Quantity",
                  hintText: quantityController.text,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red.shade900),
            onPressed: () async {
              int status = await _deleteProduct(productId);
              if (!context.mounted) return;
              if (status == 200) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green.shade900,
                    content: const Text('Product deleted successfully'),
                  ),
                );
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Dashboard()));
              }
            },
            child: const Text("Delete product"),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.green.shade900),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.green.shade900,
                foregroundColor: Colors.white),
            onPressed: () async {
              int status = await _editProduct(
                  productId, priceController.text, quantityController.text);
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green.shade900,
                  content: const Text('Editing product...'),
                ),
              );
              if (status == 200) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green.shade900,
                    content: const Text('Product edited successfully'),
                  ),
                );
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Dashboard()));
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
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
                      "In stock: $quantity kgs",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
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
                        _showEditProductDialog(
                            context, double.parse(price), int.parse(quantity));
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
                            Icons.edit,
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
