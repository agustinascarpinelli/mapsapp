import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TrafficService trafficService;
 
  SearchBloc({
    required this.trafficService
  }) : super(const SearchState()) {
    on<OnActivateManualMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: true)));

    on<OnDisActivateManualMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: false)));

     on<OnNewPlacesByQueryEvents>((event, emit) {
      emit(state.copyWith(placesByQuery: event.places));
     });   


     on<OnAddPlaceToHistory>(((event, emit) {
      emit(state.copyWith(history: [event.places,...state.history]));
     }));
  
 
  on<RemoveItemOfHistory>(((event, emit) {
      final List <Feature> newHistory= state.history.where((element) => element.id!=event.place.id).toList();
      
      emit(state.copyWith(history: newHistory));
     }));
  }


    

  Future<Destination> getCoordsStartToEnd(LatLng start,LatLng end)async{
   final resp= await trafficService.getCoordsStartToEnd(start, end);
   final endPlace=await trafficService.getInformationByCoors(end);
   final startPlace=await trafficService.getInformationByCoors(start);
   
  final distance= resp.routes[0].distance;
  final duration= resp.routes[0].duration;
  final geometry= resp.routes[0].geometry;

 final decodeGeo=decodePolyline(geometry,accuracyExponent: 6);
 final points=decodeGeo.map((coords)=>LatLng(coords[0].toDouble(), coords[1].toDouble())).toList();



    return Destination(
    points: points,
    startPlace:startPlace ,
     duration: duration,
     
     endPlace:endPlace,
     distance: distance);

    
  }

  Future<List<Feature>> getPlacesByQuery(LatLng proximity,String query) async{
    final List<Feature> resp=await trafficService.getResultsByQuery(query,proximity);
    add(OnNewPlacesByQueryEvents(resp));
    return resp;
    
  }
}
