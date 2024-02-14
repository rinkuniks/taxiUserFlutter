import '../../Utilities/res/app_url.dart';
import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  /// Get Car Categories Api
  Future<dynamic> getCarCategories(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.taxiTypeEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// nearByDrivers Api
  Future<dynamic> nearByDriversAPI(dynamic data) async {
    try {
      dynamic response =
          _apiServices.getPostApiResponse(AppUrl.nearByDriverEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get User Profile Api
  Future<dynamic> getUserProfileAPI() async {
    try {
      dynamic response =
          _apiServices.getGetApiResponse(AppUrl.getUserDetailEndPoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
