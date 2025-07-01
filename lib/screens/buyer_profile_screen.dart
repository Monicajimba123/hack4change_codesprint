import 'package:flutter/material.dart';

class BuyerProfileScreen extends StatefulWidget {
  const BuyerProfileScreen({super.key});

  @override
  State<BuyerProfileScreen> createState() => _BuyerProfileScreenState();
}

class _BuyerProfileScreenState extends State<BuyerProfileScreen> {
  bool isEditing = false;

  // Mock data (replace with dynamic data after auth/database)
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: 'अमित शर्मा');
    emailController = TextEditingController(text: 'amit@example.com');
    phoneController = TextEditingController(text: '+९७७ ९८१२३४५६७८');
    addressController = TextEditingController(text: 'बुटवल, रुपन्देही');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      if (isEditing) {
        // Save logic here (e.g., update DB)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('प्रोफाइल सफलतापूर्वक अपडेट भयो!')),
        );
      }
      isEditing = !isEditing;
    });
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: !isEditing,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[100],
        suffixIcon: isEditing ? const Icon(Icons.edit) : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('क्रेता प्रोफाइल'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: _toggleEdit,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildTextField('पुरा नाम', nameController),
            const SizedBox(height: 16),
            _buildTextField('इमेल', emailController),
            const SizedBox(height: 16),
            _buildTextField('फोन नम्बर', phoneController),
            const SizedBox(height: 16),
            _buildTextField('ठेगाना', addressController),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: const Icon(Icons.logout),
              label: const Text('लगआउट'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}