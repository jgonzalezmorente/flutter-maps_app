
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {

  final bool cancel;
  final bool manual;
  final LatLng? position;
  final String? name;
  final String? description;

  SearchResult({
    required this.cancel, 
    this.position, 
    this.name, 
    this.description,
    this.manual = false
  });


  @override
  String toString() => '{ cancel: $cancel, manual, $manual }';
  
}