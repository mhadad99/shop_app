import 'package:flutter/material.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          "Login Screen",
          style: TextStyle(
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}
