import 'package:flutter/material.dart';

class SmartCropRecommendationScreen extends StatefulWidget {
  const SmartCropRecommendationScreen({super.key});

  @override
  State<SmartCropRecommendationScreen> createState() =>
      _SmartCropRecommendationScreenState();
}

class _SmartCropRecommendationScreenState
    extends State<SmartCropRecommendationScreen> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController soilController = TextEditingController();
  final TextEditingController waterController = TextEditingController();
  String recommendation = '';

  void generateRecommendation() {
    String soil = soilController.text.toLowerCase();
    String water = waterController.text.toLowerCase();

    String result = 'मकै'; // Default recommendation

    if (soil.contains('लोम') && water.contains('धेरै')) {
      result = 'धान';
    } else if (soil.contains('बालु') && water.contains('कम')) {
      result = 'गहुँ';
    } else if (soil.contains('कालो')) {
      result = 'आलु';
    } else if (soil.contains('चिकन') || soil.contains('clay')) {
      if (water.contains('मध्यम') || water.contains('कम')) {
        result = 'चना';
      } else {
        result = 'तेलहन';
      }
    } else if (soil.contains('रेतीलो') || soil.contains('sand')) {
      if (water.contains('कम')) {
        result = 'कागती';
      } else {
        result = 'खरबुजा';
      }
    } else if (soil.contains('पानीलो') || soil.contains('moist')) {
      result = 'काँक्रो';
    } else if (soil.contains('छोटो') ||
        soil.contains('शुष्क') ||
        water.contains('कम')) {
      result = 'मसुरो';
    } else if (soil.contains('पर्वतीय') ||
        locationController.text.toLowerCase().contains('पहाड')) {
      result = 'कोदो';
    } else if (locationController.text.toLowerCase().contains('तराई')) {
      result = 'गन्ना';
    }

    setState(() {
      recommendation = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('स्मार्ट बाली सिफारिस'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'स्थान'),
            ),
            TextField(
              controller: soilController,
              decoration: const InputDecoration(labelText: 'माटोको प्रकार'),
            ),
            TextField(
              controller: waterController,
              decoration: const InputDecoration(labelText: 'पानी उपलब्धता'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateRecommendation,
              child: const Text('सिफारिस हेर्नुहोस्'),
            ),
            const SizedBox(height: 20),
            if (recommendation.isNotEmpty)
              Text(
                '📌 सिफारिस बाली: $recommendation',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
