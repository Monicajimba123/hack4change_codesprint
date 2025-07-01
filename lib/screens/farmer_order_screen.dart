import 'package:flutter/material.dart';

class FarmerOrderScreen extends StatelessWidget {
  const FarmerOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This will be replaced by actual orders fetched from the database
    final List<Map<String, dynamic>> orders = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: orders.isEmpty
          ? const Center(
              child: Text(
                "No orders have been placed yet.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.shopping_cart, color: Colors.green),
                    title: Text(order['crop'] ?? ''),
                    subtitle: Text(
                      "Buyer: ${order['buyerName'] ?? ''}\n"
                      "Quantity: ${order['quantity'] ?? ''}\n"
                      "Status: ${order['status'] ?? ''}",
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}
