import 'package:flutter/material.dart';
import 'package:rovertaxi/Utilities/res/color.dart';
import 'package:rovertaxi/component/roundedNavigationBar/RoundedNavigationBar.dart';

class RoundedBottomNavigator extends StatefulWidget {
  final List<Widget> pages;
  final List<Widget> tabs;
  final bool showBage;
  const RoundedBottomNavigator(
      {super.key,
      required this.pages,
      required this.tabs,
      this.showBage = false});

  @override
  State<RoundedBottomNavigator> createState() => _RoundedBottomNavigatorState();
}

class _RoundedBottomNavigatorState extends State<RoundedBottomNavigator> {
  final _pageViewController = PageController();

  var selectedIndx = 0;
  int _activePage = 0;

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
        title: const Text('Rounded Bottom Navigation Bar'),
        backgroundColor: AppColors.primaryBackgroundColor,
      ),
      body: PageView(
        controller: _pageViewController,
        children: widget.pages,
        onPageChanged: (index) {
          setState(() {
            _activePage = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        // margin: EdgeInsets.all(16),
        child: RoundedNavigationBar(
            showBage: widget.showBage,
            currentIndex: _activePage,
            items: widget.tabs,
            onTapIndex: (index) {
              setState(() {
                _pageViewController.animateToPage(index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceOut);
              });
            }),
      ),
    );
  }
}
