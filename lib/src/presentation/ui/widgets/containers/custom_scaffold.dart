import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    required this.title,
  });
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 80,
            horizontal: 16.0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.only(top: 130),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(14.0),
            ),
          ),
          child: body,
        ),
      ],
    );
  }
}
