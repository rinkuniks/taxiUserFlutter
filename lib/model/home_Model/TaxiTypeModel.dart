class TaxiTypeModel {
  Response? response;

  TaxiTypeModel({this.response});

  TaxiTypeModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
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

class Response {
  String? message;
  List<TaxiTypeData>? data;
  int? code;

  Response({this.message, this.data, this.code});

  Response.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <TaxiTypeData>[];
      json['data'].forEach((v) {
        data!.add(new TaxiTypeData.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class TaxiTypeData {
  int? taxiTypeId;
  String? taxiType;
  String? pricePerKm;
  String? taxiImage;
  String? taxiUses;
  String? basePrice;
  String? active;
  int? height;
  int? width;
  int? depth;

  TaxiTypeData(
      {this.taxiTypeId,
        this.taxiType,
        this.pricePerKm,
        this.taxiImage,
        this.taxiUses,
        this.basePrice,
        this.active,
        this.height,
        this.width,
        this.depth});

  TaxiTypeData.fromJson(Map<String, dynamic> json) {
    taxiTypeId = json['taxi_type_id'];
    taxiType = json['taxi_type'];
    pricePerKm = json['price_per_km'];
    taxiImage = json['taxi_image'];
    taxiUses = json['taxi_uses'];
    basePrice = json['base_price'];
    active = json['active'];
    height = json['height'];
    width = json['width'];
    depth = json['depth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taxi_type_id'] = this.taxiTypeId;
    data['taxi_type'] = this.taxiType;
    data['price_per_km'] = this.pricePerKm;
    data['taxi_image'] = this.taxiImage;
    data['taxi_uses'] = this.taxiUses;
    data['base_price'] = this.basePrice;
    data['active'] = this.active;
    data['height'] = this.height;
    data['width'] = this.width;
    data['depth'] = this.depth;
    return data;
  }
}
