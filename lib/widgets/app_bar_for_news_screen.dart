import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AppBarForHomeScreen extends StatelessWidget {
  const AppBarForHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Icon(Icons.circle)
        ],
      ),
    );
  }
}