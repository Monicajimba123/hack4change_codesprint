import 'package:flutter/material.dart';

class MyCropsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> crops;

  const MyCropsScreen({super.key, required this.crops});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("मेरो बालीहरू")),
      body: crops.isEmpty
          ? const Center(child: Text("अहिलेसम्म कुनै बालीहरू थपिएको छैन।"))
          : ListView.builder(
              itemCount: crops.length,
              itemBuilder: (context, index) {
                final crop = crops[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(Icons.eco, color: Colors.green),
                    title: Text(crop['name']),
                    subtitle: Text(
                      "परिमाण: ${crop['quantity']} के.जि.\nमूल्य: रु. ${crop['price']}/के.जि.",
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            ),
    );
  }
}