import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:qr_scanner/screens/widgets/custom_navigationbar.dart';
import 'package:qr_scanner/screens/widgets/custom_scanner.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const CustomScanner(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
