import 'package:dio/dio.dart';



class PlacesInterceptor extends Interceptor {

  final accessToken = 'pk.eyJ1IjoiamdvbnphbGV6bW9yZW50ZSIsImEiOiJja24zNGJwcm4wN2l4MzFucTV4NnJpdWJsIn0.HOw2wOVhDa5TMSRTemmbZA';  
  
  @override
  void onRequest( RequestOptions options, RequestInterceptorHandler handler ) {

    options.queryParameters.addAll({
      'access_token': accessToken, 
      'language': 'es'      
    });

    super.onRequest(options, handler);
  }

}