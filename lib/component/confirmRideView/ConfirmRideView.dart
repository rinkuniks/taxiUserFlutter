import 'package:flutter/material.dart';

import '../../../Utilities/res/Assets.dart';
import '../../../Utilities/res/color.dart';
import '../../../model/home_Model/TaxiTypeModel.dart';
import '../../Utilities/res/app_url.dart';

class ConfirmRideView extends StatefulWidget {
  const ConfirmRideView({
    super.key,
    required this.typeList,
    this.onTaxiTypeTap,
    this.onBookNowTap,
    required this.selectedCarIndex,
    required this.calculateFair,
    required this.totalDistanceValue,
    required this.totalTime,
    required this.bookNowTitle,
  });

  final List<TaxiTypeData>? typeList;
  final Function? onTaxiTypeTap;
  final Function? onBookNowTap;
  final int selectedCarIndex;
  final String calculateFair;
  final int totalDistanceValue;
  final String totalTime;
  final String bookNowTitle;

  @override
  State<ConfirmRideView> createState() => _ConfirmRideViewState();
}

class _ConfirmRideViewState extends State<ConfirmRideView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        color: AppColors.white,
        child: Column(
          children: [
            widget.bookNowTitle == "Book Now"
                ? SizedBox(
                    height: 120,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.typeList?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: (() => {
                                  // setState(() {
                                  //   widget.selectedCarIndex = index;
                                  // }),
                                  widget.onTaxiTypeTap!(index)
                                }),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: widget.selectedCarIndex == index
                                          ? AppColors.primaryBackgroundColor
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            blurRadius: 10,
                                            spreadRadius: 5)
                                      ]),
                                  child: Column(
                                    children: [
                                      FadeInImage.assetNetwork(
                                        placeholder: Assets.assetsPlaceholder,
                                        image:
                                            widget.typeList?[index].taxiImage ??
                                                AppUrl.placeholderImgUrl,
                                        width: 60,
                                        height: 60,
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, right: 4),
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              widget.typeList?[index]
                                                      .taxiType ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      widget.selectedCarIndex ==
                                                              index
                                                          ? AppColors.white
                                                          : AppColors.black),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, right: 4),
                                            child: Text(
                                              '\$${widget.typeList?[index].pricePerKm ?? ''}/mi',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      widget.selectedCarIndex ==
                                                              index
                                                          ? AppColors.white
                                                          : AppColors.black),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                          );
                        }),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 45,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 20,
                                            spreadRadius: 3)
                                      ],
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.primaryBackgroundColor),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Total Fare",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.white),
                                      ),
                                      Text(
                                        "\$${widget.calculateFair}",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 20,
                                          spreadRadius: 3)
                                    ]),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Pay by Card",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.black),
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Estimated Distance: ${(widget.totalDistanceValue * 0.000621371).roundToDouble()} miles',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black),
                        ),
                        Text(
                          'Estimated Duration: ${widget.totalTime}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black),
                        )
                      ],
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          AppColors.primaryBackgroundColor),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 14, color: Colors.white))),
                  onPressed: () {
                    setState(() {
                      widget.onBookNowTap!();
                    });
                  },
                  child: Text(
                    widget.bookNowTitle,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white),
                  )),
            )
          ],
        ));
  }
}
