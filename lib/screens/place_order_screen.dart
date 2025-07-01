import 'package:flutter/material.dart';
import '../utils/order_store.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("अर्डर गर्नुहोस्")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            OrderStore.addOrder({
              'crop': 'गोलभेंडा',
              'buyerName': 'राम बहादुर',
              'quantity': '१० के.जि.',
              'status': 'विचाराधीन',
            });

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("अर्डर गरियो")));
          },
          child: const Text("गोलभेंडाका लागि अर्डर गर्नुहोस्"),
        ),
      ),
    );
  }
}