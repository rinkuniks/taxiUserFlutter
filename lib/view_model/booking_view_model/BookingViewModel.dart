import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rovertaxi/model/booking_Model/createRideModel.dart';

import '../../Utilities/Constant.dart';
import '../../Utilities/utils.dart';
import '../../respository/booking_repository/booking_repository.dart';

class BookingViewModel with ChangeNotifier {
  final _myRepo = BookingRepository();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// for create Ride
  Future<CreateRideResponse> createRide(
      dynamic data, BuildContext context) async {
    CreateRideResponse createRideResponse = CreateRideResponse();
    setLoading(true);
    Utils.alertLoader(context);
    await _myRepo.createRideAPI(data).then((value) async {
      setLoading(false);
      Utils.disableLoader(context);
      createRideResponse = CreateRideResponse.fromJson(value['response']);
      if (createRideResponse.code == 200) {}
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print("-----CREATE RIDE${error.toString()}");
      }
    });
    return createRideResponse;
  }

  /// for Expire Ride
  Future<void> expireRide(dynamic data, BuildContext context) async {
    CreateRideResponse createRideResponse = CreateRideResponse();
    setLoading(true);
    // Utils.alertLoader(context);
    await _myRepo.expireRideAPI(data).then((value) async {
      setLoading(false);
      // Utils.disableLoader(context);
      Utils.removeValuesSF(Constant.RIDE_DATA);
      // createRideResponse = CreateRideResponse.fromJson(value['response']);
      // if (createRideResponse.code == 200) {}
    }).onError((error, stackTrace) {
      setLoading(false);
      // Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print("-----Expire RIDE${error.toString()}");
      }
    });
  }

  /// for Get Ride Status
  Future<CreateRideResponse> getRideStatus(
      dynamic data, BuildContext context) async {
    CreateRideResponse createRideResponse = CreateRideResponse();
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      setLoading(true);
      // Utils.alertLoader(context);
      await _myRepo.getRideStatusAPI(data).then((value) async {
        setLoading(false);
        // Utils.disableLoader(context);
        createRideResponse = CreateRideResponse.fromJson(value['response']);

        ///Save response in local
        if (createRideResponse.rideData?.rideId != null) {
          Utils.addIntToSF(
              Constant.RIDE_ID, createRideResponse.rideData?.rideId ?? 0);
          // Utils.addStringToSF(Constant.RIDE_PICKUPLAT,
          //     createRideResponse.rideData?.pickupLat ?? '');
          // Utils.addStringToSF(Constant.RIDE_PICKUPLong,
          //     createRideResponse.rideData?.pickupLng ?? '');
          // Utils.addStringToSF(
          //     Constant.RIDE_DROPLAT, createRideResponse.rideData?.dropLat ?? '');
          // Utils.addStringToSF(
          //     Constant.RIDE_DROPLONG, createRideResponse.rideData?.dropLng ?? '');
        }
        String encodeData = jsonEncode(createRideResponse);
        Utils.addStringToSF(Constant.RIDE_DATA, encodeData);
        if (createRideResponse.code == 200) {}
      }).onError((error, stackTrace) {
        setLoading(false);
        // Utils.toastMessage(error.toString());
        if (kDebugMode) {
          print("-----GET RIDE STATUS${error.toString()}");
        }
      });
      return createRideResponse;
    } else {
      return await getRideDataFromLocal();
    }
  }

  Future<CreateRideResponse> getRideDataFromLocal() async {
    CreateRideResponse createRideResponse = CreateRideResponse();
    String? rideDataStr = await Utils.getStringValuesSF(Constant.RIDE_DATA);
    if (rideDataStr != null) {
      Map<String, dynamic> jsonData = json.decode(rideDataStr);
      createRideResponse = CreateRideResponse.fromJson(jsonData);
    }
    return createRideResponse;
  }
}
