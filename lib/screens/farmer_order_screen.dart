import 'package:flutter/material.dart';
import '../utils/order_store.dart'; // Adjust this import if needed

class FarmerOrderScreen extends StatelessWidget {
  const FarmerOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Mock list of verified buyers
    final List<String> verifiedBuyers = ['Ramesh', 'Sita', 'buyer123'];

    // ✅ Get current orders
    final List<Map<String, dynamic>> orders = List.from(OrderStore.getOrders());

    return Scaffold(
      appBar: AppBar(title: const Text("अर्डरहरू"), centerTitle: true),
      body: orders.isEmpty
          ? const Center(
              child: Text(
                "अहिलेसम्म कुनै अर्डर गरिएको छैन।",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                // ✅ Safely extract buyer name
                final String buyerName = (order['buyerName'] ?? '')
                    .toString()
                    .trim();
                final bool isVerified = verifiedBuyers.contains(buyerName);

                // ✅ Debug print
                print("DEBUG: Buyer: $buyerName, Verified: $isVerified");

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.shopping_cart,
                      color: Colors.green,
                    ),
                    title: Text(order['crop'] ?? ''),
                    subtitle: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "ग्राहक: $buyerName"),
                          if (isVerified)
                            const TextSpan(
                              text: "  ✔ प्रमाणित",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          const TextSpan(text: "\n"),
                          TextSpan(
                            text: "परिमाण: ${order['quantity'] ?? ''}\n",
                          ),
                          TextSpan(text: "स्थिति: ${order['status'] ?? ''}"),
                        ],
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // ✅ Remove order
                        OrderStore.removeOrderAt(index);

                        // ✅ Rebuild screen
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                const FarmerOrderScreen(),
                            transitionDuration: Duration.zero,
                          ),
                        );
                      },
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}