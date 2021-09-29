import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  bool attending = false;

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    color: Colors.grey,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Text("Nom de l'événement", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Text("Ville", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey)),
                    ),
                    Container(
                      width: double.infinity,
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: Text('Lorem ipsum dolor sit amet, consectetur'
                              'adipiscing elit, sed do eiusmod tempor'
                              'incididunt ut labore et dolore magna aliqua.'
                              'Ut enim ad minim veniam, quis nostrud'
                              'exercitation ullamco laboris nisi ut aliquip'
                              'ex ea commodo consequat. Duis aute irure'
                              'dolor in reprehenderit in voluptate velit'
                              'esse cillum dolore eu fugiat nulla pariatur.'
                              'Excepteur sint occaecat cupidatat non'
                              'proident, sunt in culpa qui officia deserunt'
                              'mollit anim id est laborum.',
                              ),
                        ),
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
                      margin: EdgeInsets.fromLTRB(25, 30, 0,0),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('0688181885', style: TextStyle(fontSize: 20),),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              )
            ],
          ),
        ),
        currentIndex: 2);
  }
}
