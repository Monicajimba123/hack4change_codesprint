import 'package:flutter/material.dart';

class BuyerProfileScreen extends StatefulWidget {
  const BuyerProfileScreen({super.key});

  @override
  State<BuyerProfileScreen> createState() => _BuyerProfileScreenState();
}

class _BuyerProfileScreenState extends State<BuyerProfileScreen> {
  bool isEditing = false;
  bool isNepali = true; // 🔥 Language toggle

  // Mock data (replace with database values later)
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(getText(
              en: 'Profile updated successfully!',
              ne: 'प्रोफाइल सफलतापूर्वक अपडेट भयो!',
            )),
          ),
        );
      }
      isEditing = !isEditing;
    });
  }

  String getText({required String en, required String ne}) {
    return isNepali ? ne : en;
  }

  Widget _buildTextField(String enLabel, String neLabel, TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: !isEditing,
      decoration: InputDecoration(
        labelText: getText(en: enLabel, ne: neLabel),
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
        title: Text(getText(en: 'Buyer Profile', ne: 'क्रेता प्रोफाइल')),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: _toggleEdit,
            tooltip: getText(en: 'Edit/Save', ne: 'सम्पादन/सेभ'),
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              setState(() {
                isNepali = !isNepali;
              });
            },
            tooltip: getText(en: 'Language', ne: 'भाषा'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildTextField('Full Name', 'पुरा नाम', nameController),
            const SizedBox(height: 16),
            _buildTextField('Email', 'इमेल', emailController),
            const SizedBox(height: 16),
            _buildTextField('Phone Number', 'फोन नम्बर', phoneController),
            const SizedBox(height: 16),
            _buildTextField('Address', 'ठेगाना', addressController),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: const Icon(Icons.logout),
              label: Text(getText(en: 'Logout', ne: 'लगआउट')),
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
