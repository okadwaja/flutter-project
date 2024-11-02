import 'package:flutter/material.dart';
import 'package:aplikasi01/resources/dimentions.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key, required int index});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: smallSize,
          vertical: smallSize,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(extraLargeSize),
          image: const DecorationImage(
            // image: AssetImage('assets/images/moments_background_dark.png'),
            image: NetworkImage('https://picsum.photos/800/600?random=3'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
