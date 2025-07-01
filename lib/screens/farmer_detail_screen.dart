import 'package:flutter/material.dart';

class FarmerDetailScreen extends StatelessWidget {
  final Map<String, dynamic> crop;

  const FarmerDetailScreen({super.key, required this.crop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${crop['farmerName'] ?? "कृषक"} प्रोफाइल'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              crop['name'] ?? 'बाली',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('कृषक: ${crop['farmerName'] ?? 'अज्ञात'}'),
            Text('ठेगाना: ${crop['location'] ?? 'अज्ञात'}'),
            Text('मूल्य: रु. ${crop['price'] ?? 'N/A'} प्रति के.जि.'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Return the crop to add to cart
                Navigator.pop(context, crop);
              },
              child: const Text('कार्टमा थप्नुहोस्'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('अर्डर सफलतापूर्वक गरियो!')),
                );
              },
              child: const Text('अर्डर गर्नुहोस्'),
            ),
          ],
        ),
      ),
    );
  }
}