import 'package:flutter/material.dart';
import 'package:harvestlink_app/engine/api/http_handler.dart';
import 'package:harvestlink_app/engine/storage/local_storage.dart';
import 'package:harvestlink_app/features/auth/views/profile.dart';
import 'package:harvestlink_app/features/farmer/views/orders.dart';
import 'package:harvestlink_app/features/farmer/views/products.dart';
import 'package:harvestlink_app/features/farmer/widgets/app_bar.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final localStorage = LocalStorage();
  int navIndex = 0;

  _isFilled(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter information';
    }
    return null;
  }

  Future<int> _addProduct(String name, String category, String price,
      String location, String quantity) async {
    var userId = await localStorage.getUserParam('id');
    Map<String, String> body = {
      'farmer_id': userId!,
      'name': name,
      'category': category,
      'price': price,
      'location': location,
      'quantity': quantity
    };
    int status = await HTTPHandler().postData('/products/add', body);
    return status;
  }

  Future _showAddProductDialog(context) {
    final _formKey = GlobalKey<FormState>();

    final nameController = TextEditingController();
    String categoryController = "";
    final priceController = TextEditingController();
    final locationController = TextEditingController();
    final quantityController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: subHeaderTextBlack("Add Product"),
        content: SingleChildScrollView(
          child: SizedBox(
            height: 400,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) => _isFilled(value),
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    validator: (value) => _isFilled(value),
                    decoration: const InputDecoration(
                      labelText: "Choose category",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (item) {
                      categoryController = item!;
                    },
                    items: <String>[
                      'Cereals',
                      'Vegetables',
                      'Fruits',
                      'Meat',
                      'Milk',
                      'Eggs',
                      'Fish'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    validator: (value) => _isFilled(value),
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Price",
                      hintText: quantityController.text,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    validator: (value) => _isFilled(value),
                    controller: locationController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Location",
                      hintText: quantityController.text,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    validator: (value) => _isFilled(value),
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Quantity",
                      hintText: quantityController.text,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
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
              if (_formKey.currentState!.validate()) {
                String _name = nameController.text;
                String _category = categoryController;
                String _price = priceController.text;
                String _location = locationController.text;
                String _quantity = quantityController.text;

                int status = await _addProduct(_name, _category, _price, _location, _quantity);
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green.shade900,
                    content: const Text('Adding product...'),
                  ),
                );
                Navigator.pop(context);
                if (status == 201) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green.shade900,
                      content: const Text('Product added successfully'),
                    ),
                  );
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Dashboard()));
                }
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Widget _getPage(int index, screenSize) {
    switch (index) {
      case 0:
        return const MyProducts();
      case 1:
        return const FarmerOrders();
      case 2:
        return const Profile();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: FarmerAppBar(
        appBarHeight: screenSize.height * 0.08,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerTextBlack("HarvestLink"),
          ],
        ),
      ),
      body: _getPage(navIndex, screenSize),
      floatingActionButton: navIndex == 0
          ? FloatingActionButton(
              shape: const StadiumBorder(),
              backgroundColor: Colors.green.shade900,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                _showAddProductDialog(context);
              },
            )
          : null,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.green.shade100,
        indicatorColor: Colors.green.shade500,
        selectedIndex: navIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            navIndex = index;
          });
        },
      ),
    );
  }
}
