import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calculator/Getx/getx.dart';
import 'package:calculator/Screens/calcgetx.dart';
import 'package:calculator/Screens/calcprovider.dart';
import 'package:calculator/Screens/imageupload.dart';
import 'package:calculator/Theme/themes.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final CalculatorController controller = Get.put(CalculatorController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => _widgetOptions[controller.bnindex.value]),
        bottomNavigationBar: createBottombar(context),
      ),
    );
  }

  final _widgetOptions = [
    Calcprovider(),
    const Calcgetx(),
    const Imageupload()
  ];

  void _onItemTapped(int index) {
    controller.bottomnavindex(index);
  }

  Container createBottombar(BuildContext context) {
    return Container(
      color: Themes.white,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        child: Obx(() => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Themes.bottomnavbar,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 20),
              label: 'Provider',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.personal_video_rounded, size: 20),
              label: 'Getx',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image, size: 20),
              label: 'Upload',
            ),
          ],
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          currentIndex: controller.bnindex.value,
          selectedItemColor: Themes.purple,
          onTap: _onItemTapped,
        )),
      ),
    );
  }
}