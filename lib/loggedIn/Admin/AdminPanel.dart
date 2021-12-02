import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_cousins/loggedIn/Admin/PotentialUsers.dart';
import 'package:entre_cousins/tools/DatabaseService.dart';
import 'package:entre_cousins/tools/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  DatabaseService databaseService = new DatabaseService();
  Stream? pendingStream;

  getPending(){
    databaseService.getPending().then((value) {
      setState(() {
        pendingStream = value;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    getPending();
  }
  Widget pendingList () {
    return StreamBuilder(
      stream: pendingStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: (snapshot.data! as QuerySnapshot).docs.length,
              padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context)=> PotentialUser(userId: (snapshot.data! as QuerySnapshot)
                              .docs[index]
                              .id )));
                    },
                    title: Row(
                      children: [
                        Expanded(child: Text((snapshot.data! as QuerySnapshot)
                            .docs[index]
                            .get('nom'))),
                        TextButton(
                          onPressed: () {
                            // AuthenticationService().signUp(email: (snapshot.data! as QuerySnapshot)
                            //     .docs[index]
                            //     .get('email'), password: (snapshot.data! as QuerySnapshot)
                            //     .docs[index]
                            //     .get('password'));
                            // FirebaseFirestore.instance.collection("users").doc((snapshot.data! as QuerySnapshot)
                            //     .docs[index]
                            //     .id).update({
                            //   "pending": false,
                            // });
                            FirebaseAuth.instance.createUserWithEmailAndPassword(email: (snapshot.data! as QuerySnapshot)
                                .docs[index]
                                .get('email'), password: (snapshot.data! as QuerySnapshot)
                                .docs[index]
                                .get('password')).ignore();
                            FirebaseFirestore.instance.collection("users").doc((snapshot.data! as QuerySnapshot)
                                .docs[index]
                                .id).update({
                              "pending": false,
                            });

                          },
                          child: Text('Accept'),
                        ),
                        TextButton(
                          onPressed: () {
                            FirebaseFirestore.instance.collection("users").doc((snapshot.data! as QuerySnapshot)
                                .docs[index]
                                .id).delete();
                          },
                          child: Text('Deny'),
                        ),
                      ],
                    ));
              }
          );
        } else if(snapshot.hasError){
          return Center(child: Text("Something went wrong, check your connection"));
        }else if(snapshot.hasData == false){
          return Center(child: Text("No pending applications"));

        }else return CircularProgressIndicator();
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Admin Panel',
          style: TextStyle(color: Colors.white, fontSize: 20),
        )),
        backgroundColor: Colors.greenAccent,
      ),
      extendBody: true,
      body: pendingList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        onPressed: (){
          AuthenticationService().signOut();
          Navigator.of(context).pushReplacementNamed('Login');
        },
      ),
    );
  }
}
