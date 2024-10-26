import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Clone',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const WhatsAppHomePage(),
    );
  }
}

class WhatsAppHomePage extends StatelessWidget {
  const WhatsAppHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Jumlah Tab
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'WhatsApp',
            style: TextStyle(
              color: Colors.green, // Menambahkan warna hijau pada teks
            ),
          ),
          actions: [
            IconButton(icon: const Icon(Icons.camera_alt), onPressed: () {}),
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent, // Garis bawah tab transparan
            labelColor: Colors.green, // Warna teks aktif
            unselectedLabelColor: Colors.black, // Warna teks tidak aktif
            tabs: [
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Align(
                    alignment: Alignment.centerLeft, // Rata kiri
                    child: Text("All", style: TextStyle(color: Colors.green)),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Align(
                    alignment: Alignment.centerLeft, // Rata kiri
                    child:
                        Text("Unread", style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Align(
                    alignment: Alignment.centerLeft, // Rata kiri
                    child:
                        Text("Groups", style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ChatListView(), // Tab untuk "All"
            Center(child: Text('Unread')), // Placeholder untuk "Unread"
            Center(child: Text('Groups')), // Placeholder untuk "Groups"
          ],
        ),
      ),
    );
  }
}

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/avatar3.png'),
          ),
          title: Text('Anton Ganteng'),
          subtitle: Text('Sampai Jumpa...'),
          trailing: Column(
            mainAxisSize:
                MainAxisSize.min, // Mengatur ukuran kolom sesuai dengan konten
            crossAxisAlignment:
                CrossAxisAlignment.end, // Mengatur agar kolom rata kanan
            children: [
              Text('Yesterday'),
              Icon(
                Icons.push_pin, // Ganti dengan ikon pin yang sesuai
                color: Colors.black,
                size: 18.0, // Mengatur warna ikon
              ),
            ],
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/avatar1.png'),
          ),
          title: Text('Budi Tampan'),
          subtitle: Text(
            'Typing...',
            style: TextStyle(
              color: Colors.green, // Menambahkan warna hijau pada teks
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('9:45'),
              SizedBox(height: 5),
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.green,
                child: Text('2',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/avatar2.png'),
          ),
          title: Text('Cici Caca'),
          subtitle: Text('Hallo selamat pagi'),
          trailing: Text('9:37'),
        ),
        // Tambahkan ListTile lain sesuai kebutuhan
      ],
    );
  }
}
