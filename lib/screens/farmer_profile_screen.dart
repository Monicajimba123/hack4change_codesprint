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
        // You can connect this to backend to save changes
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('प्रोफाइल सफलतापूर्वक अपडेट भयो।')),
        );
      }
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("कृषक प्रोफाइल"),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: _toggleEdit,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildEditableField("नाम", nameController),
            _buildEditableField("इमेल", emailController),
            _buildEditableField("फोन नम्बर", phoneController),
            _buildEditableField("ठेगाना", locationController),
            _buildEditableField("खेती गरिएका बालीहरू", cropsController),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: const Icon(Icons.logout),
              label: const Text("लगआउट"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
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