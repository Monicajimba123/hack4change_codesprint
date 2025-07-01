import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedRole;
  bool _obscurePassword = true;

  static const Color _deepGreen = Color(0xFF227C49);
  static const Color _accentGreen = Color(0xFF9FE870);
  static const Color _inputGreen = Color(0xFFF2FFF6);
  static const Color _borderGreen = Color(0xFF65B891);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _inputGreen,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 34,
                backgroundColor: _accentGreen,
                child: Icon(Icons.agriculture, color: _deepGreen, size: 38),
              ),
              const SizedBox(height: 20),
              Text(
                'FarmConnect मा स्वागत छ',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: _deepGreen,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 9),
              Text(
                'किसान र उपभोक्तालाई प्रविधिमार्फत जोड्ने पुल',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: _deepGreen.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 36),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: _deepGreen.withOpacity(0.07),
                      blurRadius: 16,
                      offset: const Offset(0, 12),
                    )
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                child: Column(
                  children: [
                    _buildTextField(_emailController, 'इमेल', Icons.email_outlined),
                    const SizedBox(height: 14),
                    _buildPasswordField(),
                    const SizedBox(height: 14),
                    _buildRoleDropdown(),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _deepGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          elevation: 2,
                        ),
                        child: const Text('लगइन', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 17),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/create-account'),
                child: Text(
                  "खाता सिर्जना गर्नुहोस्",
                  style: TextStyle(color: _deepGreen, fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
                child: Text(
                  "पासवर्ड बिर्सनुभयो?",
                  style: TextStyle(color: _deepGreen, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: _borderGreen),
        labelText: label,
        labelStyle: TextStyle(color: _deepGreen, fontWeight: FontWeight.w500),
        filled: true,
        fillColor: _inputGreen,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _borderGreen, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _borderGreen.withOpacity(0.35), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _deepGreen, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline, color: _borderGreen),
        labelText: 'पासवर्ड',
        labelStyle: TextStyle(color: _deepGreen, fontWeight: FontWeight.w500),
        filled: true,
        fillColor: _inputGreen,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _borderGreen, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _borderGreen.withOpacity(0.35), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _deepGreen, width: 1.5),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: _deepGreen,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
    );
  }

  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedRole,
      hint: const Text('भूमिका चयन गर्नुहोस्'),
      items: ['प्रशासक', 'ग्राहक', 'कृषक'].map((role) {
        return DropdownMenuItem(value: role, child: Text(role));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedRole = value;
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _borderGreen, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _borderGreen.withOpacity(0.35), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: _deepGreen, width: 1.5),
        ),
        filled: true,
        fillColor: _inputGreen,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty || _selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('कृपया सबै क्षेत्रहरू भर्नुहोस् र भूमिका चयन गर्नुहोस्'),
        ),
      );
      return;
    }

    if (!email.endsWith('@gmail.com')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('कृपया मान्य Gmail ठेगाना प्रविष्ट गर्नुहोस् (@gmail.com)'),
        ),
      );
      return;
    }

    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('पासवर्ड कम्तीमा ८ अक्षरको हुनुपर्छ'),
        ),
      );
      return;
    }

    // Extract username from email before '@'
    final userName = email.split('@')[0];

    if (_selectedRole == 'प्रशासक') {
      Navigator.pushReplacementNamed(context, '/admin');
    } else if (_selectedRole == 'ग्राहक') {
      Navigator.pushReplacementNamed(
        context,
        '/buyer',
        arguments: {'farmerName': userName}, // pass as farmerName key for consistency
      );
    } else if (_selectedRole == 'कृषक') {
      Navigator.pushReplacementNamed(
        context,
        '/farmer',
        arguments: {'farmerName': userName},
      );
    }
  }
}
