import 'package:dio/dio.dart';



class TrafficInterceptor extends Interceptor {

  final accessToken = 'pk.eyJ1IjoiamdvbnphbGV6bW9yZW50ZSIsImEiOiJja24zNGJwcm4wN2l4MzFucTV4NnJpdWJsIn0.HOw2wOVhDa5TMSRTemmbZA';
  
  @override
  void onRequest( RequestOptions options, RequestInterceptorHandler handler ) {

    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });

    super.onRequest( options, handler );

  }
}