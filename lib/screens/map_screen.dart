
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/views/viewS.dart';
import 'package:maps_app/widgets/btn_toggleRoute.dart';
import 'package:maps_app/widgets/widgets.dart';
import 'package:maps_app/widgets/searchBar.dart';



class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}




class _MapScreenState extends State<MapScreen> {
 late LocationBloc locationBloc;
 
 
  @override
void initState() {
  super.initState();
  locationBloc=BlocProvider.of<LocationBloc>(context);
  locationBloc.startFollowingUser();

  
}

@override
  void dispose() {
   locationBloc.stopFollowingUser();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc,LocationState>(
        builder: (context, stateLoc){
          
          if(stateLoc.lastKnowPosition==null){
            return const Center(child: Text('Wait please...'),);
          }
          return BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              Map<String,Polyline>polyline=Map.from(state.polylines);
              if(!state.showRoute){
                polyline.removeWhere((key, value) => key=='myRoute');
              }
              return SingleChildScrollView(
                      child: Stack(
                        children: [
                          MapView(initialLocation: stateLoc.lastKnowPosition!, polylines: state.polylines.values.toSet(),markers: state.markers.values.toSet(),),
                          const CustomSearchBar(),
                          const ManualMarker()
                        ],
                      ),
                    );
            },
          );
          
        } ,),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children:[
            BtnLocation(),
            BtnFollowUser(),
            BtnToggleRoute()
            
          ],
        ),
    );
  }
}