class CreateBookingModel {
  CreateRideResponse? response;

  CreateBookingModel({this.response});

  CreateBookingModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new CreateRideResponse.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    return data;
  }
}

class CreateRideResponse {
  String? message;
  RideData? rideData;
  // UserData? userData;
  DriverData? driverData;
  TaxiData? taxiData;
  // FareData? fareData;
  int? code;

  CreateRideResponse(
      {this.message,
      this.rideData,
      // this.userData,
      this.driverData,
      this.taxiData,
      // this.fareData,
      this.code});

  CreateRideResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    rideData = json['rideData'] != null
        ? new RideData.fromJson(json['rideData'])
        : null;
    // userData = json['userData'] != null
    //     ? new UserData.fromJson(json['userData'])
    //     : null;
    driverData = json['driverData'] != null
        ? new DriverData.fromJson(json['driverData'])
        : null;
    taxiData = json['taxiData'] != null
        ? new TaxiData.fromJson(json['taxiData'])
        : null;
    // fareData = json['fareData'] != null
    //     ? new FareData.fromJson(json['fareData'])
    //     : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.rideData != null) {
      data['rideData'] = this.rideData!.toJson();
    }
    // if (this.userData != null) {
    //   data['userData'] = this.userData!.toJson();
    // }
    if (this.driverData != null) {
      data['driverData'] = this.driverData!.toJson();
    }
    if (this.taxiData != null) {
      data['taxiData'] = this.taxiData!.toJson();
    }
    // if (this.fareData != null) {
    //   data['fareData'] = this.fareData!.toJson();
    // }
    data['code'] = this.code;
    return data;
  }
}

class RideData {
  int? rideId;
  String? rideType;
  String? rideStatus;
  String? confirmed;
  String? pickupAddress;
  String? dropAddress;
  String? pickupLat;
  String? pickupLng;
  String? dropLat;
  String? dropLng;
  // String? pickupTime;
  // dynamic? dropTime;
  String? comments;
  // String? tips;
  String? estimatedCost;
  dynamic? actualCost;
  dynamic? estimatedTax;
  dynamic? rideFare;
  String? payBy;
  // String? parcelName;
  // dynamic? parcelHeight;
  // dynamic? parcelWidth;
  // dynamic? parcelDepth;
  // dynamic? parcelWeight;
  String? cancel;
  String? cancelReason;
  String? cancelType;
  // String? advanceRide;
  dynamic? rating;
  int? userRating;
  String? distance;
  String? paymentStatus;
  // String? bookingThrough;
  // int? checkDriverRating;
  String? rideOtp;

  RideData(
      {this.rideId,
      this.rideType,
      this.rideStatus,
      this.confirmed,
      this.pickupAddress,
      this.dropAddress,
      this.pickupLat,
      this.pickupLng,
      this.dropLat,
      this.dropLng,
      // this.pickupTime,
      // this.dropTime,
      this.comments,
      // this.tips,
      this.estimatedCost,
      this.actualCost,
      this.estimatedTax,
      this.rideFare,
      this.payBy,
      // this.parcelName,
      // this.parcelHeight,
      // this.parcelWidth,
      // this.parcelDepth,
      // this.parcelWeight,
      this.cancel,
      this.cancelReason,
      this.cancelType,
      // this.advanceRide,
      this.rating,
      this.userRating,
      this.distance,
      this.paymentStatus,
      // this.bookingThrough,
      // this.checkDriverRating,
      this.rideOtp});

  RideData.fromJson(Map<String, dynamic> json) {
    rideId = json['ride_id'];
    rideType = json['ride_type'];
    rideStatus = json['ride_status'];
    confirmed = json['confirmed'];
    pickupAddress = json['pickup_address'];
    dropAddress = json['drop_address'];
    pickupLat = json['pickup_lat'];
    pickupLng = json['pickup_lng'];
    dropLat = json['drop_lat'];
    dropLng = json['drop_lng'];
    // pickupTime = json['pickup_time'];
    // dropTime = json['drop_time'];
    comments = json['comments'];
    // tips = json['tips'];
    estimatedCost = json['estimated_cost'];
    actualCost = json['actual_cost'];
    estimatedTax = json['estimated_tax'];
    rideFare = json['ride_fare'];
    payBy = json['pay_by'];
    // parcelName = json['parcel_name'];
    // parcelHeight = json['parcel_height'];
    // parcelWidth = json['parcel_width'];
    // parcelDepth = json['parcel_depth'];
    // parcelWeight = json['parcel_weight'];
    cancel = json['cancel'];
    cancelReason = json['cancel_reason'];
    cancelType = json['cancel_type'];
    // advanceRide = json['advanceRide'];
    rating = json['rating'];
    userRating = json['user_rating'];
    distance = json['distance'];
    paymentStatus = json['payment_status'];
    // bookingThrough = json['booking_through'];
    // checkDriverRating = json['check_driver_rating'];
    rideOtp = json['ride_otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ride_id'] = this.rideId;
    data['ride_type'] = this.rideType;
    data['ride_status'] = this.rideStatus;
    data['confirmed'] = this.confirmed;
    data['pickup_address'] = this.pickupAddress;
    data['drop_address'] = this.dropAddress;
    data['pickup_lat'] = this.pickupLat;
    data['pickup_lng'] = this.pickupLng;
    data['drop_lat'] = this.dropLat;
    data['drop_lng'] = this.dropLng;
    // data['pickup_time'] = this.pickupTime;
    // data['drop_time'] = this.dropTime;
    data['comments'] = this.comments;
    // data['tips'] = this.tips;
    data['estimated_cost'] = this.estimatedCost;
    data['actual_cost'] = this.actualCost;
    data['estimated_tax'] = this.estimatedTax;
    data['ride_fare'] = this.rideFare;
    data['pay_by'] = this.payBy;
    // data['parcel_name'] = this.parcelName;
    // data['parcel_height'] = this.parcelHeight;
    // data['parcel_width'] = this.parcelWidth;
    // data['parcel_depth'] = this.parcelDepth;
    // data['parcel_weight'] = this.parcelWeight;
    data['cancel'] = this.cancel;
    data['cancel_reason'] = this.cancelReason;
    data['cancel_type'] = this.cancelType;
    // data['advanceRide'] = this.advanceRide;
    data['rating'] = this.rating;
    data['user_rating'] = this.userRating;
    data['distance'] = this.distance;
    data['payment_status'] = this.paymentStatus;
    // data['booking_through'] = this.bookingThrough;
    // data['check_driver_rating'] = this.checkDriverRating;
    data['ride_otp'] = this.rideOtp;
    return data;
  }
}

class UserData {
  int? userId;
  String? active;
  String? name;
  String? userType;
  String? email;
  String? phone;
  int? walletAmount;
  Null? userImage;
  String? rating;
  String? cardDetail;
  int? cardLimit;

  UserData(
      {this.userId,
      this.active,
      this.name,
      this.userType,
      this.email,
      this.phone,
      this.walletAmount,
      this.userImage,
      this.rating,
      this.cardDetail,
      this.cardLimit});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    active = json['active'];
    name = json['name'];
    userType = json['user_type'];
    email = json['email'];
    phone = json['phone'];
    walletAmount = json['wallet_amount'];
    userImage = json['user_image'];
    rating = json['rating'];
    cardDetail = json['card_detail'];
    cardLimit = json['card_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['active'] = this.active;
    data['name'] = this.name;
    data['user_type'] = this.userType;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['wallet_amount'] = this.walletAmount;
    data['user_image'] = this.userImage;
    data['rating'] = this.rating;
    data['card_detail'] = this.cardDetail;
    data['card_limit'] = this.cardLimit;
    return data;
  }
}

class DriverData {
  int? driverId;
  String? driverLat;
  String? driverLng;
  String? profileImage;
  String? drivingLicenceImage;
  String? name;
  String? email;
  String? phone;
  String? rating;
  String? favourite;
  AddressInfo? addressInfo;

  DriverData(
      {this.driverId,
      this.driverLat,
      this.driverLng,
      this.profileImage,
      this.drivingLicenceImage,
      this.name,
      this.email,
      this.phone,
      this.rating,
      this.favourite,
      this.addressInfo});

  DriverData.fromJson(Map<String, dynamic> json) {
    driverId = json['driver_id'];
    driverLat = json['driver_lat'];
    driverLng = json['driver_lng'];
    profileImage = json['profileImage'];
    drivingLicenceImage = json['driving_licence_image'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    rating = json['rating'];
    favourite = json['favourite'];
    addressInfo = json['addressInfo'] != null
        ? new AddressInfo.fromJson(json['addressInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driver_id'] = this.driverId;
    data['driver_lat'] = this.driverLat;
    data['driver_lng'] = this.driverLng;
    data['profileImage'] = this.profileImage;
    data['driving_licence_image'] = this.drivingLicenceImage;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['rating'] = this.rating;
    data['favourite'] = this.favourite;
    if (this.addressInfo != null) {
      data['addressInfo'] = this.addressInfo!.toJson();
    }
    return data;
  }
}

class AddressInfo {
  int? driverAddressId;
  String? address;
  String? city;
  String? state;
  String? pincode;

  AddressInfo(
      {this.driverAddressId,
      this.address,
      this.city,
      this.state,
      this.pincode});

  AddressInfo.fromJson(Map<String, dynamic> json) {
    driverAddressId = json['driver_address_id'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driver_address_id'] = this.driverAddressId;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    return data;
  }
}

class TaxiData {
  int? taxiId;
  String? active;
  String? vehicleRegistrationNumber;
  String? vehicleRegistrationImage;
  String? manufacturingDetails;
  String? tagNumberState;
  String? insuranceCompanyInformation;
  TaxiTypeInfo? taxiTypeInfo;

  TaxiData(
      {this.taxiId,
      this.active,
      this.vehicleRegistrationNumber,
      this.vehicleRegistrationImage,
      this.manufacturingDetails,
      this.tagNumberState,
      this.insuranceCompanyInformation,
      this.taxiTypeInfo});

  TaxiData.fromJson(Map<String, dynamic> json) {
    taxiId = json['taxi_id'];
    active = json['active'];
    vehicleRegistrationNumber = json['vehicle_registration_number'];
    vehicleRegistrationImage = json['vehicle_registration_image'];
    manufacturingDetails = json['manufacturing_details'];
    tagNumberState = json['tag_number_state'];
    insuranceCompanyInformation = json['insurance_company_information'];
    taxiTypeInfo = json['taxiTypeInfo'] != null
        ? new TaxiTypeInfo.fromJson(json['taxiTypeInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taxi_id'] = this.taxiId;
    data['active'] = this.active;
    data['vehicle_registration_number'] = this.vehicleRegistrationNumber;
    data['vehicle_registration_image'] = this.vehicleRegistrationImage;
    data['manufacturing_details'] = this.manufacturingDetails;
    data['tag_number_state'] = this.tagNumberState;
    data['insurance_company_information'] = this.insuranceCompanyInformation;
    if (this.taxiTypeInfo != null) {
      data['taxiTypeInfo'] = this.taxiTypeInfo!.toJson();
    }
    return data;
  }
}

class TaxiTypeInfo {
  int? taxiTypeId;
  String? active;
  String? taxiName;
  String? basePrice;
  String? pricePerKm;
  String? taxiImage;

  TaxiTypeInfo(
      {this.taxiTypeId,
      this.active,
      this.taxiName,
      this.basePrice,
      this.pricePerKm,
      this.taxiImage});

  TaxiTypeInfo.fromJson(Map<String, dynamic> json) {
    taxiTypeId = json['taxi_type_id'];
    active = json['active'];
    taxiName = json['taxi_name'];
    basePrice = json['base_price'];
    pricePerKm = json['price_per_km'];
    taxiImage = json['taxi_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taxi_type_id'] = this.taxiTypeId;
    data['active'] = this.active;
    data['taxi_name'] = this.taxiName;
    data['base_price'] = this.basePrice;
    data['price_per_km'] = this.pricePerKm;
    data['taxi_image'] = this.taxiImage;
    return data;
  }
}

class FareData {
  int? rideFare;
  int? waitingCharge;
  int? tips;
  int? tax;
  int? totalBill;
  int? isModify;

  FareData(
      {this.rideFare,
      this.waitingCharge,
      this.tips,
      this.tax,
      this.totalBill,
      this.isModify});

  FareData.fromJson(Map<String, dynamic> json) {
    rideFare = json['ride_fare'];
    waitingCharge = json['waiting_charge'];
    tips = json['tips'];
    tax = json['tax'];
    totalBill = json['total_bill'];
    isModify = json['isModify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ride_fare'] = this.rideFare;
    data['waiting_charge'] = this.waitingCharge;
    data['tips'] = this.tips;
    data['tax'] = this.tax;
    data['total_bill'] = this.totalBill;
    data['isModify'] = this.isModify;
    return data;
  }
}
