import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:notification_center/notification_center.dart';
import 'package:rovertaxi/Utilities/Constant.dart';
import 'package:rovertaxi/Utilities/utils.dart';

import '../../Utilities/googleService.dart';
import '../../Utilities/res/Assets.dart';
import '../../Utilities/res/color.dart';
import '../../model/booking_Model/createRideModel.dart';
import '../../model/polyline_response.dart';

class TrackRideView extends StatefulWidget {
  const TrackRideView(
      {super.key, this.origin, this.destination, this.driverData});

  final LatLng? origin;
  final LatLng? destination;
  final DriverData? driverData;

  @override
  State<TrackRideView> createState() => _TrackRideViewState();
}

class _TrackRideViewState extends State<TrackRideView> {
  late GoogleMapController googleMapController;
  Set<Polyline> polylinePoints = {};
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 10);
  Set<Marker> markersList = {};
  PolyLineData? polyLineData;
  late BitmapDescriptor customIcon;
  var distance = '0.0';

  @override
  void initState() {
    super.initState();
    initialSetup();
  }

  initialSetup() async {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(5, 5)), Assets.assetsCarIcon)
        .then((d) {
      customIcon = d;
    });

    await GoogleService.instance
        .drawPolyline(widget.origin!, widget.destination!)
        .then((value) => setState(() {
              polyLineData = value;
              distance = value.totalDistance;
              googleMapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(
                          widget.origin!.latitude, widget.origin!.longitude),
                      zoom: 10)));
              polylinePoints = value.polylinePoints;
              setMarkersOnMap(widget.driverData);
            }));
    _notifyDriverData();
  }

  ///SET MARKER ON MAP
  setMarkersOnMap(DriverData? driverData) {
    markersList.clear();
    markersList
        .add(Marker(markerId: const MarkerId("0"), position: widget.origin!));
    markersList.add(
        Marker(markerId: const MarkerId("1"), position: widget.destination!));
    if (driverData != null) {
      markersList.add(Marker(
          zIndex: 99,
          rotation: Utils.calculateBearing(widget.origin!, widget.destination!),
          markerId: const MarkerId("2"),
          position: LatLng(double.parse(driverData.driverLat ?? '0.0'),
              double.parse(driverData.driverLng ?? '0.0')),
          icon: customIcon));
    }
  }

  /// NOTIFICATION CENTER
  _notifyDriverData() {
    NotificationCenter().subscribe(Constant.NOTIFCENTER_RIDE_STATUS_NOTIFY,
        (CreateRideResponse value) {
      var _distanceInMeters = Geolocator.distanceBetween(
        widget.origin!.latitude,
        widget.origin!.longitude,
        widget.destination!.latitude,
        widget.destination!.longitude,
      );
      setState(() {
        print('???????????????::: ${value.driverData?.driverLat}');
        print('???????????????::: ${_distanceInMeters}');
        // var source = LatLng(double.parse(value.driverData?.driverLat ?? '0.0'),
        //     double.parse(value.driverData?.driverLng ?? '0.0'));
        // distance =
        //     '${Utils.calculateDistance(widget.origin!, widget.destination!)}';
        setMarkersOnMap(value.driverData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Ride"),
        backgroundColor: AppColors.primaryBackgroundColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (() => {Navigator.pop(context)}),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: GoogleMap(
              polylines: polylinePoints,
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: initialCameraPosition,
              markers: markersList,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Total Distance',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          distance,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Estimated Time',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${polyLineData?.totalTime}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
