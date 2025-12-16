import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  final Widget child;
  final double maxWidth; // Maximum width content should take
  final EdgeInsetsGeometry padding;

  const ResponsiveScreen({
    super.key,
    required this.child,
    this.maxWidth = 500,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth, // Content isse zyada nahi phailega
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}