import 'package:flutter/material.dart';

class SmartCropRecommendationScreen extends StatefulWidget {
  const SmartCropRecommendationScreen({super.key});

  @override
  State<SmartCropRecommendationScreen> createState() =>
      _SmartCropRecommendationScreenState();
}

class _SmartCropRecommendationScreenState
    extends State<SmartCropRecommendationScreen> {
  String? selectedSoilType;
  String? selectedWaterLevel;
  String? selectedRegion;

  String soilBasedCrop = '';
  String waterBasedCrop = '';
  String regionBasedCrop = '';

  final List<String> soilTypes = [
    'लोम',
    'कालो',
    'चिकन',
    'रेतीलो',
    'पानीलो',
    'बालु',
  ];

  final List<String> waterLevels = ['धेरै', 'मध्यम', 'कम'];

  final List<String> regions = ['तराई', 'पहाड', 'हिमाल'];

  void generateRecommendations() {
    // Soil-based crop
    if (selectedSoilType == 'लोम') {
      soilBasedCrop = 'धान';
    } else if (selectedSoilType == 'कालो') {
      soilBasedCrop = 'आलु';
    } else if (selectedSoilType == 'चिकन') {
      soilBasedCrop = 'चना';
    } else if (selectedSoilType == 'रेतीलो') {
      soilBasedCrop = 'कागती';
    } else if (selectedSoilType == 'पानीलो') {
      soilBasedCrop = 'काँक्रो';
    } else if (selectedSoilType == 'बालु') {
      soilBasedCrop = 'गहुँ';
    }

    // Water-based crop
    if (selectedWaterLevel == 'धेरै') {
      waterBasedCrop = 'धान';
    } else if (selectedWaterLevel == 'मध्यम') {
      waterBasedCrop = 'काउली';
    } else if (selectedWaterLevel == 'कम') {
      waterBasedCrop = 'मसुरो';
    }

    // Region-based crop
    if (selectedRegion == 'तराई') {
      regionBasedCrop = 'गन्ना';
    } else if (selectedRegion == 'पहाड') {
      regionBasedCrop = 'कोदो';
    } else if (selectedRegion == 'हिमाल') {
      regionBasedCrop = 'स्याउ';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔍 बाली सिफारिस सुझाव'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              '🧱 कुन माटोमा कुन बाली?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: selectedSoilType,
              hint: const Text('माटोको प्रकार छान्नुहोस्'),
              items: soilTypes
                  .map(
                    (soil) => DropdownMenuItem(value: soil, child: Text(soil)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => selectedSoilType = value);
              },
            ),
            const SizedBox(height: 20),
            const Text(
              '💧 पानी कति छ भने कुन बाली?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: selectedWaterLevel,
              hint: const Text('पानीको मात्रा छान्नुहोस्'),
              items: waterLevels
                  .map(
                    (level) =>
                        DropdownMenuItem(value: level, child: Text(level)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => selectedWaterLevel = value);
              },
            ),
            const SizedBox(height: 20),
            const Text(
              '🏔️ क्षेत्र अनुसार कुन बाली?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: selectedRegion,
              hint: const Text('क्षेत्र छान्नुहोस्'),
              items: regions
                  .map(
                    (region) =>
                        DropdownMenuItem(value: region, child: Text(region)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => selectedRegion = value);
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (selectedSoilType != null &&
                    selectedWaterLevel != null &&
                    selectedRegion != null) {
                  generateRecommendations();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('कृपया सबै विकल्पहरू छान्नुहोस्'),
                    ),
                  );
                }
              },
              child: const Text('सिफारिस हेर्नुहोस्'),
            ),
            const SizedBox(height: 30),
            if (soilBasedCrop.isNotEmpty ||
                waterBasedCrop.isNotEmpty ||
                regionBasedCrop.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (soilBasedCrop.isNotEmpty)
                    Text(
                      '🧱 माटोको आधारमा: $soilBasedCrop',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (waterBasedCrop.isNotEmpty)
                    Text(
                      '💧 पानीको आधारमा: $waterBasedCrop',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (regionBasedCrop.isNotEmpty)
                    Text(
                      '🏔️ क्षेत्रको आधारमा: $regionBasedCrop',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
