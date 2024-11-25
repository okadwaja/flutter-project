import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/views/moment/pages/moment_page.dart';
import 'package:myapp/views/moment/pages/moment_search_page.dart';
import 'package:myapp/core/resources/colors.dart';
import 'package:nanoid2/nanoid2.dart';

import '../../../models/moment.dart';
import '../../moment/pages/moment_entry_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Variabel untuk menyimpan index halaman yang aktif
  int _seletedPageIndex = 0;

  final _faker = faker.Faker();
  // List Moments
  List<Moment> _moments = [];

  // Fungsi untuk mengubah index halaman yang aktif
  void _onPageChanged(int index) {
    if (index == 2) {
      // Jika index halaman adalah 2, maka navigasi ke halaman create moment
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return MomentEntryPage(onSaved: _saveMoment);
      }));
    } else {
      // Jika index halaman bukan 2, maka navigasi ke halaman yang sesuai
      setState(() {
        _seletedPageIndex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _moments = List.generate(
      2,
      (index) => Moment(
        id: nanoid(),
        momentDate: _faker.date.dateTime(),
        creator: _faker.person.name(),
        location: _faker.address.city(),
        imageUrl: 'https://picsum.photos/800/600?random=$index',
        caption: _faker.lorem.sentence(),
        likeCount: faker.random.integer(1000),
        commentCount: faker.random.integer(100),
        bookmarkCount: faker.random.integer(10),
      ),
    );
  }

  void _saveMoment(Moment newMoment) {
    final existingMoment = getMomentById(newMoment.id);
    if (existingMoment == null) {
      setState(() {
        _moments.add(newMoment);
      });
    } else {
      setState(() {
        _moments[_moments.indexOf(existingMoment)] = newMoment;
      });
    }
  }

  void onUpdate(String momentId) {
    final selectedMoment = getMomentById(momentId);
    if (selectedMoment != null) {
      // Menampilkan dialog konfirmasi pembaruan data moment
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update Moment'),
            content: const Text('Are you sure you want to update this moment?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return MomentEntryPage(
                      onSaved: _saveMoment,
                      selectedMoment: selectedMoment,
                    );
                  }));
                },
                child: const Text('Sure'),
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

  void onDelete(String momentId) {
    final selectedMoment = getMomentById(momentId);
    if (selectedMoment != null) {
      // Menampilkan dialog konfirmasi penghapusan moment
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Moment'),
            content: const Text('Are you sure you want to delete this moment?'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _moments.remove(selectedMoment);
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Sure'),
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

  Moment? getMomentById(String momentId) {
    return _moments.firstWhereOrNull((moment) => moment.id == momentId);
  }

  @override
  Widget build(BuildContext context) {
    // List halaman yang tersedia
    final List<Widget> pages = [
      MomentPage(
        moments: _moments,
        onUpdate: onUpdate,
        onDelete: onDelete,
      ),
      MomentSearchPage(moments: _moments),
      const Center(
        child: Text('Create Moment'),
      ),
      const Center(
        child: Text('Activity'),
      ),
      const Center(
        child: Text('Profile'),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/moments_text.png',
          height: 32,
        ),
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
            icon: SvgPicture.asset('assets/icons/fi-br-search.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/fi-sr-search.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: 'Search',
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
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/fi-br-heart.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/fi-sr-heart.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/fi-br-portrait.svg'),
            activeIcon: SvgPicture.asset(
              'assets/icons/fi-sr-portrait.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: 'Profile',
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
