import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rovertaxi/model/booking_Model/createRideModel.dart';

import '../Utilities/res/app_url.dart';
import '../Utilities/res/color.dart';

class RideStatusView extends StatefulWidget {
  const RideStatusView({super.key, this.rideResponse, this.onTapActionBtns});

  final Function? onTapActionBtns;
  final CreateRideResponse? rideResponse;

  @override
  State<RideStatusView> createState() => _RideStatusViewState();
}

class _RideStatusViewState extends State<RideStatusView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: AppColors.grey)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40.0),
                            child: FadeInImage.assetNetwork(
                              placeholder: AppUrl.driverplaceholderImgUrl,
                              image: widget
                                      .rideResponse?.driverData?.profileImage ??
                                  AppUrl.driverplaceholderImgUrl,
                            ),
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.rideResponse?.driverData?.name ?? "",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          RatingBar.builder(
                            initialRating: double.parse(
                                widget.rideResponse?.rideData?.rating),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 30,
                            // itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Ride Otp",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.rideResponse?.rideData?.rideOtp ?? "000000",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 1.5,
              width: MediaQuery.of(context).size.width * 0.9,
              color: AppColors.grayLine,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Manufecturing Details: ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black),
                ),
                Expanded(
                  child: Text(
                    widget.rideResponse?.taxiData?.manufacturingDetails ?? "",
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'License Plate: ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black),
                ),
                Text(
                  widget.rideResponse?.taxiData?.vehicleRegistrationNumber ??
                      "",
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: (() => widget.onTapActionBtns!(0)),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 5)
                            ]),
                        child: const Icon(Icons.call, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: (() => widget.onTapActionBtns!(1)),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 5)
                            ]),
                        child:
                            const Icon(Icons.location_pin, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: (() => widget.onTapActionBtns!(2)),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 5)
                            ]),
                        child: const Icon(Icons.do_not_disturb_alt_outlined,
                            color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: (() => widget.onTapActionBtns!(3)),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 5)
                            ]),
                        child: const Icon(Icons.share, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: (() => widget.onTapActionBtns!(4)),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 5)
                            ]),
                        child:
                            const Icon(Icons.my_location, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  width: 1.5,
                  color: AppColors.grayLine,
                ),
                SizedBox(
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Estimated cash to be paid',
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black),
                      ),
                      Text(
                        '\$${widget.rideResponse?.rideData?.estimatedCost ?? '0.0'}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                widget.rideResponse?.rideData?.rideStatus ?? "",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
