import 'package:flutter/material.dart';
import 'package:harvestlink_app/engine/api/http_handler.dart';
import 'package:harvestlink_app/engine/storage/local_storage.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';
import 'package:harvestlink_app/templates/constants/image.dart';

class FarmerOrders extends StatefulWidget {
  const FarmerOrders({super.key});

  @override
  State<FarmerOrders> createState() => _FarmerOrdersState();
}

class _FarmerOrdersState extends State<FarmerOrders> {
  final localStorage = LocalStorage();

  List<dynamic> orderItems = [];

  _isFilled(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter information';
    }
    return null;
  }

  void _getOrders() async {
    var userId = await localStorage.getUserParam('id');
    Map<String, dynamic> params = {"farmer_id": userId};
    List res = await HTTPHandler().getDataWithBody('/farmer/orders', params);
    setState(() {
      orderItems = res;
    });
  }

  Future<int> _processOrder(String orderId, String action) async {
    var userId = await localStorage.getUserParam('id');
    Map<String, String> params = {"farmer_id": userId!, "order_id": orderId};
    int status = await HTTPHandler().postData('/farmer/orders/$action', params);
    if (status == 200) {
      _getOrders();
      setState(() {});
    }
    return status;
  }

  Future _showEditProductDialog(
      context,
      String consumerName,
      String consumerPhone,
      List<String> options,
      String orderId,
      String orderStatus) {
    String statusController = '';

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: subHeaderTextBlack("Process Order"),
        content: SizedBox(
          height: 200.0,
          child: Column(
            children: [
              Column(
                children: [
                  const Text("Consumer info"),
                  const SizedBox(height: 10.0),
                  Text(
                    consumerName,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(consumerPhone),
                ],
              ),
              const SizedBox(height: 20.0),
              (options.isNotEmpty)
                  ? DropdownButtonFormField(
                      validator: (value) => _isFilled(value),
                      decoration: const InputDecoration(
                        labelText: "Choose action",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (item) {
                        statusController = item!;
                      },
                      items: options.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value.toLowerCase(),
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  : Column(
                      children: [
                        Text("This order has been $orderStatus"),
                        const SizedBox(height: 10.0),
                        const Text("No further action needed"),
                      ],
                    ),
            ],
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
              int status = await _processOrder(orderId, statusController);
              if (status == 200) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green.shade900,
                    content: Text(
                        'The order has been $statusController'),
                  ),
                );
                Navigator.pop(context);
                setState(() {});
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (orderItems.isNotEmpty)
        ? SingleChildScrollView(
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
                    String _productId =
                        orderItems[index]['product_id'].toString();
                    String _orderItemId =
                        orderItems[index]['order_id'].toString();
                    String _status = orderItems[index]['status'].toString();
                    int _price = orderItems[index]['price'];
                    int _subTotal = _price * _quantity;
                    Color _statusColor;
                    bool _canEdit = false;
                    List<String> _options = [];
                    switch (_status) {
                      case "Pending":
                        _statusColor = Colors.orange;
                        _canEdit = true;
                        _options.addAll(<String>['Accept', 'Decline']);
                      case "Accepted":
                        _statusColor = Colors.green.shade900;
                        _canEdit = true;
                        _options.add('Deliver');
                      case "Declined":
                        _statusColor = Colors.red.shade800;
                      case "Delivered":
                        _statusColor = Colors.blue.shade800;
                      default:
                        _statusColor = Colors.grey.shade700;
                    }
                    return GestureDetector(
                      onTap: () {
                        _showEditProductDialog(
                            context,
                            orderItems[index]['consumer_name'],
                            orderItems[index]['consumer_phone'],
                            _options,
                            _orderItemId,
                            _status);
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(
                                    "${HLImage.imgBaseUrl}$_name.jpg"),
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
                              Padding(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
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
                      ),
                    );
                  }),
            ),
          )
        : const Center(
            child: Text("No orders yet"),
          );
  }
}
