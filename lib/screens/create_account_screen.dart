import 'package:flutter/material.dart';
import '../services/session_manager.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  String? _selectedRole;

  bool isNepali = true; // 🔥 Language toggle

  String getText({required String en, required String ne}) {
    return isNepali ? ne : en;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate() && _selectedRole != null) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final role = _selectedRole;
      final phone = _phoneController.text.trim();
      final location = _locationController.text.trim();

      SessionManager().loggedInUserName = name;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            getText(
              en: 'Account created for $name',
              ne: '$name को लागि खाता सिर्जना भयो',
            ),
          ),
        ),
      );

      if (role == getText(en: 'Buyer', ne: 'क्रेता')) {
        Navigator.pushReplacementNamed(
          context,
          '/buyer',
          arguments: {'userName': name},
        );
      } else if (role == getText(en: 'Supplier', ne: 'आपूर्तिकर्ता')) {
        Navigator.pushReplacementNamed(
          context,
          '/farmer',
          arguments: {'userName': name},
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            getText(
              en: 'Please fill all required fields',
              ne: 'कृपया सबै आवश्यक क्षेत्रहरु भर्नुहोस्',
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getText(en: "Create Account", ne: "खाता सिर्जना गर्नुहोस्"),
        ),
        actions: [
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildInput(_nameController, getText(en: 'Full Name', ne: 'पुरा नाम'), Icons.person),
              const SizedBox(height: 16),
              _buildInput(_emailController, getText(en: 'Email', ne: 'इमेल'), Icons.email),
              const SizedBox(height: 16),
              _buildInput(_passwordController, getText(en: 'Password', ne: 'पासवर्ड'), Icons.lock, isPassword: true),
              const SizedBox(height: 16),
              _buildInput(
                _phoneController,
                getText(en: 'Phone Number', ne: 'फोन नम्बर'),
                Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildInput(_locationController, getText(en: 'Address', ne: 'ठेगाना'), Icons.location_on),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                hint: Text(getText(en: 'Select Role', ne: 'भूमिका चयन गर्नुहोस्')),
                items: [
                  getText(en: 'Buyer', ne: 'क्रेता'),
                  getText(en: 'Supplier', ne: 'आपूर्तिकर्ता'),
                ].map((role) {
                  return DropdownMenuItem(value: role, child: Text(role));
                }).toList(),
                onChanged: (value) => setState(() => _selectedRole = value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value == null
                    ? getText(en: 'Please select role', ne: 'कृपया भूमिका चयन गर्नुहोस्')
                    : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _register,
                child: Text(
                  getText(en: "Create Account", ne: "खाता सिर्जना गर्नुहोस्"),
                ),
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
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      validator: (value) {
        if (label == getText(en: "Phone Number", ne: "फोन नम्बर") ||
            label == getText(en: "Address", ne: "ठेगाना")) {
          return null;
        }
        if (value == null || value.trim().isEmpty) {
          return '${getText(en: 'Please enter', ne: 'कृपया')} $label';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
