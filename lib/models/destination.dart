import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/models.dart';

class Destination {
  final List <LatLng> points;
  final double duration;
  final double distance;
  final Feature endPlace;
  final Feature startPlace;

  Destination({ required this.startPlace, required this.endPlace, required this.points, required this.duration,required this.distance});
}