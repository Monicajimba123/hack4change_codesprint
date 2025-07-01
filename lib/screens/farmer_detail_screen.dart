import 'package:flutter/material.dart';

class FarmerDetailScreen extends StatefulWidget {
  final Map<String, dynamic> crop;

  const FarmerDetailScreen({super.key, required this.crop});

  @override
  State<FarmerDetailScreen> createState() => _FarmerDetailScreenState();
}

class _FarmerDetailScreenState extends State<FarmerDetailScreen> {
  bool isNepali = true; // Language toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNepali
              ? '${widget.crop['farmerName'] ?? "कृषक"} प्रोफाइल'
              : '${widget.crop['farmerName'] ?? "Farmer"} Profile',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: isNepali ? 'Switch to English' : 'नेपालीमा स्विच गर्नुहोस्',
            onPressed: () {
              setState(() {
                isNepali = !isNepali;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.crop['name'] ?? (isNepali ? 'बाली' : 'Crop'),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              isNepali
                  ? 'कृषक: ${widget.crop['farmerName'] ?? 'अज्ञात'}'
                  : 'Farmer: ${widget.crop['farmerName'] ?? 'Unknown'}',
            ),
            Text(
              isNepali
                  ? 'ठेगाना: ${widget.crop['location'] ?? 'अज्ञात'}'
                  : 'Location: ${widget.crop['location'] ?? 'Unknown'}',
            ),
            Text(
              isNepali
                  ? 'मूल्य: रु. ${widget.crop['price'] ?? 'N/A'} प्रति के.जि.'
                  : 'Price: Rs. ${widget.crop['price'] ?? 'N/A'} per kg',
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, widget.crop);
              },
              child: Text(isNepali ? 'कार्टमा थप्नुहोस्' : 'Add to Cart'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isNepali ? 'अर्डर सफलतापूर्वक गरियो!' : 'Order placed successfully!',
                    ),
                  ),
                );
              },
              child: Text(isNepali ? 'अर्डर गर्नुहोस्' : 'Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
