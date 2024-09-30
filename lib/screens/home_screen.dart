import 'package:flutter/material.dart';
import 'package:location_app/services/location_services.dart';
import '../widgets/status_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool isInRadius = false;

  @override
  void initState() {
    super.initState();
    LocationService().startTracking((status) {
      setState(() {
        isInRadius = status;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocation Status'),
      ),
      body: Center(
        child: StatusWidget(isInRadius: isInRadius),
      ),
    );
  }
}
