import 'package:entre_cousins/tools/DatabaseService.dart';
import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';


class Event extends StatefulWidget {

  final String eventId;
  Event({required this.eventId});
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  bool attending = false;
  String phoneNumber = '';
  String titre = '';
  String description = '';
  String email = '';
  List imageurl = [];
  DatabaseService dbS = new DatabaseService();

  getPhoneNumber() {
    dbS.getPhoneNumberEvent(widget.eventId).then((value){
      setState(() {
        phoneNumber = value['telephone'];
        titre = value['titre'];
        description = value['description'];
        email = value['email'];
        imageurl = value['imageurl'];
      });
    });
  }
  @override
  void initState() {
    getPhoneNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: ListView(
          children: [
            Stack(
              children: [
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for(var i=0; i< imageurl.length; i++)
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 2,
                            color: Colors.grey,
                            child: Image.network(imageurl[i], fit: BoxFit.fitHeight)
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.greenAccent,
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 25, 40),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titre, style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  Text(email, style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                  Container(
                    margin: const EdgeInsets.only(top: 28.0),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(description,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 50,),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            attending = !attending;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 20, 0,0),
                          child: Image(image: AssetImage('images/hand.png'),
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 15,0,0),
                          child: Text( attending ? 'participant/e' : 'Demander à participer', style: TextStyle(fontSize: 19)))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.call),
                        ),
                        InkWell(
                          onTap: () async{
                            call();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(phoneNumber, style: TextStyle(fontSize: 20),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        currentIndex: 4);
  }
  call(){
    String phonenu = "tel:"+phoneNumber;
    launch(phonenu);
  }
}
