import 'package:flutter/material.dart';
import 'package:aplikasi01/models/country.dart'; // Import model Country
import 'package:aplikasi01/widgets/post_item.dart'; // Pastikan widget PostItem dapat menerima Country

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.countrys,
    required this.onUpdate,
    required this.onDelete,
  });

  final List<Country> countrys; // Menggunakan List<Country> bukan List<Moment>
  final Function(String id) onUpdate;
  final Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: countrys
            .map(
              (countryItem) => PostItem(
                // Menampilkan item Country menggunakan PostItem
                country: countryItem, // Pastikan PostItem menerima Country
                onUpdate: onUpdate,
                onDelete: onDelete,
              ),
            )
            .toList(),
      ),
    );
  }
}
