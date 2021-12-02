import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_cousins/tools/DatabaseService.dart';
import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Carte extends StatefulWidget {
  const Carte({Key? key}) : super(key: key);

  @override
  State<Carte> createState() => _CarteState();
}

class _CarteState extends State<Carte> {
  GoogleMapController? mycontroller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker> {};

  void initMarker(specify, specifyId) async {
    List<Location> places = await locationFromAddress(specify.get("adress"));
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(places.single.latitude, places.single.longitude),
      infoWindow: InfoWindow(title: specify.get('name'), snippet: specify.get('role')),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData() async {
    FirebaseFirestore.instance.collection("users").get().then((myMarkData){
      if(myMarkData.docs.isNotEmpty){
        for(int i = 0 ; i < myMarkData.docs.length; i++){
          initMarker(myMarkData.docs[i], myMarkData.docs[i].id);
        }
      }
    });
  }

  @override
  void initState() {
    getMarkerData();
    super.initState();
  }
  @override
  Widget build(BuildContext context){

    // Set<Marker> getMarker(){
    //   return <Marker>{
    //     Marker(
    //       markerId: MarkerId('SomeUser'),
    //       position: LatLng(48, 1),
    //       infoWindow: InfoWindow(title: "SomeUser",snippet: "user"),
    //     )
    //   }.toSet();
    // }
    return MainScreen(
      child: GoogleMap(
        markers: Set<Marker>.of(markers.values),
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(48, 1),
          zoom: 5.0,
        ),
        onMapCreated: (GoogleMapController controller){
          mycontroller = controller;
        },
      ),
      currentIndex: 0,
    );
  }

  // Set<Marker> markers = {
  //   Marker(markerId: MarkerId("id-1"),
  //   position: LatLng(48,0))
  // };
  //
  // void _onMapCreated(GoogleMapController controller) async {
  //   FirebaseFirestore.instance.collection("user").get().then((snapshot) async {
  //     snapshot.docs.forEach((element) async {
  //       List<Location> places = await locationFromAddress(
  //           element.get("adress"));
  //       print(element.get("adress"));
  //       print(places.single.latitude);
  //       markers.add(
  //           Marker(
  //             markerId: MarkerId("id - " + Random().toString()),
  //             position: LatLng(places.single.latitude, places.single.longitude),
  //             onTap: (){
  //               showDialog(
  //                   barrierDismissible: true,
  //                   context: context,
  //                   builder: (_){
  //                     return AlertDialog(
  //                       title: Column(
  //                         children: [
  //                           Text(element.get("nom")),
  //                           Text(element.get("role")),
  //                         ],
  //                       ),
  //                     );
  //                   }
  //               );
  //             }
  //           )
  //       );
  //     });
  //   });
  // }
  // @override
  // Widget build(BuildContext context) {
  //   return MainScreen(
  //       child: GoogleMap(
  //         markers: markers,
  //         onMapCreated: _onMapCreated,
  //         initialCameraPosition: CameraPosition(
  //           target: LatLng(0, 0),
  //           zoom: 2,
  //         ),
  //       ),
  //       currentIndex: 0);
  // }
}
