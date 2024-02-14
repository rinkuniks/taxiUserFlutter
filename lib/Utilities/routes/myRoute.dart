import 'package:flutter/material.dart';
import 'package:rovertaxi/view/BottomNavigator/bottomNavigator.dart';
import 'package:rovertaxi/view/BottomNavigator/roundedBottomNavigator.dart';
import 'package:rovertaxi/view/preAuth/splashView.dart';
import 'package:rovertaxi/view/trackRideView/trackRideView.dart';

import '../../view/home/homeView.dart';
import 'routes_name.dart';

class MyRoute {
  static const List<Widget> tabsList = [
    Icon(Icons.home_filled, size: 30),
    Icon(Icons.calendar_today_outlined, size: 30),
    Icon(Icons.account_circle_outlined, size: 30),
  ];
  static List<Widget> pagesList = [
    Container(
      color: Colors.red,
      child: const Center(
        child: Text(
          'Home',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
    ),
    Container(
      color: Colors.green,
      child: const Center(
        child: Text(
          'Calendar',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
    ),
    Container(
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
    )
  ];

  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //PreAuth
      case RoutesName.splshView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());

      case RoutesName.homeView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeView());

      case RoutesName.trackRideView:
        return MaterialPageRoute(
            builder: (BuildContext context) => const TrackRideView());

      case RoutesName.navigationBar:
        return MaterialPageRoute(
            builder: (BuildContext context) => BottomNavigator());

      case RoutesName.roundedNavigationBar:
        return MaterialPageRoute(
            builder: (BuildContext context) => RoundedBottomNavigator(
                  pages: pagesList,
                  tabs: tabsList,
                  showBage: true,
                ));

      //Default Route

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Scaffold(
                  body: Center(
                    child: Text('No Route found...'),
                  ),
                ));
    }
  }
}
