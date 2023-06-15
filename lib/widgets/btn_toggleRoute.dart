import 'package:flutter/material.dart';


class BtnToggleRoute extends StatelessWidget {
  const BtnToggleRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child:IconButton(
              icon:  const Icon(
             Icons.more_horiz_rounded,
                color: Colors.deepPurple,
              ),
              onPressed: () {
               
              },
      ),
    ));
  }
}
