import 'package:bellagio_mobile_user/core/storage/shared_pref_manager.dart';
import 'package:bellagio_mobile_user/data/models/flow_type_model/flow_type_model.dart';
import 'package:bellagio_mobile_user/presentation/pages/chat/chat.dart';
import 'package:bellagio_mobile_user/presentation/pages/chat/chat_options.dart';
import 'package:bellagio_mobile_user/presentation/pages/home/home_screen.dart';
import 'package:bellagio_mobile_user/presentation/pages/notifications/notifications.dart';
import 'package:bellagio_mobile_user/presentation/pages/profile/profile.dart';
import 'package:bellagio_mobile_user/presentation/pages/transactions/transactions.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/color_manager.dart';
import '../../widgets/navigationbar_widget.dart';

class NavbarDashboard extends StatefulWidget {
  final String? userName;
  const NavbarDashboard({super.key, this.userName});

  @override
  State<NavbarDashboard> createState() => _NavbarDashboardState();
}

class _NavbarDashboardState extends State<NavbarDashboard> {
  int _selectedIndex = 0; // Tracks the selected tab
  String userId = "";
  String managerId = "";
  final sharedPrefManager = SharedPrefManager();

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  void getUserId() async {
    final _userId = await sharedPrefManager.getUserId();
    final _managerId = await sharedPrefManager.getManagerId();
    if (_userId != null && _managerId != '') {
      setState(() {
        userId = _userId;
        managerId = _managerId ?? '';
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Pages for each tab
  List<Widget> _pages() => [
        HomeScreen(),
        TransactionsScreen(),
        ChatOptionsScreen(),
        // ChatPage(customerId: userId, salesRefId: managerId),
        NotificationsScreen(),
        ProfileScreen()
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.backgroundColor),
        child: _pages()[_selectedIndex], // Display selected page
      ),
      bottomNavigationBar: NavigationBarWidget(
        selectedIndex: _selectedIndex,
        onTabSelected: (int index) {
           setState(() {
            _selectedIndex = index;
            sharedPrefManager.getManagerId().then((value) {
              setState(() {
                managerId = value ?? '';
              });
            });
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.swap_horiz,
              size: 30,
            ),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              size: 30,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 30,
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 30,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
