import 'package:flutter/material.dart';

class AppBarForHomeScreen extends StatelessWidget {
  const AppBarForHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: const [
          Icon(Icons.circle)
        ],
      ),
    );
  }
}