import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _submitted = false;
  bool isNepali = true; // ✅ Language toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isNepali ? "पासवर्ड बिर्सनुभयो?" : "Forgot Password?"),
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _submitted
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 80,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isNepali
                        ? "पासवर्ड रिसेट लिंक तपाईंको इमेलमा पठाइएको छ।"
                        : "A password reset link has been sent to your email.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isNepali
                        ? "पासवर्ड रिसेट गर्न आफ्नो इमेल लेख्नुहोस्"
                        : "Enter your email to reset your password",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: isNepali ? "इमेल" : "Email",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _submitted = true;
                      });
                    },
                    child: Text(
                      isNepali
                          ? "रिसेट लिंक पठाउनुहोस्"
                          : "Send Reset Link",
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
