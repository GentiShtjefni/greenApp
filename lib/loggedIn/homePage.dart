import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: new ListView(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.blueGrey, width: 0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Messages',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        SizedBox(
                          width: 60,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('messages');
                          },
                          child: Text('ALLER AUX MESSAGES',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.greenAccent.shade100),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.blueGrey, width: 0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 40.0,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nom Prenom'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Message Preview'),
                            ],
                          ),
                        ),
                        Text('00:00'),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.blueGrey, width: 0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 40.0,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nom Prenom'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Message Preview'),
                            ],
                          ),
                        ),
                        Text('00:00'),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.blueGrey, width: 0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Vendre',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        SizedBox(
                          width: 60,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('shopping');
                          },
                          child: Text('ALLER AU MARCHE',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.greenAccent.shade100),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 330,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(8.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                            height: 200,
                            width: 150,
                            child: Material(
                              elevation: 10,
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        color: Colors.grey.shade700,
                                        height: 160,
                                        width: 300,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 125.0),
                                        child: Icon(Icons.favorite,
                                            color: Colors.greenAccent),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: Text('Nom de produit'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    child: Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: Text("50 \$"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.blueGrey, width: 0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Evenements',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('events');
                          },
                          child: Text('ALLER AUX EVENEMENTS',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.greenAccent.shade100),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(8.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Material(
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  color: Colors.grey.shade700,
                                  height: 160,
                                  width: 200,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Nom de produit',
                                        maxLines: 3,
                                      ),
                                      Text('Lorem ipsum dolor'),
                                      Text(' sit amet, consectetur '),
                                      Text('adipiscing elit'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.blueGrey, width: 0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('MEMBRES',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('members');
                          },
                          child: Text('ALLER AUX MEMBRES',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.greenAccent.shade100),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(8.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Material(
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  color: Colors.grey.shade700,
                                  height: 160,
                                  width: 200,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Nom de produit',
                                        maxLines: 3,
                                      ),
                                      Text('Lorem ipsum dolor'),
                                      Text(' sit amet, consectetur '),
                                      Text('adipiscing elit'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        currentIndex: 0,
    );
  }
}
