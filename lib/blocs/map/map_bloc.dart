import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';


class MapBloc extends Bloc<MapEvent, MapState> {

  final LocationBloc locationBloc;
  GoogleMapController? _mapController;

  StreamSubscription<LocationState>? locationStateSubscription;
  
  MapBloc({
    required this.locationBloc
  }) : super( const MapState() ) {

    on<OnMapInitializedEvent>( _onInitMap );
    on<OnMapStartFollowingUser>( _onStartFollowingUser );
    on<OnMapStopFollowingUser>( ( event, emit ) => emit( state.copyWith( isFollowingUser: false ) ) );
    on<OnUpdatePolylineEvent>( _onUpdatePolylineEvent );
    on<OnToggleUserRoute>((event, emit) => emit( state.copyWith( showMyRoute: !state.showMyRoute ) ) );
    

    locationStateSubscription = locationBloc.stream.listen( ( locationState ) {

      if ( locationState.lastKnowLocation != null ) {
        add( OnUpdatePolylineEvent( locationState.myLocationHistory ) );
      }
      
      if ( !state.isFollowingUser ) return;
      if ( locationState.lastKnowLocation == null ) return;
      moveCamera( locationState.lastKnowLocation! );

    });

  }

  void _onInitMap( OnMapInitializedEvent event, Emitter<MapState> emit ) {
    _mapController = event.controller;
    _mapController!.setMapStyle( jsonEncode( uberMapTheme ) );
    emit( state.copyWith( isMapInitialized: true ) );
  }

  void _onStartFollowingUser( OnMapStartFollowingUser event, Emitter<MapState> emit ) {
    
    emit( state.copyWith( isFollowingUser: true ) );    
    if ( locationBloc.state.lastKnowLocation == null ) return;
    moveCamera( locationBloc.state.lastKnowLocation! );
    
  }

  void _onUpdatePolylineEvent( OnUpdatePolylineEvent event, Emitter<MapState> emit ) {

    final myRoute = Polyline(
      polylineId: const PolylineId( 'myRoute' ),
      color: Colors.black,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.userLocations
    );

    final currentPolylines = Map<String, Polyline>.from( state.polylines );
    currentPolylines[ 'myRoute' ] = myRoute;

    emit( state.copyWith( polylines: currentPolylines ) );

  }

  void moveCamera( LatLng newLocation ) {
    final cameraUpdate = CameraUpdate.newLatLng( newLocation );
    _mapController?.animateCamera( cameraUpdate );

  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}


