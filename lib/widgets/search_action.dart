import 'package:flutter/material.dart';
import 'package:aplikasi01/resources/dimentions.dart';
import 'package:aplikasi01/resources/colors.dart';

class SearchAction extends StatelessWidget {
  const SearchAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: mediumSize, horizontal: largeSize),
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: const Color(0xFFF5EDE6), // Sesuaikan warna background
          borderRadius: BorderRadius.circular(largeSize),
        ),
        padding: const EdgeInsets.symmetric(horizontal: largeSize),
        child: const Row(
          children: [
            Icon(Icons.search, color: primaryColor), // Ikon pencarian
            SizedBox(width: mediumSize),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari moment...",
                  border: InputBorder.none, // Menghilangkan garis bawah
                ),
                style: TextStyle(color: secondaryColor), // Sesuaikan warna teks
              ),
            ),
          ],
        ),
      ),
    );
  }
}
