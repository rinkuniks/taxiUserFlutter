class ProfileModel {
  ProfileResponse? response;

  ProfileModel({this.response});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? ProfileResponse.fromJson(json['response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class ProfileResponse {
  UserData? userData;
  int? code;

  ProfileResponse({this.userData, this.code});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    userData =
        json['userData'] != null ? UserData.fromJson(json['userData']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userData != null) {
      data['userData'] = userData!.toJson();
    }
    data['code'] = code;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['active'] = active;
    data['name'] = name;
    data['user_type'] = userType;
    data['email'] = email;
    data['phone'] = phone;
    data['wallet_amount'] = walletAmount;
    data['user_image'] = userImage;
    data['rating'] = rating;
    data['card_detail'] = cardDetail;
    data['card_limit'] = cardLimit;
    return data;
  }
}
