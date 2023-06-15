

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/delegates/delegates.dart';
import 'package:maps_app/models/models.dart';


class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc,SearchState>(
      builder: (context,state){
      return  state.displayManualMarker==true
     ?const SizedBox()
     :FadeInDown(
      duration: const Duration(milliseconds: 300),
      child: const _SearchBarBody());
      }
      );
  }
}


class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody({super.key});

  void onSearchResults(BuildContext context, SearchResults results)async {
    final searchBloc=BlocProvider.of<SearchBloc>(context);
        final locationBloc=BlocProvider.of<LocationBloc>(context);
     final mapBloc=BlocProvider.of<MapBloc>(context);
    if (results.manual ==true) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
      }
    else if(results.latLng!= null){
     final destination=await searchBloc.getCoordsStartToEnd(locationBloc.state.lastKnowPosition!,results.latLng!);
      await mapBloc.drawRoutePolyline(destination);
      
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin:const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        height: 50,
        child: GestureDetector(
          onTap: ()  async{
       final result= await showSearch(context: context, delegate: SearchDestinationDelegate());
       if(result==null)return;
       onSearchResults(context,result);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 13),
            decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow:const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0,5)
                )
              ]
            ),
            child: const Text('Where do you want to go?',style: TextStyle(color: Colors.black87),),
            ),
            
          )
        ),
    );
    
  }
}