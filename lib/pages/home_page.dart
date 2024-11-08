import 'package:flutter/material.dart';
import 'package:aplikasi01/models/moment.dart';
import 'package:aplikasi01/widgets/post_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.moments});

  final List<Moment> moments;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: moments
            .map(
              (momentItem) => PostItem(moment: momentItem),
            )
            .toList(),
      ),
    );
  }
}
