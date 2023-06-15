import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

import '../ui/ui.dart';

class BtnLocation extends StatelessWidget {
  const BtnLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final locationBloc=BlocProvider.of<LocationBloc>(context);
    final mapBloc=BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.deepPurple,
        maxRadius: 25,
        child: IconButton(
          icon:const Icon(Icons.my_location_outlined,color: Colors.white,),
          onPressed: () {
            final userLocation=locationBloc.state.lastKnowPosition;
             if(userLocation==null){
            final snackBar=CustomSnackbar(text:"There's no location" );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
            }
            mapBloc.moveCamera(userLocation);
          },
         ),
      ),
    );
  }
}