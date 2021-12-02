import 'package:entre_cousins/LoginPage.dart';
import 'package:entre_cousins/tools/location_api.dart';
import 'package:entre_cousins/tools/place.dart';
import 'package:entre_cousins/tools/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationClass extends StatefulWidget {
  @override
  _LocationClassState createState() => _LocationClassState();
}

class _LocationClassState extends State<LocationClass> {
  final TextEditingController _adressController = TextEditingController();
  SharedPreference shp = new SharedPreference();

  @override
  Widget build(BuildContext context) {
    return SearchInjector(
      child: Consumer<LocationApi>(
        builder: (_, api, child) => Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Adress',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: Colors.white,
              ),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.home,
                      color: Colors.greenAccent,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: api.handleSearch,
                      controller: _adressController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Entrer votre adresse',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                color: Colors.white,
                child: StreamBuilder<List<Place>>(
                    stream: api.controllerOut,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Center(child: Text("Aucune adresse trouvée"));
                      }
                      final data = snapshot.data;
                      return SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Container(
                          child: Builder(
                            builder: (context) => Column(
                                children: List.generate(data!.length, (index) {
                              final place = data[index];
                              return ListTile(
                                  onTap: () {
                                    _adressController.text =
                                        "${place.street}, ${place.locality},${place.country}";
                                    saveAdress(_adressController.text);
                                  },
                                  title: Text(
                                      "${place.name}, ${place.street}, ${place.locality}"),
                                  subtitle: Text("${place.country}"));
                            })),
                          ),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }

  saveAdress(String adress) async {
    await shp.saveAdress(adress);
    print("$adress adding to local");
  }
}
