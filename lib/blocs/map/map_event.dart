part of 'map_bloc.dart';


abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;
  const OnMapInitializedEvent( this.controller );
}

class OnMapStopFollowingUser extends MapEvent {}
class OnMapStartFollowingUser extends MapEvent {}

class OnUpdatePolylineEvent extends MapEvent {
  final List<LatLng> userLocations;
  const OnUpdatePolylineEvent( this.userLocations );
}

class OnToggleUserRoute extends MapEvent {}
class DisplayPolylinesEvent extends MapEvent {
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;
  const DisplayPolylinesEvent( this.polylines, this.markers );
}



