import 'package:flutter/material.dart';

class AddCropScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddCrop;

  const AddCropScreen({super.key, required this.onAddCrop});

  @override
  State<AddCropScreen> createState() => _AddCropScreenState();
}

class _AddCropScreenState extends State<AddCropScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cropName = TextEditingController();
  final _price = TextEditingController();
  final _quantity = TextEditingController();

  String? _suggestedPrice;
  Map<String, String> mockPrices = {
    'टमाटर': '४०',
    'आलु': '३५',
    'गाजर': '५०',
    'काउली': '४५',
    'बन्दा': '३०',
  };

  void _updateSuggestedPrice(String cropName) {
    setState(() {
      _suggestedPrice = mockPrices[cropName];
      if (_suggestedPrice != null) {
        _price.text = _suggestedPrice!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("नयाँ बाली थप्नुहोस्")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Crop name with suggestion
              TextFormField(
                controller: _cropName,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.agriculture),
                  labelText: "बालीको नाम",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  _updateSuggestedPrice(value.trim());
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'कृपया बालीको नाम लेख्नुहोस्';
                  }
                  return null;
                },
              ),

              if (_suggestedPrice != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    "💡 सुझाव गरिएको मूल्य: रु. $_suggestedPrice प्रति के.जि.",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),

              const SizedBox(height: 16),
              _buildInput(
                _quantity,
                "परिमाण (के.जि.)",
                Icons.scale,
                isNumber: true,
              ),
              const SizedBox(height: 16),
              _buildInput(
                _price,
                "प्रति के.जि. मूल्य (रु)",
                Icons.money,
                isNumber: true,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onAddCrop({
                      'name': _cropName.text,
                      'quantity': int.parse(_quantity.text),
                      'price': int.parse(_price.text),
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('बाली सफलतापूर्वक थपियो!')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text("बाली थप्नुहोस्"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'कृपया $label लेख्नुहोस्';
        }
        return null;
      },
    );
  }
}