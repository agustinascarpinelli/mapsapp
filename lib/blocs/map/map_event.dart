part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}
class OnMapInitializedEvent extends MapEvent{
  final GoogleMapController controller;

  const OnMapInitializedEvent(this.controller);

}

class StopFollowingUser extends MapEvent{}

class StartFollowingUser extends MapEvent{}

class  UpdatePolynesEvent extends MapEvent{
  final List<LatLng>userHistory;

  const UpdatePolynesEvent(this.userHistory);
}

class OnToggleShowRoute extends MapEvent{
  
}
class DisplayPolylineEvent extends MapEvent{
 final Map<String,Polyline> polylines;
final Map<String,Marker>markers;
  const DisplayPolylineEvent(this.polylines, this.markers);
}

