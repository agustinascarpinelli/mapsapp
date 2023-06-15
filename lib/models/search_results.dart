import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResults{
  final  bool cancel;
  final bool? manual;
  final LatLng ? latLng;
  final String? name;
  final String ? description;

  SearchResults({this.name, this.description, required this.cancel, this.manual,this.latLng});
  @override
  String toString() {
   
    return '{cancel:$cancel,manual:$manual}';
  
}
}