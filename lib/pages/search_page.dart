import 'package:flutter/material.dart';
import 'package:aplikasi01/widgets/search_item.dart';
import 'package:aplikasi01/resources/dimentions.dart';
import 'package:aplikasi01/widgets/search_action.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Menggunakan SearchAction sebagai kotak pencarian
        const SearchAction(),

        // GridView untuk item pencarian
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(largeSize),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Membuat dua kolom
              childAspectRatio: 3 / 3, // Mengatur aspek rasio item
            ),
            itemCount: 30,
            itemBuilder: (context, index) => SearchItem(index: index),
          ),
        ),
      ],
    );
  }
}
