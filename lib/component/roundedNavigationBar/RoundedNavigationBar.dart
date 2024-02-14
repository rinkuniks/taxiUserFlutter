import 'package:flutter/material.dart';
import 'package:rovertaxi/Utilities/res/color.dart';

class RoundedNavigationBar extends StatefulWidget {
  final List<Widget> items;
  final Function? onTapIndex;
  final int currentIndex;
  final bool showBage;
  const RoundedNavigationBar(
      {super.key,
      required this.items,
      this.onTapIndex,
      required this.currentIndex,
      this.showBage = false});

  @override
  State<RoundedNavigationBar> createState() => _RoundedNavigationBarState();
}

class _RoundedNavigationBarState extends State<RoundedNavigationBar> {
  int selctedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.primaryBackgroundColor,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.withOpacity(0.3),
            offset: const Offset(0, 20),
            blurRadius: 20,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            widget.items.length,
            (index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.onTapIndex!(index);
                      selctedNavIndex = index;
                    });
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: widget.currentIndex == index
                            ? AppColors.white
                            : AppColors.primaryBackgroundColor),
                    child: (index == widget.items.length - 1 && widget.showBage)
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              widget.items[index],
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 30, right: 25),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5)),
                                  height: 10,
                                  width: 10,
                                ),
                              ),
                            ],
                          )
                        : widget.items[index],
                  ));
            },
          ),
        ),
      ),
    );
  }
}
