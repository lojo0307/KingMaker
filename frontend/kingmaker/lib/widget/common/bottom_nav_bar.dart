import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kingmaker/consts/colors.dart';
import 'package:kingmaker/page/alarm_page.dart';
import 'package:kingmaker/page/calendar_page.dart';
import 'package:kingmaker/page/home_page.dart';
import 'package:kingmaker/page/profile_page.dart';
import 'package:kingmaker/page/todo_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PersistentTabController controller = PersistentTabController(initialIndex: 2);
    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: false,
      backgroundColor: Colors.transparent, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: false, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: false, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: const NavBarDecoration(
        colorBehindNavBar: Colors.white
      ),
      popAllScreensOnTapOfSelectedTab: true,
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
      icon: SvgPicture.asset('assets/icon/ic_todo.svg'),
      // icon: Image.asset('assets/icon/todo.png', color: Colors.black,scale: 0.7,),
      // title: ("Todo"),
      inactiveIcon: SvgPicture.asset('assets/icon/ic_todo.svg', color: DARK_GREY_COLOR,),
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset('assets/icon/ic_calendar.svg'),
      // icon: Image.asset('assets/icon/calendar.png', color: Colors.black,scale: 0.7,),
      // title: ("Calendar"),
      inactiveIcon: SvgPicture.asset('assets/icon/ic_calendar.svg', color: DARK_GREY_COLOR,),
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset('assets/icon/ic_home.svg'),
      // icon: Image.asset('assets/icon/home.png', color: Colors.black,scale: 0.7,),
      // title: ("Home"),
      inactiveIcon: SvgPicture.asset('assets/icon/ic_home.svg', color: DARK_GREY_COLOR,),
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset('assets/icon/ic_alarm.svg'),
      // icon: Image.asset('assets/icon/alarm.png', color: Colors.black,scale: 0.7,),
      // title: ("Alarm"),
      inactiveIcon: SvgPicture.asset('assets/icon/ic_alarm.svg', color: DARK_GREY_COLOR,),
    ),
    PersistentBottomNavBarItem(
      icon: SvgPicture.asset('assets/icon/ic_profile.svg'),
      // icon: Image.asset('assets/icon/profile.png', color: Colors.black,scale: 0.7,),
      // title: ("Profile"),
      inactiveIcon: SvgPicture.asset('assets/icon/ic_profile.svg', color: DARK_GREY_COLOR,),
    ),
  ];// NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
}