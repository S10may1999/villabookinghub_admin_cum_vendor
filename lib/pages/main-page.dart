import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:villachalo_admin/components/graph-card.dart';
import 'package:villachalo_admin/components/status-card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StatusCard(),
          GraphCard()
        ],
      ),
    );
  }
}