import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? locationStream;
  LocationBloc() : super(const LocationState()) {
    on<OnStartFollowingUser>(
        (event, emit) => emit(state.copyWith(followingUser: true)));

    on<OnStopFollowingUser>(
        (event, emit) => emit(state.copyWith(followingUser: false)));

    on<OnNewUserLocationEvent>((event, emit) {
      emit(state.copyWith(
          lastKnowPosition: event.newLocation,
          history: [...state.history, event.newLocation]));
    });
  }

  Future getCurrentPosition() async {
    final pos = await Geolocator.getCurrentPosition();
    print('position:$pos');
  }

  void startFollowingUser() {
    locationStream = Geolocator.getPositionStream().listen((event) {
      final pos = event;
      add(OnStartFollowingUser());
      add(OnNewUserLocationEvent(LatLng(pos.latitude, pos.longitude)));
      print('position:$pos');
    });
  }

  void stopFollowingUser() {
    add(OnStopFollowingUser());
    locationStream?.cancel();
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
