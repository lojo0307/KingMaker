import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/page/alarm_page.dart';
import 'package:kingmaker/page/calendar_page.dart';
import 'package:kingmaker/page/home_page.dart';
import 'package:kingmaker/page/profile_page.dart';
import 'package:kingmaker/page/todo_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 2);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.transparent, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: const NavBarDecoration(
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      const TodoPage(),
      const CalendarPage(),
      const HomePage(),
      const AlarmPage(),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/icon/ic_todo.svg'),
        inactiveIcon: SvgPicture.asset('assets/icon/ic_todo.svg', color: DARK_GREY_COLOR),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/icon/ic_calendar.svg'),
        inactiveIcon: SvgPicture.asset('assets/icon/ic_calendar.svg', color: DARK_GREY_COLOR),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/icon/ic_home.svg'),
        inactiveIcon: SvgPicture.asset('assets/icon/ic_home.svg', color: DARK_GREY_COLOR),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/icon/ic_alarm.svg'),
        inactiveIcon: SvgPicture.asset('assets/icon/ic_alarm.svg', color: DARK_GREY_COLOR),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/icon/ic_profile.svg'),
        inactiveIcon: SvgPicture.asset('assets/icon/ic_profile.svg', color: DARK_GREY_COLOR),
      ),
    ];
  }
}
