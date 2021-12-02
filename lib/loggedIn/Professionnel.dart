import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_cousins/tools/DatabaseService.dart';
import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Professionnel extends StatefulWidget {
  final String username;

  Professionnel({required this.username});
  @override
  State<Professionnel> createState() => _ProfessionnelState();
}

class _ProfessionnelState extends State<Professionnel> {

  late Stream profileStream;
  DatabaseService dbs = DatabaseService();

  bool hasPhoto = false;

  hasProfilePhoto(String userId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get()
        .then((value) {
      print(value["profileImage"]);
      if (value["profileImage"] == "") {
        print(value["profileImage"]);
        setState(() {
          hasPhoto = false;
        });
      } else {
        setState(() {
          hasPhoto = true;
        });
      }
    });
  }
  getUserInfo() async {
    dbs.checkUserName(widget.username).then((value) {
      setState(() {
        profileStream = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: StreamBuilder(
          stream: profileStream,
          builder: (context, snapshot) {
            if (snapshot.hasData == true) {
              return ListView(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: 200,
                          maxWidth: 150,
                        ),
                        child: hasPhoto
                            ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image(
                              fit: BoxFit.fill,
                              image: NetworkImage((snapshot.data! as QuerySnapshot)
                                  .docs[0]
                                  .get("profileImage")),
                            ),
                          ),
                        )
                            : Padding(
                          padding: EdgeInsets.all(20),
                          child: Image(
                            height: 100,
                            width: 100,
                            image: AssetImage('images/user.png'),
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text('Modifier Photo',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          OutlinedButton(
                              autofocus: true,
                              onPressed: (){
                                hasProfilePhoto((snapshot.data! as QuerySnapshot).docs[0].id);

                              }, child: Text("Refresh")),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nom',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 19)),
                                Text(
                                    (snapshot.data! as QuerySnapshot)
                                        .docs[0]
                                        .get('nom'),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 19)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('USERNAME',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 19)),
                                Text(
                                    (snapshot.data! as QuerySnapshot)
                                        .docs[0]
                                        .get('name'),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 19)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('EMAIL',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 19)),
                                Text(
                                    (snapshot.data! as QuerySnapshot)
                                        .docs[0]
                                        .get('email'),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 19)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Telephone',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 19)),
                                Text(
                                    (snapshot.data! as QuerySnapshot)
                                        .docs[0]
                                        .get('telephone'),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 19)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else
              return CircularProgressIndicator();
          },
        ),
        currentIndex: 0);
  }
}
