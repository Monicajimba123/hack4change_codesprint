import 'package:flutter/material.dart';

class CropsOverviewScreen extends StatefulWidget {
  const CropsOverviewScreen({super.key});

  @override
  State<CropsOverviewScreen> createState() => _CropsOverviewScreenState();
}

class _CropsOverviewScreenState extends State<CropsOverviewScreen> {
  List<Map<String, dynamic>> crops = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCrops(); // Simulated fetch for now
  }

  Future<void> _fetchCrops() async {
    await Future.delayed(const Duration(seconds: 2));

    // TODO: Replace this with your backend fetch (Firebase, Supabase, etc.)
    setState(() {
      crops = [
        {
          'name': 'Tomato',
          'price': 80,
          'quantity': 50,
          'farmer': 'Sita Farmer',
        },
        {
          'name': 'Cabbage',
          'price': 60,
          'quantity': 30,
          'farmer': 'Ram Supplier',
        },
      ];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crops Overview')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : crops.isEmpty
              ? const Center(child: Text("No crops listed."))
              : ListView.builder(
                  itemCount: crops.length,
                  itemBuilder: (context, index) {
                    final crop = crops[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.eco, color: Colors.green),
                        title: Text(crop['name']),
                        subtitle: Text(
                          "Farmer: ${crop['farmer']}\n"
                          "Quantity: ${crop['quantity']} kg\n"
                          "Price: Rs. ${crop['price']}/kg",
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
    );
  }
}
