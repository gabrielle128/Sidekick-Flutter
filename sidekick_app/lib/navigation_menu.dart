import 'package:flutter/material.dart';
import 'package:sidekick_app/screens/home_screen.dart';
import 'package:sidekick_app/screens/journal/journal_screen.dart';
import 'package:sidekick_app/screens/todo/todo_screen.dart';
import 'package:sidekick_app/screens/wallet_screen.dart';
import 'package:sidekick_app/utils/sidekick_icons_icons.dart';
import 'package:sidekick_app/utils/colours.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int myCurrentIndex = 0;
  List pages = [
    const HomeScreen(),
    const ToDoScreen(),
    const JournalScreen(),
    const WalletScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: bgcolor, boxShadow: [BoxShadow(color: grey, blurRadius: 1)]),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: bgcolor,
            selectedItemColor: black,
            unselectedItemColor: grey,
            showUnselectedLabels: false,
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(SidekickIcons.hut), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(SidekickIcons.toDoList), label: 'To Do'),
              BottomNavigationBarItem(
                  icon: Icon(SidekickIcons.journal), label: 'Journal'),
              BottomNavigationBarItem(
                  icon: Icon(SidekickIcons.wallet), label: 'Wallet'),

              // <--- TO IMPORT IMAGE AS ICON --->
              // BottomNavigationBarItem(
              //     icon: ImageIcon(AssetImage("assets/images/sidekick_logo.png"),
              //         size: 24),
              //     label: 'sidekick')
            ]),
      ),
      body: pages[myCurrentIndex],
    );
  }
}


// bottomNavigationBar: NavigationBar(
//           height: 80,
//           elevation: 0,
//           selectedIndex: 0,
//           onDestinationSelected: (index) => ,
//           destinations: const [
//             NavigationDestination(icon: Icon(SidekickIcons.hut), label: 'Home'),
//             NavigationDestination(
//                 icon: Icon(SidekickIcons.to_do_list), label: 'To Do'),
//             NavigationDestination(
//                 icon: Icon(SidekickIcons.journal), label: 'Journal'),
//             NavigationDestination(
//                 icon: Icon(SidekickIcons.wallet), label: 'Wallet'),
//           ]),
//           body: Container(),