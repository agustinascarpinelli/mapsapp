import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/services/services.dart';



class TrafficService{
final Dio _dioTraffic;
final Dio _dioQuery;

final String _basicTrafficUrl="https://api.mapbox.com/directions/v5/mapbox";
final String _basicTrafficQueryUrl="https://api.mapbox.com/geocoding/v5/mapbox.places";

TrafficService()
:_dioTraffic=Dio()..interceptors.add(DioInterceptors()),
_dioQuery=Dio()..interceptors.add(QueryInterceptors());


Future <MapboxResponse> getCoordsStartToEnd (LatLng start,LatLng end) async{
  final coordsString='${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
  final url = '$_basicTrafficUrl/driving/$coordsString';


  final resp=await _dioTraffic.get(url);
  
  final data =MapboxResponse.fromMap(resp.data);

  return data;
  
  
}
Future <List<Feature>>getResultsByQuery(String query,LatLng proximity)async{
  if(query.isEmpty)return [];

  final url='$_basicTrafficQueryUrl/$query.json';
  final resp= await _dioQuery.get(url,queryParameters: {
    'proximity':'${proximity.longitude},${proximity.latitude}',
    'limit':7,
  });

  final data=QueryResponse.fromMap(resp.data);

  return data.features;

  
}

Future<Feature> getInformationByCoors (LatLng coords)async{

final url='$_basicTrafficQueryUrl/${coords.longitude},${coords.latitude}.json';

final resp=await _dioQuery.get(url,queryParameters: {
  'limit':1
});

final queryResponse=QueryResponse.fromMap(resp.data);
return queryResponse.features[0];


}

}