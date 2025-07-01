import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("पासवर्ड बिर्सनुभयो?")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _submitted
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 80,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "पासवर्ड रिसेट लिंक तपाईंको इमेलमा पठाइएको छ।",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "पासवर्ड रिसेट गर्न आफ्नो इमेल लेख्नुहोस्",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "इमेल",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _submitted = true;
                      });
                    },
                    child: const Text("रिसेट लिंक पठाउनुहोस्"),
                  ),
                ],
              ),
      ),
    );
  }
}