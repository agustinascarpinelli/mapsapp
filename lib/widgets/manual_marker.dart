import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/helpers/helpers.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state.displayManualMarker) {
        return const _ManualMarkerBody();
      }
      return const SizedBox();
    });
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchBloc=BlocProvider.of<SearchBloc>(context);
    final locationBloc=BlocProvider.of<LocationBloc>(context);
    final mapBloc=BlocProvider.of<MapBloc>(context);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(top: 70, left: 20, child: _BtnBack()),
          Center(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: BounceInDown(
                  from: 100,
                  child: const Icon(
                    Icons.location_on_rounded,
                    size: 60,
                    color: Colors.deepPurple,
                  )),
            ),
          ),
          Positioned(
              bottom: 70,
              left: 40,
              child: FadeInUp(
                duration: const Duration(milliseconds: 300),
                child: MaterialButton(
                  onPressed: ()async {



                    final start=locationBloc.state.lastKnowPosition;
                    if(start==null)return;
                    final end=mapBloc.mapCenter;
                    if(end==null)return;
                    showLoadingMessage(context, 'Calculating route');
                    
     
                  final destination =await searchBloc.getCoordsStartToEnd(start, end);
                 await mapBloc.drawRoutePolyline(destination);
                      
                 searchBloc.add(OnDisActivateManualMarkerEvent());
                 Navigator.pop(context);
         
                
                 
                  },
                  minWidth: size.width - 120,
                  color: Colors.deepPurple,
                  elevation: 0,
                  height: 50,
                  shape: const StadiumBorder(),
                  child: const Text(
                    'Confirm destination',
                    style: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.white),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.white,
        child: IconButton(
            onPressed: () {
              final search=BlocProvider.of<SearchBloc>(context);
              search.add(OnDisActivateManualMarkerEvent());
            },
            icon:
                const Icon(Icons.arrow_back_ios_new, color: Colors.deepPurple)),
      ),
    );
  }
}
