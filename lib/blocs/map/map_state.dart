part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showRoute;

  //Polylines
  final Map<String,Polyline>polylines;
    final Map<String,Marker>markers;

  //Markers


  MapState({this.showRoute=true, Map<String,Polyline>?polylines,Map<String,Marker>?markers, this.isMapInitialized = false, this.isFollowingUser = false}):polylines=polylines??{},markers=markers??{};

  MapState copyWith({
    bool? isMapInitialized,
     bool? followUser,
     bool?showRoute,
     Map<String,Polyline>?polylines,
     Map<String,Marker>?markers
     })
     
      => MapState(
      isFollowingUser: followUser ?? this.isFollowingUser,
      showRoute: showRoute??this.showRoute,
      polylines: polylines?? this.polylines,
      isMapInitialized: isMapInitialized ?? this.isMapInitialized,
      markers: markers??this.markers
      );

  @override
  List<Object> get props => [isMapInitialized, isFollowingUser,polylines,showRoute,markers];
}
