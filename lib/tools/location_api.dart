import 'dart:async';

import 'package:entre_cousins/tools/place.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';

class Delay{
  final int milliseconds;
  Delay(this.milliseconds);
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) async {
    if(timer != null){
      timer!.cancel;
    }
    timer = Timer(Duration(microseconds: milliseconds), action);
  }

}

class LocationApi extends ChangeNotifier {
  var delay = Delay(500);

  final _controller = StreamController<List<Place>>.broadcast();
  Stream<List<Place>> get controllerOut =>
    _controller.stream.asBroadcastStream();
  StreamSink<List<Place>> get controllerIn =>_controller.sink;

  addPlace(Place place){
    places.add(place);
    print(place);
    List<Place> newlist = List.from(places.reversed);
    controllerIn.add(newlist);
  }

  @override
  void dispose(){
    super.dispose();
    _controller.close();
  }

  List<Place> places = [];

  handleSearch(String query) async {
    if (query.length >= 8) {
      delay.run(() async {
        try {
          List<Location> locations = await locationFromAddress(query);

          locations.forEach((location) async {
            List<Placemark> placeMarks =
            await placemarkFromCoordinates(location.latitude, location.longitude);

            placeMarks.forEach((placeMark) {
              addPlace(Place(
                  name: placeMark.name!,
                  country: placeMark.country!,
                  street: placeMark.street!,
                  locality: placeMark.locality!
              ));
            });

          });
        } on Exception catch (e) {
          print(e.toString());
        }
      });

    }else {
      places.clear();
    }
  }
}
