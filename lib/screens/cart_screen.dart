import 'package:flutter/material.dart';
import 'contact_supplier_screen.dart';

class MyCartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const MyCartScreen({super.key, required this.cartItems});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  bool isNepali = true; // 🌐 Language toggle

  String getText({required String en, required String ne}) {
    return isNepali ? ne : en;
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    for (var item in widget.cartItems) {
      totalPrice += item['quantity'] * item['price'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(getText(en: 'My Cart', ne: 'मेरो कार्ट')),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              setState(() {
                isNepali = !isNepali;
              });
            },
            tooltip: getText(en: 'Language', ne: 'भाषा'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: widget.cartItems.isEmpty
                  ? Center(
                      child: Text(
                        getText(
                          en: 'Your cart is empty.',
                          ne: 'तपाईंको कार्ट खाली छ।',
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: widget.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = widget.cartItems[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.shopping_cart,
                              color: Colors.green,
                            ),
                            title: Text(item['name']),
                            subtitle: Text(
                              '${getText(en: 'Quantity', ne: 'परिमाण')}: ${item['quantity']} kg\n'
                              '${getText(en: 'Price', ne: 'मूल्य')}: रु. ${item['price']} ${getText(en: 'per kg', ne: 'प्रति के.जि.')}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'रु. ${item['quantity'] * item['price']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      widget.cartItems.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
            if (widget.cartItems.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    const Divider(thickness: 1.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getText(en: 'Total', ne: 'कुल'),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'रु. $totalPrice',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                getText(
                                  en: 'Order placed successfully!',
                                  ne: 'अर्डर सफलतापूर्वक गरियो!',
                                ),
                              ),
                            ),
                          );
                          Future.delayed(const Duration(milliseconds: 500), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactSupplierScreen(
                                  orderedItems: List.from(widget.cartItems),
                                ),
                              ),
                            );
                          });
                        },
                        icon: const Icon(Icons.check_circle_outline),
                        label: Text(
                          getText(en: 'Place Order', ne: 'अर्डर गर्नुहोस्'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
