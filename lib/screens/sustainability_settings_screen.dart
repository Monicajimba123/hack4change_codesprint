import 'package:flutter/material.dart';

class SustainabilitySettingsScreen extends StatefulWidget {
  const SustainabilitySettingsScreen({super.key});

  @override
  State<SustainabilitySettingsScreen> createState() =>
      _SustainabilitySettingsScreenState();
}

class _SustainabilitySettingsScreenState
    extends State<SustainabilitySettingsScreen> {
  bool organicFarming = false;
  bool waterConservation = false;
  bool renewableEnergy = false;

  void saveSettings() {
    // Here you can add actual save logic if needed.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('दिगो अभ्यासहरू अपडेट गरियो')),
    );
    Navigator.pop(context); // Go back after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('दिगोपन सम्बन्धी सेटिङहरू')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckboxListTile(
              title: const Text('जैविक कृषि'),
              value: organicFarming,
              onChanged: (bool? value) {
                setState(() {
                  organicFarming = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('पानी संरक्षण'),
              value: waterConservation,
              onChanged: (bool? value) {
                setState(() {
                  waterConservation = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('नवीकरणीय ऊर्जा प्रयोग'),
              value: renewableEnergy,
              onChanged: (bool? value) {
                setState(() {
                  renewableEnergy = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveSettings,
              child: const Text('दिगो अभ्यासहरू सुरक्षित गर्नुहोस्'),
            ),
          ],
        ),
      ),
    );
  }
}