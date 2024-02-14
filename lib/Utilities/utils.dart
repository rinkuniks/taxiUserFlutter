import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static void flushBarError(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.all(30),
          message: message,
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.circular(30),
          duration: const Duration(seconds: 2),
        )..show(context));
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.blue,
        content: Text(message)));
  }

  static disableLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
    //Navigator.pop(context);
  }

  static alertLoader(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              // width: MediaQuery.of(context).size.width * .02,
              child: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  static removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("token");
    prefs.remove('name');
    //Remove bool
    // prefs.remove("boolValue");
  }

  static addStringToSF(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static addIntToSF(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static getIntValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? intValue = prefs.getInt(key);
    return intValue;
  }

  static getStringValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(key);
    print('{{{{{{{{{{{{{{}}}}}}}}}}}}}}${key}');
    print('{{{{{{{{{{{{{{}}}}}}}}}}}}}}${stringValue}');
    return stringValue;
  }

  static removeValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static calculateDistance(LatLng startPoint, LatLng endPoint) {
    const r = 3958.8; // Earth radius in Miles

    final double startLat = toRadians(startPoint.latitude);
    final double startLng = toRadians(startPoint.longitude);
    final double endLat = toRadians(endPoint.latitude);
    final double endLng = toRadians(endPoint.longitude);

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((endLat - startLat) * p) / 2 +
        c(startLat * p) * c(endLat * p) * (1 - c((endLng - startLng) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static calculateBearing(LatLng startPoint, LatLng endPoint) {
    final double startLat = toRadians(startPoint.latitude);
    final double startLng = toRadians(startPoint.longitude);
    final double endLat = toRadians(endPoint.latitude);
    final double endLng = toRadians(endPoint.longitude);
    final double deltaLng = endLng - startLng;
    final double y = sin(deltaLng) * cos(endLat);
    final double x = cos(startLat) * sin(endLat) -
        sin(startLat) * cos(endLat) * cos(deltaLng);
    final double bearing = atan2(y, x);
    return (toDegrees(bearing) + 360) % 360;
  }

  static toRadians(double degrees) {
    return degrees * (pi / 180.0);
  }

  static toDegrees(double radians) {
    return radians * (180.0 / pi);
  }

  static _haversin(double radians) => pow(sin(radians / 2), 2);

  static logInDebug(String str) {
    assert(() {
      // log(str);
      // log(str);
      return true;
    }());
  }

  static bool isOnlyNumber(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  static timeFormat(time) {
    return DateFormat.jm()
        .format(DateFormat("hh:mm:ss").parse(time.toString()));
  }
}
