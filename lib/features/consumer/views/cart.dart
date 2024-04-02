import 'package:flutter/material.dart';
import 'package:harvestlink_app/engine/api/http_handler.dart';
import 'package:harvestlink_app/features/consumer/views/home.dart';
import 'package:harvestlink_app/features/consumer/widgets/app_bar.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';
import 'package:harvestlink_app/templates/constants/image.dart';
import 'package:harvestlink_app/engine/storage/local_storage.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final localStorage = LocalStorage();
  List<dynamic> cartData = [];

  late int subTotal;

  void _getCartItems() async {
    var userId = await localStorage.getUserParam('id');
    Map<String, dynamic> params = {"consumer_id": userId};
    List res = await HTTPHandler().getDataWithBody('/cart', params);
    setState(() {
      cartData = res;
    });
  }

  void _updateCartItem(String productId, int quantity) async {
    var userId = await localStorage.getUserParam('id');
    Map<String, String> body = {
      'consumer_id': userId!,
      'product_id': productId,
      'new_quantity': quantity.toString()
    };
    int status = await HTTPHandler().postData('/cart', body);
    if (int.parse(status.toString()) == 200) {
      _getCartItems();
    }
  }

  void _deleteCartItem(String cartItemId) async {
    var userId = await localStorage.getUserParam('id');
    Map<String, String> body = {
      'consumer_id': userId!,
      'cart_item_id': cartItemId,
    };
    int status = await HTTPHandler().deleteData('/cart/delete', body);
    if (int.parse(status.toString()) == 200) {
      _getCartItems();
    }
  }

  Future<bool> _checkOut() async {
    var userId = await localStorage.getUserParam('id');
    var userLocation = await localStorage.getUserParam('location');
    Map<String, String> body = {
      'consumer_id': userId!,
      'consumer_location': userLocation!
    };
    int status = await HTTPHandler().postData('/place_order', body);
    if (int.parse(status.toString()) == 200) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    _getCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (cartData[0]['cart_items'].isEmpty) {
      return Scaffold(
        appBar: ConsumerAppBar(
          appBarHeight: screenSize.height * 0.08,
          title: headerTextBlack("Cart"),
        ),
        body: const Center(
          child: Text("Your cart is empty"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: screenSize.height * 0.06,
            width: screenSize.width * 0.9,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade900,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Go shopping",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      final cart = cartData[0];
      final cartItems =
          (cart['cart_items'] as List<dynamic>).cast<Map<String, dynamic>>();
      final totalCost = cart['total_cost'];

      return Scaffold(
        appBar: ConsumerAppBar(
          appBarHeight: screenSize.height * 0.08,
          title: headerTextBlack("Cart"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 24.0),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                String _name = cartItems[index]['name'];
                int _quantity =
                    int.parse(cartItems[index]['quantity'].toString());
                String _productId = cartItems[index]['product_id'].toString();
                String _cartItemId =
                    cartItems[index]['cart_item_id'].toString();
                double _price = cartItems[index]['price'];
                double _subTotal = _price * _quantity;
                return Column(
                  children: [
                    Row(
                      children: [
                        Image(
                          height: 50,
                          width: 50,
                          image:
                              NetworkImage("${HLImage.imgBaseUrl}$_name.jpg"),
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 24.0),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Kes $_price /kg',
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  const SizedBox(width: 2.0),
                                  Icon(
                                    Icons.check_circle,
                                    size: 14.0,
                                    color: Colors.green.shade900,
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Text(
                                  cartItems[index]['name'],
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 74.0),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade400,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_quantity > 1) {
                                        var newQuantity = _quantity - 1;
                                        _updateCartItem(
                                            _productId, newQuantity);
                                        setState(() {});
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            action: SnackBarAction(
                                              label: 'YES',
                                              onPressed: () {
                                                _deleteCartItem(_cartItemId);
                                              },
                                              textColor: Colors.white,
                                            ),
                                            backgroundColor:
                                                Colors.red.shade900,
                                            content: const Text(
                                                'Remove item from cart? '),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                    ),
                                  ),
                                  child: Text(
                                    _quantity.toString(),
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade900,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      var newQuantity = _quantity + 1;
                                      _updateCartItem(_productId, newQuantity);
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
                            const SizedBox(width: 8.0),
                            Text(
                              _subTotal.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: screenSize.height * 0.06,
            width: screenSize.width * 0.9,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade900,
              ),
              onPressed: () async {
                bool _placed = await _checkOut();
                if (_placed) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      action: SnackBarAction(
                        label: 'Ok',
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        },
                        textColor: Colors.white,
                      ),
                      backgroundColor: Colors.green.shade900,
                      content: const Text('Order placed Successfully'),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Checkout - ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Text(
                    "Kes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    totalCost.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
