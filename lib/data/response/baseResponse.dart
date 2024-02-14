// class ApiBaseResponse {
//   Response? response;
//
//   ApiBaseResponse({this.response});
//
//   ApiBaseResponse.fromJson(Map<String, dynamic> json) {
//     response = json['response'] != null
//         ? new Response.fromJson(json['response'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.response != null) {
//       data['response'] = this.response!.toJson();
//     }
//     return data;
//   }
// }

import 'package:rovertaxi/model/booking_Model/createRideModel.dart';

class ApiBaseResponse<T> {
  String? message;
  T? data;
  int? code;
  RideData? rideData;
  T? userData;
  T? taxiData;

  ApiBaseResponse({this.message, this.data, this.code, this.rideData, this.userData, this.taxiData});

  ApiBaseResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'];
    code = json['code'];
    rideData = json['rideData'];
    userData = json['userData'];
    taxiData = json['taxiData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}


