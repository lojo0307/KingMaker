import 'package:flutter/material.dart';
import 'package:kingmaker/page/alarm_page.dart';
import 'package:kingmaker/page/calendar_page.dart';
import 'package:kingmaker/page/home_page.dart';
import 'package:kingmaker/page/profile_page.dart';
import 'package:kingmaker/page/todo_page.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PersistentTabController controller = PersistentTabController(initialIndex: 2);
    Provider.of<ScheduleProvider>(context, listen: false).getList();
    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: false,
      backgroundColor: Colors.transparent, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: false, // Default is true.
      hideNavigationBarWhenKeyboardShows: false, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: const NavBarDecoration(
        colorBehindNavBar: Colors.white
      ),
      popAllScreensOnTapOfSelectedTab: false,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
List<Widget> _buildScreens() {
  return [
    const TodoPage(),
    const CalendarPage(),
    const HomePage(),
    const AlarmPage(),
    const ProfilePage()
  ];
}
List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Image.asset('assets/icon/todo.png', color: Colors.black,scale: 0.7,),
      // title: ("Todo"),
      inactiveIcon: Image.asset('assets/icon/todo.png', color: Colors.black87),
    ),
    PersistentBottomNavBarItem(
      icon: Image.asset('assets/icon/calendar.png', color: Colors.black,scale: 0.7,),
      // title: ("Calendar"),
      inactiveIcon: Image.asset('assets/icon/calendar.png', color: Colors.black87),
    ),
    PersistentBottomNavBarItem(
      icon: Image.asset('assets/icon/home.png', color: Colors.black,scale: 0.7,),
      // title: ("Home"),
      inactiveIcon: Image.asset('assets/icon/home.png', color: Colors.black87),
    ),
    PersistentBottomNavBarItem(
      icon: Image.asset('assets/icon/alarm.png', color: Colors.black,scale: 0.7,),
      // title: ("Alarm"),
      inactiveIcon: Image.asset('assets/icon/alarm.png', color: Colors.black87),
    ),
    PersistentBottomNavBarItem(
      icon: Image.asset('assets/icon/profile.png', color: Colors.black,scale: 0.7,),
      // title: ("Profile"),
      inactiveIcon: Image.asset('assets/icon/profile.png', color: Colors.black87),
    ),
  ];// NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
}