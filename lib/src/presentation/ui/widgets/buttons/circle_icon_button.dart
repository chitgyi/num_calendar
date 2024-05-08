import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size,
  });

  final VoidCallback? onTap;
  final Widget icon;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor.withOpacity(0.08),
        ),
        child: icon,
      ),
    );
  }
}
