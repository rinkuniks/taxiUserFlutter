import 'dart:io';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getPostApiResponse(String url, dynamic data, [bool isHeader = true]);

  Future<dynamic> getPostApiWithMultipartResponse(String url, Map<String, String> data, File file, [bool isHeader = true]);
  // Future<dynamic> getPostApiWhitOutHeader(String url, dynamic data,);
}
