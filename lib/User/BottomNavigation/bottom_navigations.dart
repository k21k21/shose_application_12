import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shose_application_12/User/card/view/card.dart';
import 'package:shose_application_12/User/save/view/favorite_view.dart';
import 'package:shose_application_12/User/home/view/homepage.dart';
import 'package:shose_application_12/User/profile/view/profile_view.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CartPage(),
    const SavedView(),
    const ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _pages),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: SalomonBottomBar(
              currentIndex: _currentIndex,
              onTap: _onBottomNavItemTapped,
              selectedItemColor: Color.fromARGB(255, 132, 242, 244),
              unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              itemPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
              curve: Curves.easeInOut,
              items: [
                SalomonBottomBarItem(
                  icon: Icon(Icons.home, size: 24),
                  title: Text('Home', style: TextStyle(fontSize: 12)),
                ),
                SalomonBottomBarItem(
                  icon: Icon(Icons.shopping_cart, size: 24),
                  title: Text('Card', style: TextStyle(fontSize: 12)),
                ),
                SalomonBottomBarItem(
                  icon: Icon(Icons.bookmark, size: 24),
                  title: Text('Saved', style: TextStyle(fontSize: 12)),
                ),
                SalomonBottomBarItem(
                  icon: Icon(Icons.person, size: 24),
                  title: Text('Profile', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
