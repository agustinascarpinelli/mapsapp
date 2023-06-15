part of 'search_bloc.dart';

 class SearchState extends Equatable {
  final bool displayManualMarker;
  final List <Feature> placesByQuery;
  final List <Feature> history;
  const SearchState({
    this.displayManualMarker=false,
    this.placesByQuery=const [],
    this.history=const []
    });

    SearchState copyWith ({
      bool?displayManualMarker,
      List<Feature>?placesByQuery,
      List<Feature>? history

    })=>SearchState(displayManualMarker: displayManualMarker?? this.displayManualMarker,placesByQuery: placesByQuery??this.placesByQuery,history: history??this.history);
  
  @override
  List<Object> get props => [displayManualMarker,placesByQuery,history];
}


