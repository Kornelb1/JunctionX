import 'package:flutter/material.dart';
import 'package:frontend/pages/scr_home.dart';
import 'package:frontend/pages/scr_notifications.dart';
import 'package:frontend/pages/scr_profile.dart';
import 'package:frontend/pages/scr_search.dart';
import 'package:frontend/pages/scr_stats.dart';
import 'package:frontend/providers/home_provider.dart';
import 'package:frontend/providers/notification_provider.dart';
import 'package:frontend/providers/profile_provider.dart';
import 'package:frontend/providers/search_provider.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({Key? key}) : super(key: key);

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    List<Widget> _buildScreens() {
      return [
        SearchProvider(child: const SearchScreen()),
        NotificationProvider(child: const NotificationScreen()),
        HomeProvider(child: const HomeScreen()),
        ProfileProvider(child: StatisticsScreen()),
        ProfileProvider(child: const ProfileScreen())
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          inactiveIcon: Icon(Icons.search),
          icon: Icon(Icons.search),
          activeColorPrimary: theme.colors.green,
          inactiveColorPrimary: theme.colors.darkgrey,
        ),
        PersistentBottomNavBarItem(
          inactiveIcon: Icon(Icons.notifications_none),
          icon: Icon(Icons.notifications),
          activeColorPrimary: theme.colors.green,
          inactiveColorPrimary: theme.colors.darkgrey,
        ),
        PersistentBottomNavBarItem(
          inactiveIcon: Icon(Icons.home_outlined),
          icon: Icon(Icons.home_filled),
          activeColorPrimary: theme.colors.green,
          inactiveColorPrimary: theme.colors.darkgrey,
        ),
        PersistentBottomNavBarItem(
          inactiveIcon: Icon(Icons.bar_chart_outlined),
          icon: Icon(Icons.bar_chart),
          activeColorPrimary: theme.colors.green,
          inactiveColorPrimary: theme.colors.darkgrey,
        ),
        PersistentBottomNavBarItem(
          inactiveIcon: Icon(Icons.account_circle_outlined),
          icon: Icon(Icons.account_circle),
          activeColorPrimary: theme.colors.green,
          inactiveColorPrimary: theme.colors.darkgrey,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: theme.colors.lightgrey, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}
