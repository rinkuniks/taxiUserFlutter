import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rovertaxi/data/response/baseResponse.dart';
import 'package:rovertaxi/model/home_Model/nearByDriverModel.dart';
import 'package:rovertaxi/respository/home_repository/home_repository.dart';

import '../../Utilities/utils.dart';
import '../../model/home_Model/TaxiTypeModel.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// for Get Car Categories
  Future<List<TaxiTypeData>> getCarCategs(
      dynamic data, BuildContext context) async {
    ApiBaseResponse baseResponse = ApiBaseResponse();
    List<TaxiTypeData> list = [];
    setLoading(true);

    await _myRepo.getCarCategories(data).then((value) async {
      setLoading(false);
      baseResponse = ApiBaseResponse.fromJson(value['response']);
      final jsonData = baseResponse.data as List;
      jsonData.forEach((v) {
        if (v['taxi_uses'] == 'ride') {
          var Obj = TaxiTypeData.fromJson(v);
          list.add(Obj);
        }
      });
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print("-----E${error.toString()}");
      }
    });
    return list;
  }

  /// for Nearby drivers
  Future<List<NearByDriverModel>> getNearByDerivers(
      dynamic data, BuildContext context) async {
    ApiBaseResponse baseResponse = ApiBaseResponse();
    List<NearByDriverModel> list = [];
    setLoading(true);

    await _myRepo.nearByDriversAPI(data).then((value) async {
      setLoading(false);
      if (value['response']['data'] == null) {
        Utils.toastMessage(value['response']['message'] ?? "No Driver Found");
      }
      baseResponse = ApiBaseResponse.fromJson(value['response']);
      final jsonData = baseResponse.data as List;
      jsonData.forEach((v) {
        var Obj = NearByDriverModel.fromJson(v);
        list.add(Obj);
      });
    }).onError((error, stackTrace) {
      setLoading(false);
      // Utils.toastMessage(error.toString());
      if (kDebugMode) {
        print("-----E${error.toString()}");
      }
    });
    return list;
  }
}
