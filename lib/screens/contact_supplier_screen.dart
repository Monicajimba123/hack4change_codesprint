import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ContactSupplierScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orderedItems;

  const ContactSupplierScreen({super.key, required this.orderedItems});

  @override
  Widget build(BuildContext context) {
    const supplierName = 'रामु किसान';
    const supplierPhone = '९८४१२३४५६७८';

    return Scaffold(
      appBar: AppBar(title: const Text('आपूर्तिकर्तासँग सम्पर्क गर्नुहोस्')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'अर्डर गरिएका बालीहरू:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: orderedItems.length,
                itemBuilder: (context, index) {
                  final item = orderedItems[index];
                  return ListTile(
                    leading: const Icon(Icons.shopping_bag, color: Colors.green),
                    title: Text(item['name']),
                    subtitle: Text('परिमाण: ${item['quantity']} के.जि.'),
                  );
                },
              ),
            ),
            const Divider(),
            const Text(
              'आपूर्तिकर्ता: रामु किसान\nफोन: ९८४१२३४५६७८',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('सम्पर्क सुविधा चाँडै आउँदैछ!')),
                      );
                    },
                    icon: const Icon(Icons.call),
                    label: const Text('फोन गर्नुहोस्'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatScreen(supplierName: supplierName),
                        ),
                      );
                    },
                    icon: const Icon(Icons.chat),
                    label: const Text('च्याट गर्नुहोस्'),
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