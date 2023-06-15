part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}


class OnActivateManualMarkerEvent extends SearchEvent{}
class OnDisActivateManualMarkerEvent extends SearchEvent{}
class OnNewPlacesByQueryEvents extends SearchEvent{
  final List<Feature>places;

  const OnNewPlacesByQueryEvents( this.places);

}

class OnAddPlaceToHistory extends SearchEvent {
  final Feature places;

  const OnAddPlaceToHistory(this.places);
}

class RemoveItemOfHistory extends SearchEvent{
  final Feature place;

  const RemoveItemOfHistory(this.place);
  
}