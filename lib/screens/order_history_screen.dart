import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  bool isNepali = true; // ✅ Language toggle

  // ✅ Static order list (replace with DB data later)
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
        title:
            Text(isNepali ? 'अर्डर इतिहास' : 'Order History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: isNepali ? 'Switch to English' : 'नेपालीमा स्विच गर्नुहोस्',
            onPressed: () {
              setState(() {
                isNepali = !isNepali;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: orders.isEmpty
            ? Center(
                child: Text(
                  isNepali
                      ? 'तपाईंले हालसम्म कुनै अर्डर गर्नुभएको छैन।'
                      : 'You have not placed any orders yet.',
                  style: const TextStyle(fontSize: 16),
                ),
              )
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
                      leading: const Icon(
                        Icons.receipt_long,
                        color: Colors.orange,
                      ),
                      title: Text(
                        isNepali
                            ? 'अर्डर #${order['orderId']}'
                            : 'Order #${order['orderId']}',
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isNepali
                                ? 'मिति: ${order['date']}'
                                : 'Date: ${order['date']}',
                          ),
                          Text(
                            isNepali
                                ? 'वस्तुहरू: ${order['items'].join(', ')}'
                                : 'Items: ${order['items'].join(', ')}',
                          ),
                          Text(
                            isNepali
                                ? 'जम्मा: रु. ${order['total']}'
                                : 'Total: Rs. ${order['total']}',
                          ),
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
