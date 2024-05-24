import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'bottom_navigation_model.dart';


class BottomNavBar extends StatelessWidget {
  final BottomNavigationModel bottomNavigationModel;
  final List<BottomNavigationBarItem> items;

  BottomNavBar({required this.bottomNavigationModel, required this.items});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => BottomNavigationBar(
        currentIndex: bottomNavigationModel.selectedIndex,
        onTap: (index) => bottomNavigationModel.setIndex(index),
        items: items,
      ),
    );
  }
}
