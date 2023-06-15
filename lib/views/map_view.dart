import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Polyline>polylines;
    final Set<Marker>markers;
  const MapView({super.key,required this.initialLocation, required this.polylines, required this.markers});

  @override
  Widget build(BuildContext context) {
     final mapBloc=BlocProvider.of<MapBloc>(context);

     final CameraPosition initialCameraPosition = CameraPosition(
      target:initialLocation,
      zoom: 19.151926040649414);
   
      final size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove:(pointerMoveEvent)=>mapBloc.add(StopFollowingUser()) ,
        child: GoogleMap(
                initialCameraPosition: initialCameraPosition,
                compassEnabled: false,
                myLocationButtonEnabled: true,
                myLocationEnabled: false,
                polylines: polylines,
                markers: markers,
                zoomControlsEnabled: false,
                onMapCreated:(controller) => mapBloc.add(OnMapInitializedEvent(controller)),
                onCameraMove: (position) => mapBloc.mapCenter=position.target,
                ),
      )
              
              );
    
  }
}