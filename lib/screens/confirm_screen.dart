import 'dart:io';

import 'package:flutter/material.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key, required this.selectedImage});

  final File? selectedImage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.06),
              width: 150,
              child: Image.asset(
                'assets/logo.png',
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
            child: Center(
              child: Image.file(
                selectedImage!,
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
