import 'package:flutter/material.dart';
import '../utils/order_store.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  bool isNepali = true; // ✅ Language toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isNepali ? "अर्डर गर्नुहोस्" : "Place Order"),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: isNepali ? 'Switch to English' : 'नेपालीमा स्विच गर्नुहोस्',
            onPressed: () {
              setState(() {
                isNepali = !isNepali;
              });
            },
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            OrderStore.addOrder({
              'crop': isNepali ? 'गोलभेंडा' : 'Tomato',
              'buyerName': isNepali ? 'राम बहादुर' : 'Ram Bahadur',
              'quantity': isNepali ? '१० के.जि.' : '10 kg',
              'status': isNepali ? 'विचाराधीन' : 'Pending',
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isNepali ? "अर्डर गरियो" : "Order placed",
                ),
              ),
            );
          },
          child: Text(
            isNepali
                ? "गोलभेंडाका लागि अर्डर गर्नुहोस्"
                : "Order Tomato",
          ),
        ),
      ),
    );
  }
}
