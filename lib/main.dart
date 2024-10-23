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
          title: const Text('WhatsApp'),
          actions: [
            IconButton(icon: const Icon(Icons.camera_alt), onPressed: () {}),
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "All"),
              Tab(text: "Unread"),
              Tab(text: "Groups"),
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
            backgroundImage: AssetImage('assets/avatar1.png'),
          ),
          title: Text('Andrius Schneider'),
          subtitle: Text('Typing...'),
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
          title: Text('Anna Payet'),
          subtitle: Text('Best breakfast ever'),
          trailing: Text('9:37'),
        ),
        // Tambahkan ListTile lain sesuai kebutuhan
      ],
    );
  }
}
