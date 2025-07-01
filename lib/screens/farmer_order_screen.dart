import 'package:flutter/material.dart';
import '../utils/order_store.dart';

class FarmerOrderScreen extends StatefulWidget {
  const FarmerOrderScreen({super.key});

  @override
  State<FarmerOrderScreen> createState() => _FarmerOrderScreenState();
}

class _FarmerOrderScreenState extends State<FarmerOrderScreen> {
  bool isNepali = true; // Language toggle

  @override
  Widget build(BuildContext context) {
    final List<String> verifiedBuyers = ['Ramesh', 'Sita', 'buyer123'];
    final List<Map<String, dynamic>> orders = List.from(OrderStore.getOrders());

    return Scaffold(
      appBar: AppBar(
        title: Text(isNepali ? "अर्डरहरू" : "Orders"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: isNepali ? "Switch to English" : "नेपालीमा स्विच गर्नुहोस्",
            onPressed: () {
              setState(() {
                isNepali = !isNepali;
              });
            },
          ),
        ],
      ),
      body: orders.isEmpty
          ? Center(
              child: Text(
                isNepali
                    ? "अहिलेसम्म कुनै अर्डर गरिएको छैन।"
                    : "No orders placed yet.",
                style: const TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                final String buyerName =
                    (order['buyerName'] ?? '').toString().trim();
                final bool isVerified = verifiedBuyers.contains(buyerName);

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      Icons.shopping_cart,
                      color: Colors.green.shade700,
                    ),
                    title: Text(order['crop'] ?? ''),
                    subtitle: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: isNepali
                                ? "ग्राहक: $buyerName"
                                : "Buyer: $buyerName",
                          ),
                          if (isVerified)
                            TextSpan(
                              text: isNepali ? "  ✔ प्रमाणित" : "  ✔ Verified",
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          const TextSpan(text: "\n"),
                          TextSpan(
                            text: isNepali
                                ? "परिमाण: ${order['quantity'] ?? ''}\n"
                                : "Quantity: ${order['quantity'] ?? ''}\n",
                          ),
                          TextSpan(
                            text: isNepali
                                ? "स्थिति: ${order['status'] ?? ''}"
                                : "Status: ${order['status'] ?? ''}",
                          ),
                        ],
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      tooltip: isNepali ? "हटाउनुहोस्" : "Delete",
                      onPressed: () {
                        OrderStore.removeOrderAt(index);
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
