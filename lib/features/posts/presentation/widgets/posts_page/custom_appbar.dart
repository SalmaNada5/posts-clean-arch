import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 6, 48, 81),
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 26),
      ),
    );
  }
}
