import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_cousins/loggedIn/MessagesPage.dart';
import 'package:entre_cousins/tools/DatabaseService.dart';
import 'package:entre_cousins/tools/constants.dart';
import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:entre_cousins/tools/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    getUserInfo().whenComplete(() {
      databaseService.getChatRooms(Constants.myName).then((value) {
        setState(() {
          chatRoomsStream = value;
        });
        print('${Constants.myName} asdasdasd');
      });
    });
    getProducts();
    getEvents();
    _addMembers();

  }
  DatabaseService databaseService = new DatabaseService();

  //messagesPart
  late Stream chatRoomsStream;
  getUserInfo() async {
    var smth = await SharedPreference().getUserName();
    setState(() {
      Constants.myName = smth;
    });
    print('${Constants.myName} after set state');
  }
  Widget chatRoomListfirst() {
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            if((snapshot.data! as QuerySnapshot).size < 1){
              return Container();
            }else {
              return ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ChatRoomTile(
                        (snapshot.data! as QuerySnapshot)
                            .docs[0]
                            .get('chatRoomId')
                            .toString()
                            .replaceAll('_', '')
                            .replaceAll("${Constants.myName}", ''),
                        (snapshot.data! as QuerySnapshot)
                            .docs[0]
                            .get('chatRoomId'));
                  });
            }

          } else
            return CircularProgressIndicator(
              color: Colors.greenAccent,
            );
        });
  }
  Widget chatRoomListSecond() {
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            if((snapshot.data! as QuerySnapshot).size < 2){
              return Container();
            }else {
              return ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ChatRoomTile(
                        (snapshot.data! as QuerySnapshot)
                            .docs[1]
                            .get('chatRoomId')
                            .toString()
                            .replaceAll('_', '')
                            .replaceAll("${Constants.myName}", ''),
                        (snapshot.data! as QuerySnapshot)
                            .docs[1]
                            .get('chatRoomId'));
                  });
            }
          } else
            return CircularProgressIndicator(
              color: Colors.greenAccent,
            );
        });
  }

  //ProductPart
  late Stream productStream;
  String productId = '';
  getProducts() {
    databaseService.getProducts().then((value) {
      setState(() {
        productStream = value;
      });
    });
  }
  Widget productListCategories() {
    return StreamBuilder(
        stream: productStream,
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            return ListView.builder(
              itemCount: (snapshot.data! as QuerySnapshot).docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              padding: EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
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
                                child: Image.network(
                                    (snapshot.data! as QuerySnapshot)
                                        .docs[index]
                                        .get('imageurl')[0]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 125.0),
                                child: Icon(Icons.favorite,
                                    color: Colors.greenAccent),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text((snapshot.data! as QuerySnapshot)
                                .docs[index]
                                .get('name')),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 0),
                            child: Text(descriptionLength((snapshot.data! as QuerySnapshot)
                                .docs[index]
                                .get('description'))),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                                "${(snapshot.data! as QuerySnapshot).docs[index].get('price')} \$"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else
            return CircularProgressIndicator();
        });
  }

  //eventPart
  late Stream eventStream;
  getEvents() {
    databaseService.getEvents().then((value) {
      setState(() {
        eventStream = value;
      });
    });
  }
  Widget eventList() {
    return StreamBuilder(
      stream: eventStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: (snapshot.data! as QuerySnapshot)
                .docs.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
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
                        child: Image.network((snapshot.data! as QuerySnapshot)
                            .docs[index]
                            .get('imageurl')[0])
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              (snapshot.data! as QuerySnapshot)
                                  .docs[index]
                                  .get('titre'),
                            ),
                            Text(descriptionLength((snapshot.data! as QuerySnapshot)
                                .docs[index]
                                .get('description'))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );

        } else
          return CircularProgressIndicator();
      },
    );
  }

  //MembersPart
  List<QueryDocumentSnapshot> _usersList = [];
  _addMembers() async {
    Query q =
    FirebaseFirestore.instance.collection('users').orderBy('name').limit(5);
    QuerySnapshot querySnapshot = await q.get();
    setState(() {
      _usersList = querySnapshot.docs;
    });

  }
  Widget membersList(){
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: _usersList.length,
      padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 5),
          child: Column(
            children: [
              Container(
                child: Material(
                  elevation: 8,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.grey,
                        child: Image(
                            image: AssetImage('images/user.png'),
                            color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(_usersList[index].get('name')),
                            Text(_usersList[index].get('email')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
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
                  child: chatRoomListfirst(),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: chatRoomListSecond(),
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
                  child: productListCategories(),
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
                  child: eventList(),
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
                  child: membersList(),
                ),
              ],
            ),
          ),
        ],
      ),
      currentIndex: 0,
    );
  }
  descriptionLength(String description){
    if(description.length >=30){
      return description.substring(0,29) + '...';
    }else return description;
  }
}
