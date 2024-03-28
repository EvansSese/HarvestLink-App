import 'package:flutter/material.dart';
import 'package:harvestlink_app/engine/api/http_handler.dart';
import 'package:harvestlink_app/features/auth/views/login.dart';
import 'package:harvestlink_app/features/consumer/views/orders.dart';
import 'package:harvestlink_app/features/consumer/views/show_products.dart';
import 'package:harvestlink_app/features/consumer/widgets/app_bar.dart';
import 'package:harvestlink_app/features/consumer/widgets/category_tile.dart';
import 'package:harvestlink_app/features/consumer/widgets/home_app_bar.dart';
import 'package:harvestlink_app/features/consumer/widgets/product_card_vertical.dart';
import 'package:harvestlink_app/features/consumer/widgets/search_container.dart';
import 'package:harvestlink_app/navigation_bar.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';
import 'package:harvestlink_app/templates/constants/image.dart';
import 'package:harvestlink_app/features/consumer/views/cart.dart';
import 'package:harvestlink_app/engine/storage/local_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  void refreshCartBadge() {
    createState() => _HomePageState();
  }
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final localStorage = LocalStorage();
  List<dynamic> cartData = [];

  int navIndex = 0;
  List allProducts = [];
  bool _isLoggedIn = false;

  void getData() async {
    List res = await HTTPHandler().getData('/');
    setState(() {
      allProducts = res;
    });
  }

  Future<void> _getUser() async {
    if (await localStorage.getIsLoggedIn()) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  Future<void> _logOut() async {
    await localStorage.setIsLoggedIn(false);
    _getUser();
  }

  void _getCartItems() async {
    var userId = await localStorage.getUserParam('id');
    Map<String, dynamic> params = {"consumer_id": userId};
    List res = await HTTPHandler().getDataWithBody('/cart', params);
    print(res);
    setState(() {
      cartData = res;
    });
    print(cartData.length.toString());
  }


  @override
  void initState() {
    getData();
    _getUser();
    _getCartItems();
    super.initState();
  }

  Widget _getPage(int index, screenSize) {
    switch (index) {
      case 0:
        return ShowProducts(screenSize: screenSize, allProducts: allProducts);
      case 1:
        return const Center(child: Text('Market Page'));
      case 2:
        return const OrdersPage();
      case 3:
        return Center(
          child: Column(
            children: [
              const Text('Profile Page'),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  localStorage.setIsLoggedIn(false);
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (builder)=> const LoginScreen()));
                },
                child: const Text("Logout"),
              ),
            ],
          ),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    int _cartCount = 0;
    if (cartData.isNotEmpty){
      _cartCount = cartData[0]['cart_items'].length;
    }

    return Scaffold(
      appBar: ConsumerAppBar(
        appBarHeight: screenSize.height * 0.08,
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
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Cart()));
                },
                icon: const Icon(Icons.shopping_basket),
              ),
              (_cartCount != 0) ? Positioned(
                right: 5,
                top: 5,
                child: Container(
                  width: 18.0,
                  height: 18.0,
                  decoration: BoxDecoration(
                    color: Colors.green.shade900,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      _cartCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
              ) : const SizedBox(),
            ],
          )
        ],
      ),
      body: _getPage(navIndex, screenSize),
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
            icon: Icon(Icons.store),
            label: 'Market',
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
