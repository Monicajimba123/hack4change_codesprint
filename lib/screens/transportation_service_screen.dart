import 'package:flutter/material.dart';

class TransportationServiceScreen extends StatelessWidget {
  const TransportationServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> transportOptions = [
      {
        'vehicle': 'ट्र्याक्टर',
        'driver': 'राम बहादुर',
        'location': 'चितवन',
        'contact': '9800000001',
      },
      {
        'vehicle': 'मिनी ट्रक',
        'driver': 'सुरज थापा',
        'location': 'पोखरा',
        'contact': '9800000002',
      },
      {
        'vehicle': 'भ्यान',
        'driver': 'गणेश शर्मा',
        'location': 'बुटवल',
        'contact': '9800000003',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('ढुवानी सेवा'), centerTitle: true),
      body: ListView.builder(
        itemCount: transportOptions.length,
        itemBuilder: (context, index) {
          final option = transportOptions[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.local_shipping, color: Colors.green),
              title: Text('${option['vehicle']} - ${option['driver']}'),
              subtitle: Text(
                'स्थान: ${option['location']}\nफोन: ${option['contact']}',
              ),
              isThreeLine: true,
              trailing: const Icon(Icons.phone),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${option['driver']} लाई सम्पर्क गर्नुहोस्: ${option['contact']}',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
