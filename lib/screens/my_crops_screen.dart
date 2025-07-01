import 'package:flutter/material.dart';

class MyCropsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> crops;

  const MyCropsScreen({super.key, required this.crops});

  @override
  State<MyCropsScreen> createState() => _MyCropsScreenState();
}

class _MyCropsScreenState extends State<MyCropsScreen> {
  bool isNepali = true; // ✅ Language toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isNepali ? "मेरो बालीहरू" : "My Crops"),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: isNepali ? "Switch to English" : "नेपालीमा स्विच गर्नुहोस्",
            onPressed: () {
              setState(() {
                isNepali = !isNepali;
              });
            },
          )
        ],
      ),
      body: widget.crops.isEmpty
          ? Center(
              child: Text(
                isNepali
                    ? "अहिलेसम्म कुनै बालीहरू थपिएको छैन।"
                    : "No crops added yet.",
                style: const TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: widget.crops.length,
              itemBuilder: (context, index) {
                final crop = widget.crops[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(Icons.eco, color: Colors.green),
                    title: Text(crop['name']),
                    subtitle: Text(
                      isNepali
                          ? "परिमाण: ${crop['quantity']} के.जि.\nमूल्य: रु. ${crop['price']}/के.जि."
                          : "Quantity: ${crop['quantity']} kg\nPrice: Rs. ${crop['price']}/kg",
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}
