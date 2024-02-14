import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rovertaxi/respository/home_repository/home_repository.dart';

import '../../Utilities/Constant.dart';
import '../../Utilities/utils.dart';
import '../../model/profileModel/profileModel.dart';

class ProfileViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// for Get User Profile
  Future<ProfileModel> getUserProfile(BuildContext context) async {
    ProfileModel profileModel = ProfileModel();
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      setLoading(true);
      await _myRepo.getUserProfileAPI().then((value) async {
        setLoading(false);
        profileModel = ProfileModel.fromJson(value);
        if (profileModel.response?.code == 200 ||
            profileModel.response?.code == 202) {
          String encodeData = jsonEncode(profileModel);
          Utils.addStringToSF(Constant.PROFILE_DATA, encodeData);
        } else {
          Utils.toastMessage(value['message']);
        }
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
        if (kDebugMode) {
          print("-----E${error.toString()}");
        }
      });
      return profileModel;
    } else {
      return getProfilDataFromLocal();
    }
  }

  Future<ProfileModel> getProfilDataFromLocal() async {
    ProfileModel profileModel = ProfileModel();
    String? profileDataStr =
        await Utils.getStringValuesSF(Constant.PROFILE_DATA);
    if (profileDataStr != null) {
      Map<String, dynamic> jsonData = json.decode(profileDataStr);
      profileModel = ProfileModel.fromJson(jsonData);
    }
    return profileModel;
  }
}
