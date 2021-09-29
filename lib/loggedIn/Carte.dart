import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Carte extends StatelessWidget {
  const Carte({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(0, 0),
            zoom: 2,
          ),
        ),
        currentIndex: 0);
  }
}
