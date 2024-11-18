import 'package:flutter/material.dart';
import 'package:aplikasi01/resources/dimentions.dart';
import 'package:aplikasi01/widgets/post_title.dart';

import '../models/country.dart'; // Ganti ini ke model "Country"

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.country,
    required this.onDelete,
    required this.onUpdate,
  });

  final Country country; // Ganti dari Moment ke Country
  final Function(String id) onUpdate;
  final Function(String id) onDelete;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: largeSize,
          vertical: mediumSize,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(extraLargeSize),
          image: DecorationImage(
            // Menampilkan gambar bendera negara
            image: NetworkImage(country.flagUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Header (Post Title)
            PostTitle(
              country: country,
              onUpdate: onUpdate,
              onDelete: onDelete,
            ),
            // Deskripsi Negara
            Padding(
              padding: const EdgeInsets.all(smallSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: largeSize, bottom: mediumSize),
                    child: Text(
                      country.description, // Menampilkan deskripsi negara
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
