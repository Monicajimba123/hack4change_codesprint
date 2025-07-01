import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ContactSupplierScreen extends StatefulWidget {
  final List<Map<String, dynamic>> orderedItems;

  const ContactSupplierScreen({super.key, required this.orderedItems});

  @override
  State<ContactSupplierScreen> createState() => _ContactSupplierScreenState();
}

class _ContactSupplierScreenState extends State<ContactSupplierScreen> {
  bool isNepali = true; // 🌐 Language toggle

  String getText({required String en, required String ne}) {
    return isNepali ? ne : en;
  }

  @override
  Widget build(BuildContext context) {
    const supplierName = 'रामु किसान';
    const supplierPhone = '९८४१२३४५६७८';
    const buyerName = 'खरिदकर्ता'; // Replace with dynamic if needed

    return Scaffold(
      appBar: AppBar(
        title: Text(
          getText(en: 'Contact Supplier', ne: 'आपूर्तिकर्तासँग सम्पर्क गर्नुहोस्'),
        ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getText(
                en: 'Ordered Items:',
                ne: 'अर्डर गरिएका बालीहरू:',
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.orderedItems.length,
                itemBuilder: (context, index) {
                  final item = widget.orderedItems[index];
                  return ListTile(
                    leading: const Icon(Icons.shopping_bag, color: Colors.green),
                    title: Text(item['name']),
                    subtitle: Text(
                      '${getText(en: 'Quantity', ne: 'परिमाण')}: ${item['quantity']} kg',
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Text(
              '${getText(en: 'Supplier', ne: 'आपूर्तिकर्ता')}: $supplierName\n'
              '${getText(en: 'Phone', ne: 'फोन')}: $supplierPhone',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            getText(
                              en: 'Calling feature coming soon!',
                              ne: 'सम्पर्क सुविधा चाँडै आउँदैछ!',
                            ),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.call),
                    label: Text(
                      getText(en: 'Call', ne: 'फोन गर्नुहोस्'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatScreen(
                            buyerName: buyerName,
                            sellerName: supplierName,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.chat),
                    label: Text(
                      getText(en: 'Chat', ne: 'च्याट गर्नुहोस्'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
