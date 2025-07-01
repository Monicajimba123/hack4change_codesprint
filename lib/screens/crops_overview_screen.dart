import 'package:flutter/material.dart';

class CropsOverviewScreen extends StatefulWidget {
  const CropsOverviewScreen({super.key});

  @override
  State<CropsOverviewScreen> createState() => _CropsOverviewScreenState();
}

class _CropsOverviewScreenState extends State<CropsOverviewScreen> {
  List<Map<String, dynamic>> crops = [];
  bool isLoading = true;
  bool isNepali = false; // 🔥 Language toggle state

  @override
  void initState() {
    super.initState();
    _fetchCrops();
  }

  Future<void> _fetchCrops() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      crops = [
        {
          'name': 'Tomato',
          'name_ne': 'गोलभेंडा',
          'price': 80,
          'quantity': 50,
          'farmer': 'Sita Farmer',
          'farmer_ne': 'सिता किसान',
        },
        {
          'name': 'Cabbage',
          'name_ne': 'बन्दगोभी',
          'price': 60,
          'quantity': 30,
          'farmer': 'Ram Supplier',
          'farmer_ne': 'राम सप्लायर',
        },
      ];
      isLoading = false;
    });
  }

  /// 🔥 Translation function
  String tr(String en, String ne) {
    return isNepali ? ne : en;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('Crops Overview', 'बालीहरूको अवलोकन')),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: tr('Switch Language', 'भाषा परिवर्तन गर्नुहोस्'),
            onPressed: () {
              setState(() {
                isNepali = !isNepali;
              });
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : crops.isEmpty
              ? Center(child: Text(tr('No crops listed.', 'कुनै बाली सूचीबद्ध छैन।')))
              : ListView.builder(
                  itemCount: crops.length,
                  itemBuilder: (context, index) {
                    final crop = crops[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.eco, color: Colors.green),
                        title: Text(tr(crop['name'], crop['name_ne'])),
                        subtitle: Text(
                          "${tr('Farmer', 'किसान')}: ${tr(crop['farmer'], crop['farmer_ne'])}\n"
                          "${tr('Quantity', 'परिमाण')}: ${crop['quantity']} kg\n"
                          "${tr('Price', 'मूल्य')}: Rs. ${crop['price']}/kg",
                        ),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
    );
  }
}
