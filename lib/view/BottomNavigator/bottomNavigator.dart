import 'package:flutter/material.dart';
import 'package:rovertaxi/Utilities/res/color.dart';

import '../../component/myNavigationBar/myNavigationBar.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _pageViewController = PageController();
  var selectedIndx = 0;
  int _activePage = 0;

  final List<Tabs> tabs = [
    Tabs(
        const Icon(
          Icons.home_outlined,
          size: 30,
        ),
        Colors.red),
    Tabs(
        const Icon(
          Icons.notifications_none_outlined,
          size: 30,
        ),
        Colors.green),
    Tabs(
        const Icon(
          Icons.add_box_outlined,
          size: 30,
        ),
        Colors.blue),
    Tabs(
        const Icon(
          Icons.calendar_today_outlined,
          size: 30,
        ),
        Colors.grey),
    Tabs(
        const Icon(
          Icons.settings_outlined,
          size: 30,
        ),
        Colors.yellow),
  ];

  final List<Widget> pagesList = [
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
          'Notification',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
    ),
    Container(
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Task',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
    ),
    Container(
      color: Colors.grey,
      child: const Center(
        child: Text(
          'Calendar',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
    ),
    Container(
      color: Colors.yellow,
      child: const Center(
        child: Text(
          'Setting',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
    )
  ];

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Bottom Navigation Bar'),
        backgroundColor: AppColors.primaryBackgroundColor,
      ),
      body: PageView(
        controller: _pageViewController,
        children: pagesList,
        onPageChanged: (index) {
          setState(() {
            _activePage = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
        child: MyNavigationBar(
            currentIndex: _activePage,
            items: tabs,
            onTapIndex: (index) {
              _pageViewController.animateToPage(index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.bounceOut);
            }),
      ),
    );
  }
}

class Tabs {
  final Widget icon;
  final Color color;

  Tabs(this.icon, this.color);
}
