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

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text("Add New Crop")),
body: Padding(
padding: const EdgeInsets.all(20),
child: Form(
key: _formKey,
child: ListView(
children: [
_buildInput(_cropName, "Crop Name", Icons.agriculture),
const SizedBox(height: 16),
_buildInput(_quantity, "Quantity (kg)", Icons.scale, isNumber: true),
const SizedBox(height: 16),
_buildInput(_price, "Price per kg (Rs)", Icons.money, isNumber: true),
const SizedBox(height: 30),
ElevatedButton(
onPressed: () {
if (_formKey.currentState!.validate()) {
final newCrop = {
'name': _cropName.text.trim(),
'quantity': double.parse(_quantity.text),
'price': double.parse(_price.text),
};
widget.onAddCrop(newCrop);
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Crop added successfully!')),
);
Navigator.pop(context);
}
},
child: const Text("Add Crop"),
)
],
),
),
),
);
}

Widget _buildInput(TextEditingController controller, String label, IconData icon, {bool isNumber = false}) {
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
return 'Please enter $label';
}
return null;
},
);
}
}