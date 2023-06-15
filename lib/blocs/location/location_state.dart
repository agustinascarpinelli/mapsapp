part of 'location_bloc.dart';

 class LocationState extends Equatable {

final bool followingUser;
final LatLng ?lastKnowPosition;
final List <LatLng> history;





  const LocationState({ 
     
     this.followingUser=false,
     this.lastKnowPosition,
     history
  }):history =history?? const [];



  LocationState copyWith({
    bool ?followingUser,
    LatLng ?lastKnowPosition,
    List <LatLng>? history

  }) =>LocationState(
    followingUser: followingUser??this.followingUser
    ,lastKnowPosition: lastKnowPosition??this.lastKnowPosition,
    history: history??this.history);
  
  @override
  List<Object?> get props => [followingUser,lastKnowPosition,history];
}

