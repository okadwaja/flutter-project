import 'package:flutter/material.dart';
import 'package:aplikasi01/core/resources/dimentions.dart';

class FollowItem extends StatelessWidget {
  const FollowItem({
    super.key,
    required this.label,
    required this.value,
    this.onTap,
  });
  final String label;
  final String value;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: largeSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: mediumSize),
            ),
          ],
        ),
      ),
    );
  }
}
