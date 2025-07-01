import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class SimpleMapScreen extends StatefulWidget {
  const SimpleMapScreen({super.key});

  @override
  State<SimpleMapScreen> createState() => _SimpleMapScreenState();
}

class _SimpleMapScreenState extends State<SimpleMapScreen> {
  late GoogleMapController _controller;

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(27.7172, 85.3240), // Kathmandu
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      debugPrint('स्थान अनुमति दिइयो');
    } else if (status.isPermanentlyDenied) {
      // Guide user to settings if permanently denied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('स्थान अनुमति सेटिङबाट दिनुहोस्'),
          action: SnackBarAction(
            label: 'सेटिङ खोल्नुहोस्',
            onPressed: () => openAppSettings(),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('स्थान अनुमति आवश्यक छ')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map Example')),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        onMapCreated: (controller) => _controller = controller,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
