import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/models/destination.dart';
import 'package:maps_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  StreamSubscription<LocationState>? locationStateSubscription;
  final LocationBloc locationBloc;
  GoogleMapController? _mapController;
  LatLng? mapCenter;
  MapBloc({required this.locationBloc}) : super(MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);

    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnowPosition != null) {
        add(UpdatePolynesEvent(locationState.history));
      }
      if (!state.isFollowingUser) return;
      if (locationState.lastKnowPosition == null) return;

      moveCamera(locationState.lastKnowPosition!);
    });

    on<StartFollowingUser>((event, emit) {
      emit(state.copyWith(followUser: true));
    });

    on<StopFollowingUser>((event, emit) {
      emit(state.copyWith(followUser: false));
    });

    on<UpdatePolynesEvent>(_updatePolylines);
    on<OnToggleShowRoute>(
        (event, emit) => emit(state.copyWith(showRoute: !state.showRoute)));
    on<DisplayPolylineEvent>((event, emit) => emit(
        state.copyWith(polylines: event.polylines, markers: event.markers)));
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(mapTheme));
    emit(state.copyWith(isMapInitialized: true));
  }

  void moveCamera(LatLng newLoc) {
    final cameraUpdate = CameraUpdate.newLatLng(newLoc);
    _mapController?.animateCamera(cameraUpdate);
  }

  void _updatePolylines(UpdatePolynesEvent event, Emitter emit) {
    final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        color: Colors.deepPurple,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.userHistory);

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  void _StartFollowingUser(OnStartFollowingUser event, Emitter emit) {
    emit(state.copyWith(followUser: true));
    if (locationBloc.state.lastKnowPosition == null) return;
    moveCamera(locationBloc.state.lastKnowPosition!);
  }

  Future drawRoutePolyline(Destination destination) async {
    final myRoute = Polyline(
        polylineId: const PolylineId('route'),
        color: Colors.deepPurple,
        points: destination.points,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap);

    double km = destination.distance / 1000;
    km = (km * 100).floorToDouble();
    km /= 100;

    double tripDur = (destination.duration / 60).floorToDouble();
    //CustomMarker

    // final startCustomMarker=await getAssetImageMarker();

    // final startMarker = Marker(
    //     markerId: const MarkerId('start'),
    //     icon: startCustomMarker,
    //     position: destination.points.first,
    //     infoWindow: InfoWindow(
    //       title: 'Start',
    //       snippet: 'Distance:$km, Duration: $tripDur',
    //     ));

    // final endCustomMarker=await getNetworkImageMarker();    

    // final endMarker = Marker(
    //     markerId: const MarkerId('end'),
    //     icon: endCustomMarker,
    //     position: destination.points.last,
    //     infoWindow: InfoWindow(
    //         title: destination.endPlace.text,
    //         snippet: destination.endPlace.placeName));


    final customStartMarker=await getStartCustomMarker(tripDur.toInt(),destination.startPlace.text);
    final startMarker=Marker(
      markerId: const MarkerId('start'),
      icon:customStartMarker,
      position: destination.points.first,
      anchor:const Offset(0.1,1)
      );

    final customEndMarker= await getEndCustomMarker(km.toInt(), destination.endPlace.text);
    
     final endMarker=Marker(
      markerId: const MarkerId('end'),
      icon:customEndMarker,
      position: destination.points.last,
      );

    
    
    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['route'] = myRoute;

    add(DisplayPolylineEvent(currentPolylines, currentMarkers));
    await Future.delayed(const Duration(milliseconds: 300));
    _mapController?.showMarkerInfoWindow(const MarkerId('end'));
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
