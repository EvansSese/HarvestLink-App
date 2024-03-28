import 'package:flutter/material.dart';
import 'package:harvestlink_app/engine/api/http_handler.dart';
import 'package:harvestlink_app/engine/storage/local_storage.dart';
import 'package:harvestlink_app/templates/constants/image.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final localStorage = LocalStorage();

  List<dynamic> orderItems = [];

  void _getOrders() async {
    var userId = await localStorage.getUserParam('id');
    Map<String, dynamic> params = {"consumer_id": userId};
    List res = await HTTPHandler().getDataWithBody('/orders', params);
    print(res);
    setState(() {
      orderItems = res;
    });
    print(orderItems.length.toString());
  }

  void _cancelOrder(String orderId) async {
    var userId = await localStorage.getUserParam('id');
    Map<String, String> params = {"consumer_id": userId!, "order_id": orderId};
    int status = await HTTPHandler().postData('/orders/cancel', params);
    if (int.parse(status.toString()) == 200) {
      _getOrders();
      setState(() {});
    }
  }

  @override
  void initState() {
    _getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (orderItems.isNotEmpty) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 24.0),
              itemCount: orderItems.length,
              itemBuilder: (context, index) {
                String _name = orderItems[index]['product_name'];
                int _quantity =
                    int.parse(orderItems[index]['quantity'].toString());
                String _productId = orderItems[index]['product_id'].toString();
                String _orderItemId = orderItems[index]['order_id'].toString();
                String _status = orderItems[index]['status'].toString();
                int _price = orderItems[index]['price'];
                int _subTotal = _price * _quantity;
                Color _statusColor;
                bool _canCancel = false;
                switch (_status) {
                  case "Pending":
                    _statusColor = Colors.orange;
                    _canCancel = true;
                  case "Accepted":
                    _statusColor = Colors.green.shade900;
                  case "Declined":
                    _statusColor = Colors.red.shade800;
                  case "Delivered":
                    _statusColor = Colors.blue.shade800;
                  default:
                    _statusColor = Colors.grey.shade700;
                }
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
                                  _name,
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
                        GestureDetector(
                          onTap: _canCancel
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      action: SnackBarAction(
                                        label: 'Ok',
                                        onPressed: () {
                                          _cancelOrder(_orderItemId);
                                        },
                                        textColor: Colors.white,
                                      ),
                                      backgroundColor: Colors.blue.shade900,
                                      content: const Text(
                                          'Do you wish to cancel order?'),
                                    ),
                                  );
                                }
                              : () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _statusColor,
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(8.0),
                                  right: Radius.circular(8.0),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  _status,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
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
                                const Text("Qty:"),
                                const SizedBox(width: 4.0),
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
      );
    } else {
      return const Center(
        child: Text("No orders yet.."),
      );
    }
  }
}
