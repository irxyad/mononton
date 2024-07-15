import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mononton/screens/homepage.dart';

import '../constanta.dart';
import '../screens/temp_screen.dart';

class MyNavbar extends StatefulWidget {
  const MyNavbar({
    super.key,
    required this.watchlist,
  });
  final List watchlist;
  @override
  State<MyNavbar> createState() => _MyNavbarState();
}

class _MyNavbarState extends State<MyNavbar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        currentIndex: _currentIndex,
        selectedItemColor: white,
        unselectedItemColor: white,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
            switch (_currentIndex) {
              case 1:
                Get.to(() => const TicketPage(),
                    transition: Transition.downToUp);
                break;
              case 2:
                Get.to(() => const WatchlistPage(),
                    transition: Transition.downToUp);
                break;
              default:
                Get.to(() => const HomePage(), transition: Transition.upToDown);
            }
          });
        },
        items: [
          BottomNavigationBarItem(
              tooltip: 'Home',
              label: _currentIndex == 0 ? '•' : '',
              icon: SvgPicture.asset(
                'assets/icons/ic_home.svg',
                colorFilter: ColorFilter.mode(
                    _currentIndex == 0 ? white : grey, BlendMode.srcIn),
              )),
          BottomNavigationBarItem(
              tooltip: 'My ticket',
              label: _currentIndex == 1 ? '•' : '',
              icon: SvgPicture.asset(
                'assets/icons/ic_ticket.svg',
                colorFilter: ColorFilter.mode(
                    _currentIndex == 1 ? white : grey, BlendMode.srcIn),
              )),
          BottomNavigationBarItem(
              tooltip: 'Watchlist',
              label: _currentIndex == 2 ? '•' : '',
              icon: SvgPicture.asset(
                'assets/icons/ic_mylist.svg',
                colorFilter: ColorFilter.mode(
                    _currentIndex == 2 ? white : grey, BlendMode.srcIn),
              )),
        ]);
  }
}
