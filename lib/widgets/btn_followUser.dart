import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';

import '../ui/ui.dart';

class BtnFollowUser extends StatelessWidget {
  const BtnFollowUser({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return IconButton(
              icon:  Icon(
               state.isFollowingUser? Icons.directions_run_rounded : Icons.hail_rounded,
                color: Colors.deepPurple,
              ),
              onPressed: () {
                mapBloc.add(StartFollowingUser());
                mapBloc.add(OnToggleShowRoute());
                 final snackBar=CustomSnackbar(text: mapBloc.state.showRoute? 'Showing route' :'Stop showing route');
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                
              },
            );
          },
        ),
      ),
    );
  }
}
