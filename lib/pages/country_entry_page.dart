import 'package:flutter/material.dart';
import 'package:nanoid2/nanoid2.dart';

import '../models/country.dart';
import '../resources/colors.dart';
import '../resources/dimentions.dart';

class CountryEntryPage extends StatefulWidget {
  const CountryEntryPage({
    super.key,
    required this.onSaved,
    this.selectedCountry,
  });

  final Function(Country newCountry) onSaved;
  final Country? selectedCountry;

  @override
  State<CountryEntryPage> createState() => _CountryEntryPageState();
}

class _CountryEntryPageState extends State<CountryEntryPage> {
  // Membuat object form global key
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _dataCountry = {};
  // Text Editing Controllers untuk set nilai awal pada text field
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _flagUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.selectedCountry != null) {
      final selectedCountry = widget.selectedCountry!;
      _codeController.text = selectedCountry.code;
      _nameController.text = selectedCountry.name;
      _descriptionController.text = selectedCountry.description;
      _flagUrlController.text = selectedCountry.flagUrl;
    }
  }

  // Membuat method untuk menyimpan data country
  void _saveCountry() {
    if (_formKey.currentState!.validate()) {
      // Menyimpan data inputan pengguna ke map _dataCountry
      _formKey.currentState!.save();
      // Membuat object country baru
      final country = Country(
        id: widget.selectedCountry?.id ??
            nanoid(), // gunakan id yang ada jika update atau buat baru
        code: _dataCountry['code'],
        name: _dataCountry['name'],
        description: _dataCountry['description'],
        flagUrl: _dataCountry['flagUrl'],
      );
      // Menyimpan object country melalui callback
      widget.onSaved(country);
      // Menutup halaman create country
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.selectedCountry == null ? 'Create' : 'Update'} Country'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(largeSize),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Kode'),
                TextFormField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: 'Kode Negara',
                    prefixIcon: const Icon(Icons.code),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Kode Negara';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataCountry['code'] = newValue;
                    }
                  },
                ),
                const SizedBox(height: mediumSize),
                const Text('Nama'),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: 'Nama Negara',
                    prefixIcon: const Icon(Icons.flag),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Nama Negara';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataCountry['name'] = newValue;
                    }
                  },
                ),
                const SizedBox(height: mediumSize),
                const Text('Deskripsi'),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: 'Deskripsi Negara',
                    prefixIcon: const Icon(Icons.description),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Deskripsi Negara';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataCountry['description'] = newValue;
                    }
                  },
                ),
                const SizedBox(height: mediumSize),
                const Text('URL Bendera'),
                TextFormField(
                  controller: _flagUrlController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: 'URL Gambar Bendera Negara',
                    prefixIcon: const Icon(Icons.image),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan URL Bendera Negara';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataCountry['flagUrl'] = newValue;
                    }
                  },
                ),
                const SizedBox(height: largeSize),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _saveCountry,
                  child: const Text('Save'),
                ),
                const SizedBox(height: mediumSize),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
