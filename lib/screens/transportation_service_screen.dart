import 'package:flutter/material.dart';

class TransportationServiceScreen extends StatefulWidget {
  const TransportationServiceScreen({super.key});

  @override
  State<TransportationServiceScreen> createState() =>
      _TransportationServiceScreenState();
}

class _TransportationServiceScreenState
    extends State<TransportationServiceScreen> {
  final List<Map<String, String>> allTransportOptions = [
    {
      'vehicle': 'ट्र्याक्टर',
      'driver': 'राम बहादुर',
      'location': 'चितवन',
      'contact': '9800000001',
      'type': 'ट्र्याक्टर',
    },
    {
      'vehicle': 'मिनी ट्रक',
      'driver': 'सुरज थापा',
      'location': 'पोखरा',
      'contact': '9800000002',
      'type': 'ट्रक',
    },
    {
      'vehicle': 'भ्यान',
      'driver': 'गणेश शर्मा',
      'location': 'बुटवल',
      'contact': '9800000003',
      'type': 'भ्यान',
    },
    {
      'vehicle': 'ट्रक',
      'driver': 'संदीप काफ्ले',
      'location': 'काठमाडौं',
      'contact': '9800000004',
      'type': 'ट्रक',
    },
  ];

  String? selectedType;

  @override
  Widget build(BuildContext context) {
    // Filter options by selectedType, if selected
    List<Map<String, String>> filteredOptions = selectedType == null
        ? allTransportOptions
        : allTransportOptions
              .where((option) => option['type'] == selectedType)
              .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('ढुवानी सेवा'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'यातायातको प्रकार छान्नुहोस्',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              value: selectedType,
              items: <String>['ट्र्याक्टर', 'ट्रक', 'भ्यान']
                  .map(
                    (type) => DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                });
              },
              isExpanded: true,
              hint: const Text('सबै प्रकारहरू देखाउन खाली छोड्नुहोस्'),
              // Allow clearing selection by tapping an "All" option or null
            ),
          ),
          Expanded(
            child: filteredOptions.isEmpty
                ? const Center(child: Text('यो प्रकारका यातायात उपलब्ध छैन।'))
                : ListView.builder(
                    itemCount: filteredOptions.length,
                    itemBuilder: (context, index) {
                      final option = filteredOptions[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.local_shipping,
                            color: Colors.green,
                          ),
                          title: Text(
                            '${option['vehicle']} - ${option['driver']}',
                          ),
                          subtitle: Text(
                            'स्थान: ${option['location']}\nफोन: ${option['contact']}',
                          ),
                          isThreeLine: true,
                          trailing: ElevatedButton(
                            child: const Text('बुक गर्नुहोस्'),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'तपाईंले ${option['vehicle']} बुक गर्नुभयो। चालक: ${option['driver']} लाई सम्पर्क गर्नुहोस्।',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
