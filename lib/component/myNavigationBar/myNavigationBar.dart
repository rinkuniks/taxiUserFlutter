import 'package:flutter/material.dart';
import 'package:rovertaxi/Utilities/res/color.dart';
import 'package:rovertaxi/view/BottomNavigator/bottomNavigator.dart';

import 'navigationAnimator/ButtonNotch.dart';

class MyNavigationBar extends StatefulWidget {
  final List<Tabs>? items;
  final Function? onTapIndex;
  final int? currentIndex;
  const MyNavigationBar(
      {super.key, this.items, this.onTapIndex, this.currentIndex});

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: navigationBar(),
          )
        ],
      ),
    );
  }

  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      height: 90.0,
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          widget.items?.length ?? 0,
          (index) {
            return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.onTapIndex!(index);
                  });
                },
                child: iconBtn(index));
          },
        ),
      ),
    );
  }

  SizedBox iconBtn(int i) {
    bool isActive = widget.currentIndex == i ? true : false;
    var height = isActive ? 60.0 : 0.0;
    var width = isActive ? 50.0 : 0.0;
    return SizedBox(
      // width: 75.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              height: height,
              width: width,
              duration: const Duration(milliseconds: 600),
              child: isActive
                  ? CustomPaint(
                      painter: ButtonNotch(),
                    )
                  : const SizedBox(),
            ),
          ),
          isActive
              ? Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                            color: widget.items?[i].color,
                            borderRadius: BorderRadius.circular(7)),
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: widget.items?[i].icon)
                  ],
                )
              : Align(
                  alignment: Alignment.center, child: widget.items?[i].icon),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Text(
          //     navBtn[i].name,
          //   ),
          // )
        ],
      ),
    );
  }
}
