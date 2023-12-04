import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String itemName;

  const DetailsPage({Key? key, required this.itemName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Details for $itemName',
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
