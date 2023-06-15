import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/models.dart';

import '../blocs/blocs.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResults> {
  SearchDestinationDelegate() : super();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          final result=SearchResults(cancel: true );
          close(context, result);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

@override
Widget buildResults(BuildContext context) {
  if (query.isEmpty) {
    return const Center(child: Text('Please type your destination'),);
  }

  final searchBloc = BlocProvider.of<SearchBloc>(context);
  final proximity = BlocProvider.of<LocationBloc>(context).state.lastKnowPosition;

  return FutureBuilder<List<Feature>>(
    future: searchBloc.getPlacesByQuery(proximity!, query),
    builder: (BuildContext context, AsyncSnapshot<List<Feature>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator(color: Colors.deepPurple,));
      }
      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(
          child: Text(
            'There is no place named $query',
            style: const TextStyle(color:Colors.grey),
          ),
        );
      }
      final places = snapshot.data!;

      return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title:Text(places[index].text),
            subtitle: Text(places[index].placeName),
            leading:const Icon(Icons.location_on,color: Colors.deepPurple,),
            onTap: () {
              final result = SearchResults(
                cancel: false,
                manual: false,
                latLng:LatLng(places[index].center[1],places[index].center[0]),
                name:places[index].text,
                description:places[index].placeName,
              );

              searchBloc.add(OnAddPlaceToHistory(places[index])); 
              close(context, result);
            },
          );
        },
        itemCount: places.length,
        separatorBuilder: (BuildContext context, int index) {
          return  const Divider();
        },
      );
    },
  );
}


  @override
  Widget buildSuggestions(BuildContext context) {
    final searchBloc=BlocProvider.of<SearchBloc>(context);
    final places=searchBloc.state.history;
    return ListView(
      children: [
        ListTile(
          leading: const Icon(
            Icons.location_on_outlined,
            color: Colors.deepPurple,
          ),
          title: const Text(
            'Select your destination manually',
            style: TextStyle(color: Colors.black87),
          ),
          onTap: () {
            final result=SearchResults(cancel: false,manual: true);
            close(context, result);
          },


        ),

        const Divider(),
       
        ...places.map((e){
        return Dismissible(
          key: Key(e.id),
              onDismissed: (direction){
                searchBloc.add(RemoveItemOfHistory(e));
                
              },
                background: Container(
    color: Colors.deepPurple,
    child: const Align(
      alignment: Alignment.centerRight,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    ),
  ),
          child: ListTile(
                title:Text(e.text,style: const TextStyle(color: Colors.grey)),
                subtitle: Text(e.placeName,style: const TextStyle(color: Colors.grey),),
                leading:const Icon(Icons.location_on,color: Colors.grey,),
                onTap: () {
                  final result=SearchResults(
                    cancel: false,
                    manual: false,
                    latLng:LatLng(e.center[1],e.center[0]),
                    name:e.text,
                    description:e.placeName,
                    );
        
                   
                  close(context, result);
                },
              ),
        );
        })



  ]);

       
     
  }
}
