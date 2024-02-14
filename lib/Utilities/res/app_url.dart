class AppUrl {
  //Base URL
  static var baseUrl = 'https://rovertaxi-dev.affleprojects.com/api/v2';
  static var googleDirectionUrl =
      'https://maps.googleapis.com/maps/api/directions/json?key=';
  static var placeholderImgUrl =
      'https://www.kasandbox.org/programming-images/avatars/spunky-sam.png';
  static var driverplaceholderImgUrl =
      'https://www.kasandbox.org/programming-images/avatars/spunky-sam-green.png';

  //Auth URLS
  static var loginEndPoint = '$baseUrl/login';
  static var logoutApiEndPoint = '$baseUrl/logout';
  static var taxiTypeEndPoint = '$baseUrl/getTaxiTypes';
  static var nearByDriverEndPoint = '$baseUrl/getNearByDrivers';
  static var createRideEndPoint = '$baseUrl/createRide';
  static var expireRideEndPoint = '$baseUrl/updateRide';
  static var getRideStatusEndPoint = '$baseUrl/getUserRideStatus';
  static var getUserDetailEndPoint = '$baseUrl/userDetail';
}
