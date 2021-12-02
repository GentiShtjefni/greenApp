import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_cousins/loggedIn/Event.dart';
import 'package:entre_cousins/tools/DatabaseService.dart';
import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  DatabaseService databaseService = new DatabaseService();
  late Stream eventStream;

  getEvents() {
    databaseService.getEvents().then((value) {
      setState(() {
        eventStream = value;
      });
    });
  }
  @override
  void initState() {
    getEvents();
    super.initState();
  }

  Widget eventList () {
    return StreamBuilder(
      stream: eventStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: (snapshot.data! as QuerySnapshot).docs.length,
            padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 5),
                  child: EventTile(
                    (snapshot.data! as QuerySnapshot)
                        .docs[index]
                        .get('email'),
                    (snapshot.data! as QuerySnapshot)
                        .docs[index]
                        .get('description'),
                    (snapshot.data! as QuerySnapshot)
                        .docs[index]
                        .get('titre'),
                    (snapshot.data! as QuerySnapshot)
                        .docs[index].id,
                    (snapshot.data! as QuerySnapshot)
                        .docs[index]
                        .get('imageurl')[0],
                  )
              );
            }
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: Text('Événements')),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: (){
                      Navigator.of(context).pushNamed('eventsearch');

                    },
                  )
                ],
              )
            ),
            Container(
              margin: EdgeInsets.only(top: 0),
              height: MediaQuery.of(context).size.height/1.55,
              child: eventList(),
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

class EventTile extends StatelessWidget {
  final String name;
  final String description;
  final String email;
  final String eventId;
  final String imageurl;

  EventTile(this.email, this.description, this.name, this.eventId, this.imageurl);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:
                  (context)=> Event(eventId: eventId,)));
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
                      child: Image.network(imageurl, fit: BoxFit.fill,),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(name),
                            Text(descriptionLength(description)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
  String descriptionLength(String description){
    if(description.length > 60){
      return '${description.substring(0,59)}...';
    }else return description;
  }
}
