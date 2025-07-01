import 'package:flutter/material.dart';

class FarmerDetailScreen extends StatelessWidget {
  final Map<String, dynamic> crop;

  const FarmerDetailScreen({super.key, required this.crop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${crop['farmerName'] ?? "Farmer"} Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              crop['name'] ?? 'Crop',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Farmer: ${crop['farmerName'] ?? 'Unknown'}'),
            Text('Location: ${crop['location'] ?? 'Unknown'}'),
            Text('Price: Rs. ${crop['price'] ?? 'N/A'} per kg'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Return the crop to add to cart
                Navigator.pop(context, crop);
              },
              child: const Text('Add to Cart'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order placed!')),
                );
              },
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
