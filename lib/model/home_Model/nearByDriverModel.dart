
class NearByDriverModel {
  int? userId;
  String? driverLat;
  String? driverLng;
  int? taxiId;
  int? taxiTypeId;
  String? taxiType;
  String? basePrice;
  String? pricePerKm;
  String? taxiImage;
  int? capacity;
  String? waitingCharges;
  String? active;
  int? distance;
  String? unit;
  int? reachingTime;

  NearByDriverModel(
      {this.userId,
        this.driverLat,
        this.driverLng,
        this.taxiId,
        this.taxiTypeId,
        this.taxiType,
        this.basePrice,
        this.pricePerKm,
        this.taxiImage,
        this.capacity,
        this.waitingCharges,
        this.active,
        this.distance,
        this.unit,
        this.reachingTime});

  NearByDriverModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    driverLat = json['driver_lat'];
    driverLng = json['driver_lng'];
    taxiId = json['taxi_id'];
    taxiTypeId = json['taxi_type_id'];
    taxiType = json['taxi_type'];
    basePrice = json['base_price'];
    pricePerKm = json['price_per_km'];
    taxiImage = json['taxi_image'];
    capacity = json['capacity'];
    waitingCharges = json['waiting_charges'];
    active = json['active'];
    distance = json['distance'];
    unit = json['unit'];
    reachingTime = json['reachingTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['driver_lat'] = this.driverLat;
    data['driver_lng'] = this.driverLng;
    data['taxi_id'] = this.taxiId;
    data['taxi_type_id'] = this.taxiTypeId;
    data['taxi_type'] = this.taxiType;
    data['base_price'] = this.basePrice;
    data['price_per_km'] = this.pricePerKm;
    data['taxi_image'] = this.taxiImage;
    data['capacity'] = this.capacity;
    data['waiting_charges'] = this.waitingCharges;
    data['active'] = this.active;
    data['distance'] = this.distance;
    data['unit'] = this.unit;
    data['reachingTime'] = this.reachingTime;
    return data;
  }
}