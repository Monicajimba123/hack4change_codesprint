import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  // Static order list (replace with DB data later)
  final List<Map<String, dynamic>> orders = const [
    {
      'orderId': 'ORD123',
      'date': '2025-06-20',
      'items': ['Tomato', 'Potato'],
      'total': 320
    },
    {
      'orderId': 'ORD124',
      'date': '2025-06-21',
      'items': ['Onion'],
      'total': 90
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: orders.isEmpty
            ? const Center(child: Text('You have not placed any orders yet.'))
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.receipt_long,
                          color: Colors.orange),
                      title: Text('Order #${order['orderId']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${order['date']}'),
                          Text('Items: ${order['items'].join(', ')}'),
                          Text('Total: Rs. ${order['total']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
