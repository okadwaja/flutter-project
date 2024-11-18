import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aplikasi01/pages/home_page.dart';
import 'package:aplikasi01/resources/colors.dart';
import 'package:nanoid2/nanoid2.dart';

import '../models/country.dart';
import 'country_entry_page.dart'; // Mengubah referensi halaman entry sesuai model Country

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Variabel untuk menyimpan index halaman yang aktif
  int _seletedPageIndex = 0;

  // List Countries
  List<Country> _country = [];

  // Fungsi untuk mengubah index halaman yang aktif
  void _onPageChanged(int index) {
    if (index == 1) {
      // Jika index halaman adalah 1, maka navigasi ke halaman create country
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return CountryEntryPage(onSaved: _saveCountry);
      }));
    } else {
      // Jika index halaman bukan 1, maka navigasi ke halaman yang sesuai
      setState(() {
        _seletedPageIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _country = [
      Country(
        id: nanoid(),
        code: 'ID',
        name: 'Indonesia',
        description: 'Negara kepulauan terbesar di dunia.',
        flagUrl:
            'https://www.beritariau.com/foto_berita/2022/08/2022-08-18-ini-sejarahnya-bendera-indonesia-berwarna-merah-putih.jpg',
      ),
      Country(
        id: nanoid(),
        code: 'US',
        name: 'United States',
        description: 'Negara adidaya di dunia.',
        flagUrl:
            'https://images.tokopedia.net/img/cache/500-square/product-1/2017/11/13/0/0_447d9c5d-4471-4a35-8b18-210e7115d769_800_800.jpg',
      ),
      Country(
        id: nanoid(),
        code: 'JP',
        name: 'Japan',
        description: 'Negara maju asal Naruto.',
        flagUrl:
            'https://d20aeo683mqd6t.cloudfront.net/articles/title_images/000/040/775/medium/japanese-flag_b.png?2022',
      ),
    ];
  }

  void _saveCountry(Country newCountry) {
    final existingCountry = getCountryById(newCountry.id);
    if (existingCountry == null) {
      setState(() {
        _country.add(newCountry);
      });
    } else {
      setState(() {
        _country[_country.indexOf(existingCountry)] = newCountry;
      });
    }
  }

  void onUpdate(String countryId) {
    final selectedCountry = getCountryById(countryId);
    if (selectedCountry != null) {
      // Menampilkan alert untuk update
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update Country'),
            content: const Text('Apa Anda yakin mengubah data negara ini?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CountryEntryPage(
                      onSaved: _saveCountry,
                      selectedCountry: selectedCountry,
                    );
                  }));
                },
                child: const Text('Yakin'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    }
  }

  void onDelete(String countryId) {
    final selectedCountry = getCountryById(countryId);
    if (selectedCountry != null) {
      // Menampilkan alert untuk penghapusan
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Country'),
            content: const Text('Apa Anda yakin menghapus negara ini?'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _country.remove(selectedCountry);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Yakin'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    }
  }

  Country? getCountryById(String countryId) {
    return _country.firstWhereOrNull((country) => country.id == countryId);
  }

  @override
  Widget build(BuildContext context) {
    // List halaman yang tersedia
    final List<Widget> pages = [
      HomePage(
        countrys: _country, // Mengubah parameter dari 'moments' ke 'countries'
        onUpdate: onUpdate,
        onDelete: onDelete,
      ),
      const Center(
        child: Text('Create Country'),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Negara'),
        centerTitle: true,
      ),
      body: pages[_seletedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/fi-br-home.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/fi-sr-home.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/fi-br-add.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/fi-sr-add.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: 'Create',
          ),
        ],
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryColor,
        onTap: _onPageChanged,
        currentIndex: _seletedPageIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
