import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:rovertaxi/Utilities/res/app_url.dart';

import '../../model/polyline_response.dart';
import 'Constant.dart';
import 'res/color.dart';

class GoogleService {
  /// private constructor
  GoogleService._();

  /// the one and only instance of this singleton
  static final instance = GoogleService._();

  //********************* Draw Polyline *************************
  PolylineResponse polylineResponse = PolylineResponse();
  Set<Polyline> polylinePoints = {};
  String totalDistance = "";
  String totalTime = "";
  int totalDistanceValue = 0;

  Future<PolyLineData> drawPolyline(LatLng origin, LatLng destination) async {
    var response = await http.post(Uri.parse(
        "${AppUrl.googleDirectionUrl}${Constant.GOOGLE_API_KEY}&units=metric&origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving"));

    print(response.body);
    polylineResponse = PolylineResponse.fromJson(jsonDecode(response.body));
    totalDistance = polylineResponse.routes![0].legs![0].distance!.text!;
    totalTime = polylineResponse.routes![0].legs![0].duration!.text!;
    totalDistanceValue =
        polylineResponse.routes![0].legs![0].distance!.value ?? 0;
    for (int i = 0;
        i < polylineResponse.routes![0].legs![0].steps!.length;
        i++) {
      polylinePoints.add(Polyline(
          polylineId: PolylineId(
              polylineResponse.routes![0].legs![0].steps![i].polyline!.points!),
          points: [
            LatLng(
                polylineResponse
                    .routes![0].legs![0].steps![i].startLocation!.lat!,
                polylineResponse
                    .routes![0].legs![0].steps![i].startLocation!.lng!),
            LatLng(
                polylineResponse
                    .routes![0].legs![0].steps![i].endLocation!.lat!,
                polylineResponse
                    .routes![0].legs![0].steps![i].endLocation!.lng!),
          ],
          width: 5,
          color: AppColors.primaryBackgroundColor));
    }

    return PolyLineData(
        polylinePoints, totalDistance, totalTime, totalDistanceValue);
  }
}
