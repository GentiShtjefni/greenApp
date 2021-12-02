import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_cousins/loggedIn/Event.dart';
import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventSearch extends StatefulWidget {
  @override
  _EventSearchState createState() => _EventSearchState();
}

class _EventSearchState extends State<EventSearch> {
  TextEditingController searchEditingController = TextEditingController();
  var data;

  Future initiateSearch(String searchString) async {
    await FirebaseFirestore.instance
        .collection('events')
        .where('titre', isEqualTo: searchString)
        .get()
        .then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      currentIndex: 4,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextField(
                  controller: searchEditingController,
                  decoration: InputDecoration(
                    hintText: 'Recherche par titre',
                    border: InputBorder.none,
                  ),
                ),
              )),
              IconButton(
                  onPressed: () {
                    initiateSearch(searchEditingController.text);
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          FutureBuilder(
            builder: (BuildContext context, index) {
              try {
                if (data != null) {
                  return EventTile(
                      data.docs[0].get('email'),
                      data.docs[0].get('description'),
                      data.docs[0].get('titre'),
                      data.docs[0].get().id,
                      data.docs[0].get('imageurl'));
                } else
                  return Container();
              } catch (e) {
                print(e.toString());
                if (e.toString() ==
                    'RangeError (index): Invalid value: Valid value range is empty: 0') {
                  return Text('Event not found');
                } else
                  return Text('something went wrong, please try again');
              }
            },
          )
        ],
      ),
    );
  }
}

//FutureBuilder(
//               builder: (BuildContext context, index){
//                 try{
//                   if(data != null){
//                     return SearchTile(
//                       userEmail: data.docs[0].get('email'),
//                       userName: data.docs[0].get('name'),
//                     );
//                   }
//                   else return Container();
//                 }catch(e){
//                   if(e.toString() == 'RangeError (index): Invalid value: Valid value range is empty: 0'){
//                     return Text('User not found');
//                   }else return Text('something went wrong, please try again');
//                 }
//                 }
//             )

class EventTile extends StatelessWidget {
  final String name;
  final String description;
  final String email;
  final String eventId;
  final String imageurl;

  EventTile(
      this.email, this.description, this.name, this.eventId, this.imageurl);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Event(
                        eventId: eventId,
                      )));
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
                  child: Image.network(
                    imageurl,
                    fit: BoxFit.fill,
                  ),
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

  String descriptionLength(String description) {
    if (description.length > 60) {
      return '${description.substring(0, 59)}...';
    } else
      return description;
  }
}
