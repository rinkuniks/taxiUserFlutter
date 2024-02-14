import '../../Utilities/res/app_url.dart';
import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';

class BookingRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  /// Create Ride Api
  Future<dynamic> createRideAPI(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(AppUrl.createRideEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Expire Ride Api
  Future<dynamic> expireRideAPI(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(AppUrl.expireRideEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get Ride Staatus Api
  Future<dynamic> getRideStatusAPI(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(AppUrl.getRideStatusEndPoint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
