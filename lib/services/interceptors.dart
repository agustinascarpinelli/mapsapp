import 'package:dio/dio.dart';

class DioInterceptors extends Interceptor{


  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
  options.queryParameters.addAll({
    'alternatives':true,
    'geometries':'polyline6',
    'overview':'simplified',
    'steps':false,
    'access_token':'pk.eyJ1IjoiYWd1c3NjYXJwaW5lbGxpIiwiYSI6ImNsZDgwaW44NjB4a3Azb3M3OHFzaTU1bHIifQ.GAAvZVsWDPFeL29ZZn1IIg',
      });



    super.onRequest(options, handler);
  }
}
