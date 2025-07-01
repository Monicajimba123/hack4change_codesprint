import 'package:flutter/material.dart';

class FarmerProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String location;
  final String crops;

  const FarmerProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.crops,
  });

  @override
  State<FarmerProfileScreen> createState() => _FarmerProfileScreenState();
}

class _FarmerProfileScreenState extends State<FarmerProfileScreen> {
  bool isEditing = false;
  bool isNepali = true; // ✅ Language toggle

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController locationController;
  late TextEditingController cropsController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
    locationController = TextEditingController(text: widget.location);
    cropsController = TextEditingController(text: widget.crops);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    cropsController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      if (isEditing) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isNepali
                  ? 'प्रोफाइल सफलतापूर्वक अपडेट भयो।'
                  : 'Profile updated successfully.',
            ),
          ),
        );
      }
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isNepali ? "कृषक प्रोफाइल" : "Farmer Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: isNepali ? "Switch to English" : "नेपालीमा स्विच गर्नुहोस्",
            onPressed: () {
              setState(() {
                isNepali = !isNepali;
              });
            },
          ),
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            tooltip: isEditing
                ? (isNepali ? "सेभ गर्नुहोस्" : "Save")
                : (isNepali ? "सम्पादन गर्नुहोस्" : "Edit"),
            onPressed: _toggleEdit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildEditableField(isNepali ? "नाम" : "Name", nameController),
            _buildEditableField(isNepali ? "इमेल" : "Email", emailController),
            _buildEditableField(
                isNepali ? "फोन नम्बर" : "Phone", phoneController),
            _buildEditableField(
                isNepali ? "ठेगाना" : "Address", locationController),
            _buildEditableField(
                isNepali ? "खेती गरिएका बालीहरू" : "Crops", cropsController),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: const Icon(Icons.logout),
              label: Text(isNepali ? "लगआउट" : "Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        enabled: isEditing,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: isEditing ? Colors.white : Colors.grey[200],
        ),
      ),
    );
  }
}
