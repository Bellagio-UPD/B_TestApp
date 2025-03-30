import 'package:flutter/material.dart';

import '../../core/constants/color_manager.dart';

class NavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final List<BottomNavigationBarItem> items;

  const NavigationBarWidget({
    required this.selectedIndex,
    required this.onTabSelected,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.navbarColor,
      onTap: onTabSelected,
      selectedItemColor: AppColors.navbarActive,
      unselectedItemColor: AppColors.navbarInactive,
      items: items,
    );
  }
}