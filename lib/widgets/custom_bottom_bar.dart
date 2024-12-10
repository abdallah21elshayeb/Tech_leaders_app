import 'package:flutter/material.dart';
import 'package:tech_test/screens/coursesScreen.dart';
import 'package:tech_test/screens/homeScreen.dart';
import 'package:tech_test/screens/tournementScreen.dart';
import 'package:tech_test/screens/favoriteScreen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  List<Widget> pages = [
    const HomeScreen(),
     CoursesScreen(),
    const TournamentScreen(),
    const FavoriteScreen()
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_page],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          items: [
            getNavBottom(
                icon: Icons.home, pageIndex: 0, title: 'home'),
            getNavBottom(
                icon: Icons.dashboard_rounded, pageIndex: 1, title: 'courses'),
            getNavBottom(
                icon: Icons.emoji_events_rounded,
                pageIndex: 2,
                title: 'tournaments'),

            getNavBottom(
                icon: Icons.person,
                pageIndex: 3,
                title: 'about'),
          ],
          onTap: updatePage,
        ));
  }

  BottomNavigationBarItem getNavBottom(
      {required IconData icon, required String title, required int pageIndex}) {
    return BottomNavigationBarItem(
      icon: Container(
        width: 42,
        // decoration: BoxDecoration(
        //   border: Border(
        //     top: BorderSide(
        //         color: _page == pageIndex ? Colors.yellow : Colors.red,
        //         width: 5),
        //   ),
        // ),
        child: Icon(icon),
      ),
      label: title,
    );
  }
}
