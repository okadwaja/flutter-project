import 'package:aplikasi01/models/country.dart'; // Pastikan file model sesuai
import 'package:flutter/material.dart';

class PostTitle extends StatelessWidget {
  const PostTitle({
    super.key,
    required this.country,
    required this.onDelete,
    required this.onUpdate,
  });

  final Country country; // Ganti dari Moment ke Country
  final Function(String id) onDelete;
  final Function(String id) onUpdate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        country.name, // Menampilkan nama negara
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
      ),
      subtitle: Text(
        country.code, // Menampilkan kode negara
        style: const TextStyle(color: Colors.white54),
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'Edit') {
            onUpdate(country.id); // Edit data berdasarkan ID
          } else if (value == 'Delete') {
            onDelete(country.id); // Hapus data berdasarkan ID
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'Edit',
            child: Text('Edit'),
          ),
          const PopupMenuItem(
            value: 'Delete',
            child: Text('Delete'),
          ),
        ],
        child: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.5),
          child: const Icon(Icons.more_vert, color: Colors.white),
        ),
      ),
    );
  }
}
