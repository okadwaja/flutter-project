import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aplikasi01/views/home/pages/main_page.dart';
import 'package:aplikasi01/core/resources/colors.dart';
import 'package:aplikasi01/core/resources/strings.dart';
import 'package:aplikasi01/views/moment/pages/moment_entry_page.dart';

import 'views/moment/bloc/moment_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MomentBloc(),
      child: MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case MainPage.routeName:
              return MaterialPageRoute(builder: (_) => const MainPage());
            case MomentEntryPage.routeName:
              final momentId = settings.arguments as String?;
              return MaterialPageRoute(
                  builder: (_) => MomentEntryPage(momentId: momentId));
            default:
              return MaterialPageRoute(builder: (_) => const MainPage());
          }
        },
      ),
    );
  }
}
