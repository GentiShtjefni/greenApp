import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 0),
              height: MediaQuery.of(context).size.height/1.35,
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: 20,
                padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
                itemBuilder: (BuildContext context, int index){
                  if(index== 0){
                    return Padding(padding: EdgeInsets.fromLTRB(30, 10, 25, 5),
                      child: ListTile(
                        title: Text('Événements', style: TextStyle(color: Colors.grey.shade700),),
                        trailing: Icon(Icons.search),
                      ),
                    );
                  }else return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed('event');
                      },
                      child: Container(
                        width: double.infinity,
                        child: Material(
                          elevation: 8,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                color: Colors.grey,
                                child: Image(image: AssetImage('images/event.png'),color: Colors.white, height: 20, width: 20),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text("Nom de l'événement"),
                                      Text('Lorem ipsum dolor sit'
                                          'adipiscing elit, sed do'
                                          'incididunt ut labore et'
                                          'aliqua. Ut enim ad minim'
                                          'nostrud exercitation...'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 25),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed('addevent');
                },
                child: Container(
                  height: 60,
                  child: Material(
                    color: Colors.greenAccent,
                    elevation: 5,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text('Créer votre événement',
                        style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        currentIndex: 4);
  }
}
