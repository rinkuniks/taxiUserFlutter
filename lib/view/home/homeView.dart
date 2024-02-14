import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as webs;
import 'package:notification_center/notification_center.dart';
import 'package:rovertaxi/Utilities/Constant.dart';
import 'package:rovertaxi/Utilities/googleService.dart';
import 'package:rovertaxi/Utilities/res/Assets.dart';
import 'package:rovertaxi/component/rideStatusView.dart';
import 'package:rovertaxi/model/booking_Model/createRideModel.dart';
import 'package:rovertaxi/model/home_Model/TaxiTypeModel.dart';
import 'package:rovertaxi/model/profileModel/profileModel.dart';
import 'package:rovertaxi/view/home/search_places_screen.dart';
import 'package:rovertaxi/view/trackRideView/trackRideView.dart';
import 'package:rovertaxi/view_model/homeViewModel/home_view_model.dart';
import 'package:rovertaxi/view_model/profileViewModel/ProfileViewModel.dart';

import '../../Utilities/res/color.dart';
import '../../Utilities/routes/routes_name.dart';
import '../../Utilities/utils.dart';
import '../../component/confirmRideView/ConfirmRideView.dart';
import '../../component/drawer/AppDrawer.dart';
import '../../model/home_Model/nearByDriverModel.dart';
import '../../model/polyline_response.dart';
import '../../view_model/booking_view_model/BookingViewModel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  LatLng? _latLng;

  final Mode _mode = Mode.overlay;
  Set<Marker> markersList = {};
  String pickupAddress = 'Select Pickup Address';
  String dropAddress = 'Select Drop Address';
  bool isPickupSelect = false;
  PolylineResponse polylineResponse = PolylineResponse();
  Set<Polyline> polylinePoints = {};

  // String totalDistance = "";
  // int totalDistanceValue = 0;
  // String totalTime = "";
  LatLng origin = const LatLng(28.457523, 77.026344);
  LatLng destination = const LatLng(0.0, 0.0);
  String selectedTaxiID = '';
  String bookNowTitle = "Book Now";
  late BitmapDescriptor customIcon;
  int selectedCarIndex = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeViewModel homeViewModel = HomeViewModel();
  ProfileViewModel profileViewModel = ProfileViewModel();
  BookingViewModel bookingViewModel = BookingViewModel();
  List<TaxiTypeData>? typeList;
  List<NearByDriverModel>? driverList;
  CreateRideResponse? bookingModel;
  ProfileModel? profileModel;
  PolyLineData? polyLineData;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(5, 5)), Assets.assetsCarIcon)
        .then((d) {
      customIcon = d;
    });
    getCurrentLocation();
    getTaxiTypes();
    getUserProfile();
    initialSetup();
  }

  initialSetup() async {
    if (bookingModel?.rideData?.rideId != null &&
        bookingModel?.rideData?.rideId != 0) {
      getRideStatusAPI('${bookingModel?.rideData?.rideId!}');
    } else {
      var rideId = await Utils.getIntValuesSF(Constant.RIDE_ID);
      if (rideId != null && rideId != 0) {
        getRideStatusAPI('$rideId');
      }
    }
  }

  ///********************* Get Current Location **************************
  getCurrentLocation() async {
    Position position = await _determinePosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    pickupAddress =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    _latLng = LatLng(position.latitude, position.longitude);
    origin = LatLng(position.latitude, position.longitude);
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 10)));
    markersList.clear();
    markersList.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(position.latitude, position.longitude)));
    setState(() {});
    getNearByDrivers();
  }

  ///Determine Position
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showAlertDialog();
      return Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showAlertDialog();
        return Future.error("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showAlertDialog();
      return Future.error('Location permissions are permanently denied');
    }
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  showAlertDialog() => showCupertinoDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Permission Denied'),
          content: const Text('Allow access to gallery and photos'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Geolocator.openLocationSettings(),
              child: const Text('Settings'),
            ),
          ],
        ),
      );

  ///***************** handle Ride Status ***********************
  _handleRideStatus(CreateRideResponse value) {
    print("*******************${value.rideData?.rideId ?? 0}");
    if (value.rideData?.rideStatus != Constant.TRIP_STATUS_CANCELED &&
        value.rideData?.rideStatus != Constant.TRIP_STATUS_END &&
        value.rideData?.rideStatus != Constant.TRIP_USER_EXPIRED) {
      if (value.rideData?.rideId != null) {
        callAgainRideStatusApi('${value.rideData?.rideId}');
        setState(() {
          pickupAddress = value.rideData?.pickupAddress ?? '';
          dropAddress = value.rideData?.dropAddress ?? '';
          var pickupLat = double.parse(value.rideData?.pickupLat ?? '0.0');
          var pickupLong = double.parse(value.rideData?.pickupLng ?? '0.0');
          var dropLat = double.parse(value.rideData?.dropLat ?? '0.0');
          var dropLong = double.parse(value.rideData?.dropLng ?? '0.0');
          origin = LatLng(pickupLat, pickupLong);
          destination = LatLng(dropLat, dropLong);
          if (polylinePoints.isEmpty) {
            print('MMMMMMMMMMMMMMMM');
            GoogleService.instance
                .drawPolyline(origin, destination)
                .then((value) => setState(() {
                      polyLineData = value;
                      polylinePoints = value.polylinePoints;
                    }));
            setDriversOnMap(null);
          }
        });
      }
    } else {
      print('>>>>>>>>>>>>>>>>>>>>>>>46');
      if (value.rideData?.rideStatus == Constant.TRIP_STATUS_CANCELED ||
          value.rideData?.rideStatus == Constant.TRIP_STATUS_END) {
        _resetHomeView();
      } else if (value.rideData?.rideStatus == Constant.TRIP_STATUS_CONFIRMED ||
          value.rideData?.rideStatus == Constant.TRIP_STATUS_ARRIVING ||
          value.rideData?.rideStatus == Constant.TRIP_STATUS_REACHED ||
          value.rideData?.rideStatus == Constant.TRIP_STATUS_BEGIN) {
        print('>>>>>>>>>>>>>>>>>>>>>>>45');
      }
    }
  }

  ///***************** Call Again Get Ride Status API ***********************
  callAgainRideStatusApi(String rideId) {
    Future.delayed(const Duration(seconds: 8), () {
      print(
        "RIDEID AFTER DELAY:$rideId",
      );
      getRideStatusAPI(rideId);
    });
  }

  ///***************** Get Ride Status API ***********************
  getRideStatusAPI(String rideID) async {
    Map params = {
      'ride_id': rideID,
    };
    await bookingViewModel.getRideStatus(params, context).then((value) => {
          setState(() {
            bookingModel = value;
            NotificationCenter()
                .notify(Constant.NOTIFCENTER_RIDE_STATUS_NOTIFY, data: value);
          }),
          _handleRideStatus(value)
        });
  }

  ///***************** Expire Ride API ***********************
  expireRideAPI() async {
    print('Expire Ride Called');
    Map params = {
      'ride_id': '${bookingModel?.rideData?.rideId ?? 0}',
      'cancel': '1',
      'ride_type': 'ride',
      'cancel_type': 'user',
      'taxi_type_id': selectedTaxiID,
      'cancel_reason': "User has cancelled the ride request",
      'ride_status': Constant.TRIP_STATUS_CANCELED,
    };
    await bookingViewModel
        .expireRide(params, context)
        .then((value) => setState(() {
              _resetHomeView();
            }));
  }

  ///***************** Create Ride API ***********************
  createRideAPI() async {
    var platform = '';
    if (Platform.isIOS) {
      platform = 'ios';
    } else {
      platform = 'android';
    }
    Map params = {
      'pickup_lat': '${origin.latitude}',
      'pickup_lng': '${origin.longitude}',
      'drop_lat': '${destination.latitude}',
      'drop_lng': '${destination.longitude}',
      'pickup_address': pickupAddress,
      'drop_address': dropAddress,
      'distance':
          '${((polyLineData?.totalDistanceValue ?? 0) * 0.000621371).roundToDouble()}',
      'estimated_cost': '${_calculateFair()}',
      'cancel_reason': '',
      'cancel_type': '',
      'actual_cost': '',
      'pay_by': 'creditcard',
      'booking_through': platform,
      'cancel': '0',
      'ride_type': 'ride',
      'taxi_type_id': selectedTaxiID,
      'deviceToken': Constant.TOKEN,
      'ride_status': Constant.TRIP_STATUS_NEW,
    };
    await bookingViewModel.createRide(params, context).then((value) => {
          bookingModel = value,
          // print("???????????????${value?.rideData?.rideId}"),
          // print("???????????????${bookingModel?.rideData?.rideId}"),
          getRideStatusAPI(value.rideData!.rideId.toString()),
          Future.delayed(const Duration(seconds: 120), () {
            print('Delayed code executed');
            if (bookingModel?.rideData?.rideStatus ==
                Constant.TRIP_STATUS_NEW) {
              expireRideAPI();
            }
          })
        });
  }

  ///***************** Get Nearby Drivers API ***********************
  getNearByDrivers() async {
    Map params = {
      'current_lat': '${origin.latitude}',
      'current_lng': '${origin.longitude}',
      'inKmRadius': Constant.RADIUS_FOR_DRIVERS,
      'taxi_type_id': selectedTaxiID
    };
    await homeViewModel.getNearByDerivers(params, context).then((value) => {
          driverList = value,
          setState(() {
            setDriversOnMap(value);
          })
        });
  }

  ///***************** Get Taxi Types API ***********************
  getTaxiTypes() async {
    Map data = {"taxi_uses": "both"};
    homeViewModel.getCarCategs(data, context).then((value) => setState(() => {
          typeList = value,
          selectedCarIndex = 0,
          selectedTaxiID = '${typeList?[0].taxiTypeId ?? 0}'
        }));
  }

  ///***************** Get User Profile API ***********************
  getUserProfile() async {
    await profileViewModel
        .getUserProfile(context)
        .then((value) => profileModel = value);
  }

  ///**************** SetDriver icon on map ********************
  setDriversOnMap(List<NearByDriverModel>? drivers) {
    print('??????????????${drivers?.length}');
    markersList.clear();
    markersList.add(Marker(markerId: const MarkerId("0"), position: origin));
    if (isPickupSelect == false &&
        destination.latitude != 0.0 &&
        destination.longitude != 0.0) {
      markersList
          .add(Marker(markerId: const MarkerId("1"), position: destination));
    }
    setState(() {
      if (bookingModel?.rideData?.rideStatus != null &&
          bookingModel?.rideData?.rideStatus != Constant.TRIP_STATUS_NEW &&
          bookingModel?.rideData?.rideStatus != Constant.TRIP_STATUS_CANCELED &&
          bookingModel?.rideData?.rideStatus != Constant.TRIP_STATUS_END) {
        markersList.add(Marker(
            markerId: const MarkerId('2'),
            position: LatLng(
                double.parse(bookingModel?.driverData?.driverLat ?? '0.0'),
                double.parse(bookingModel?.driverData?.driverLng ?? '0.0')),
            icon: customIcon));
        setState(() {});
      } else {
        print("sdsdfsdfasdfsdfsdfsdfsdfs");
        if (drivers != null) {
          for (var i = 0; i < (drivers.length); i++) {
            markersList.add(Marker(
                markerId: MarkerId((drivers[i].userId ?? 0).toString()),
                position: LatLng(double.parse(drivers[i].driverLat ?? '0.0'),
                    double.parse(drivers[i].driverLng ?? '0.0')),
                icon: customIcon));
          }
        }
      }
    });
  }

  ///***************** Open Place Picker ***********************
  Future<void> _openPlacePicker() async {
    webs.Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: Constant.GOOGLE_API_KEY,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white))),
        components: [
          webs.Component(webs.Component.country, "IN"),
          webs.Component(webs.Component.country, "usa")
        ]);
    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(webs.PlacesAutocompleteResponse response) {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   elevation: 0,
    //   behavior: SnackBarBehavior.floating,
    //   backgroundColor: Colors.transparent,
    //   content: AwesomeSnackbarContent(
    //     title: 'Message',
    //     message: response.errorMessage!,
    //     contentType: ContentType.failure,
    //   ),
    // ));

    // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  ///********************** Display place picker list ********************************
  Future<void> displayPrediction(
      webs.Prediction p, ScaffoldState? currentState) async {
    webs.GoogleMapsPlaces places = webs.GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    webs.PlacesDetailsResponse detail =
        await places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    if (isPickupSelect == true) {
      origin = LatLng(lat, lng);
      pickupAddress = detail.result.formattedAddress ?? "";
      markersList.clear();
      markersList.add(Marker(
          markerId: const MarkerId("0"),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(title: detail.result.name)));
      getNearByDrivers();
      googleMapController
          .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 10.0));
    } else {
      destination = LatLng(lat, lng);
      dropAddress = detail.result.formattedAddress ?? "";
      markersList.add(Marker(
          markerId: const MarkerId("1"),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(title: detail.result.name)));
      // drawPolyline();
      // polylinePoints = GoogleService().drawPolyline(origin, destination).then((value) =>
      //     setState(() {})
      // ) as Set<Polyline>;
      // setState(() {});
    }
    setState(() {});
  }

  ///************************** Draw Polyline ****************************
  // void drawPolyline() async {
  //   var response = await http.post(Uri.parse(
  //       "${AppUrl.googleDirectionUrl}${Constant
  //           .GOOGLE_API_KEY}&units=metric&origin=${origin.latitude},${origin
  //           .longitude}&destination=${destination.latitude},${destination
  //           .longitude}&mode=driving"));
  //   print(response.body);
  //   polylineResponse = PolylineResponse.fromJson(jsonDecode(response.body));
  //   totalDistance = polylineResponse.routes![0].legs![0].distance!.text!;
  //   totalDistanceValue =
  //       polylineResponse.routes![0].legs![0].distance!.value ?? 0;
  //   totalTime = polylineResponse.routes![0].legs![0].duration!.text!;
  //   for (int i = 0;
  //   i < polylineResponse.routes![0].legs![0].steps!.length;
  //   i++) {
  //     polylinePoints.add(Polyline(
  //         polylineId: PolylineId(
  //             polylineResponse.routes![0].legs![0].steps![i].polyline!.points!),
  //         points: [
  //           LatLng(
  //               polylineResponse
  //                   .routes![0].legs![0].steps![i].startLocation!.lat!,
  //               polylineResponse
  //                   .routes![0].legs![0].steps![i].startLocation!.lng!),
  //           LatLng(
  //               polylineResponse
  //                   .routes![0].legs![0].steps![i].endLocation!.lat!,
  //               polylineResponse
  //                   .routes![0].legs![0].steps![i].endLocation!.lng!),
  //         ],
  //         width: 5,
  //         color: AppColors.primaryBackgroundColor));
  //   }
  //   setState(() {});
  // }

  /// MARK: - CalculateFair
  _calculateFair() {
    if (driverList?.isEmpty ?? false) {
      return;
    }
    if ((polyLineData?.totalDistanceValue ?? 0) > 100) {
      var distanceMiles =
          ((polyLineData?.totalDistanceValue ?? 0) * 0.000621371)
              .roundToDouble();
      if (selectedCarIndex == -1) {
        var carDetails = typeList?[0];
        var price = double.parse(
            carDetails?.pricePerKm ?? Constant.DEFAULT_PRICE_PER_KM);
        var finalPrice = distanceMiles * price;
        return finalPrice;
      } else {
        var carDetails = typeList?[selectedCarIndex];
        var price = double.parse(
            carDetails?.pricePerKm ?? Constant.DEFAULT_PRICE_PER_KM);
        var distancePrice = distanceMiles * price;
        var finalPrice =
            double.parse(carDetails?.basePrice ?? '0.0') + distancePrice;
        return finalPrice;
      }
    } else {
      // Utils.snackBar('Please select a valid set of Pickup & Destination points', context);
      // return;
    }
  }

  _resetHomeView() {
    bookNowTitle = "Book Now";
    pickupAddress = 'Select Pickup Address';
    dropAddress = 'Select Drop Address';
    selectedCarIndex = 0;
    destination = LatLng(0.0, 0.0);
    polylinePoints.clear();
    markersList.clear();

    // markersList.add(
    //     Marker(markerId: const MarkerId("0"), position: _latLng ?? origin));
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Rover'),
          backgroundColor: AppColors.primaryBackgroundColor,
          leading: IconButton(
            icon: (bookNowTitle == "Book Now")
                ? const Icon(Icons.menu)
                : const Icon(Icons.keyboard_backspace),
            onPressed: (() => {
                  setState(() {
                    if (bookNowTitle != 'Cancel Request') {
                      bookNowTitle == "Book Now"
                          ? _scaffoldKey.currentState?.openDrawer()
                          : _resetHomeView();
                    }
                  })
                }),
          ),
        ),
        drawer: AppDrawer(
          profileResp: profileModel?.response,
          tapOnDrawrOption: ((index) => {
                if (index == 1)
                  {Navigator.pushNamed(context, RoutesName.navigationBar)}
                else
                  {
                    Navigator.pushNamed(
                        context, RoutesName.roundedNavigationBar)
                  }
              }),
        ),
        body: Column(
          children: [
            Expanded(
                flex: (bookingModel?.rideData?.rideStatus ==
                            Constant.TRIP_STATUS_NEW ||
                        bookingModel?.rideData?.rideStatus ==
                            Constant.TRIP_STATUS_CANCELED ||
                        bookingModel?.rideData?.rideStatus ==
                            Constant.TRIP_STATUS_END ||
                        bookingModel?.rideData?.rideStatus == null)
                    ? 7
                    : 6,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        color: AppColors.white,
                        child: GoogleMap(
                          polylines: polylinePoints,
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          initialCameraPosition: initialCameraPosition,
                          markers: markersList,
                          // markers: <Marker> {
                          //   serMarker()
                          // },
                          onMapCreated: (GoogleMapController controller) {
                            googleMapController = controller;
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (() => {
                                  if (bookNowTitle == "Book Now")
                                    {isPickupSelect = true, _openPlacePicker()}
                                }),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 20,
                                        spreadRadius: 5)
                                  ]),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 8,
                                              width: 8,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            const Text('Pickup Address',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(pickupAddress,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.black,
                                            )),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: (() => {
                                  if (bookNowTitle == "Book Now")
                                    {isPickupSelect = false, _openPlacePicker()}
                                }),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 20,
                                        spreadRadius: 5)
                                  ]),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 8,
                                              width: 8,
                                              decoration: BoxDecoration(
                                                  color: Colors.redAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            const Text('Drop Address',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(dropAddress,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                            )),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            _bottomPartView(context),
          ],
        ),
      ),
    );
  }

  ///Bottom Part
  Widget _bottomPartView(BuildContext context) {
    return Expanded(
        flex: (bookingModel?.rideData?.rideStatus == Constant.TRIP_STATUS_NEW ||
                bookingModel?.rideData?.rideStatus ==
                    Constant.TRIP_STATUS_CANCELED ||
                bookingModel?.rideData?.rideStatus ==
                    Constant.TRIP_STATUS_END ||
                bookingModel?.rideData?.rideStatus == null)
            ? 3
            : 4,
        child: (bookingModel?.rideData?.rideStatus ==
                    Constant.TRIP_STATUS_CONFIRMED ||
                bookingModel?.rideData?.rideStatus ==
                    Constant.TRIP_STATUS_BEGIN ||
                bookingModel?.rideData?.rideStatus ==
                    Constant.TRIP_STATUS_ARRIVING ||
                bookingModel?.rideData?.rideStatus ==
                    Constant.TRIP_STATUS_REACHED)
            ? RideStatusView(
                rideResponse: bookingModel,
                onTapActionBtns: ((selectdBtnIndex) => {
                      if (selectdBtnIndex == 0)
                        {}
                      else if (selectdBtnIndex == 1)
                        {}
                      else if (selectdBtnIndex == 2)
                        {}
                      else if (selectdBtnIndex == 3)
                        {}
                      else if (selectdBtnIndex == 4)
                        {
                          // Navigator.pushNamed(context, RoutesName.trackRideView)
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TrackRideView(
                                    origin: origin,
                                    destination: destination,
                                    driverData: bookingModel?.driverData,
                                  )))
                        }
                    }))
            : ConfirmRideView(
                typeList: typeList,
                calculateFair: "${_calculateFair()}",
                totalDistanceValue: polyLineData?.totalDistanceValue ?? 0,
                totalTime: polyLineData?.totalTime ?? 'NA',
                bookNowTitle: bookNowTitle,
                selectedCarIndex: selectedCarIndex,
                onBookNowTap: (() => {
                      setState(() {
                        if (dropAddress != '' &&
                            dropAddress != 'Select Drop Address') {
                          if (bookNowTitle == 'Confirm Booking') {
                            ///CALL CREATE RIDE API
                            bookNowTitle = 'Cancel Request';
                            createRideAPI();
                          } else if (bookNowTitle == 'Cancel Request') {
                            ///CALL CANCEL REQUEST API
                            expireRideAPI();
                          } else {
                            ///DRAW POLYLINE
                            bookNowTitle = "Confirm Booking";
                            // drawPolyline();
                            setState(() {});
                            GoogleService.instance
                                .drawPolyline(origin, destination)
                                .then((value) => setState(() {
                                      polyLineData = value;
                                      polylinePoints = value.polylinePoints;
                                    }));
                          }
                        } else {
                          Utils.snackBar('Please Select Drop Address', context);
                        }
                      })
                    }),
                onTaxiTypeTap: ((selectdIndx) => {
                      selectedCarIndex = selectdIndx,
                      selectedTaxiID =
                          '${typeList?[selectdIndx].taxiTypeId ?? 0}',
                      getNearByDrivers()
                    }),
              ));
  }
}
