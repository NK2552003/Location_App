import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final bool isInRadius;
  const StatusWidget({super.key, required this.isInRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: isInRadius ? Colors.green : Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          isInRadius ? 'In Range' : 'Out of Range',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
