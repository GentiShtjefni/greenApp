import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_cousins/loggedIn/Messages.dart';
import 'package:entre_cousins/tools/DatabaseService.dart';
import 'package:entre_cousins/tools/constants.dart';
import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:entre_cousins/tools/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  void initState() {
    getUserInfo().whenComplete((){
      databaseService.getChatRooms(Constants.myName).then((value) {
        setState(() {
          chatRoomsStream = value;
        });
        print('${Constants.myName} asdasdasd');
      });
    });
    super.initState();
    print('${Constants.myName} before getting chat rooms');
  }

  DatabaseService databaseService = new DatabaseService();
  late Stream chatRoomsStream;
  getUserInfo() async {
    var smth = await SharedPreference().getUserName();
    setState(() {
      Constants.myName = smth;
    });
    print('${Constants.myName} after set state');

  }



  Widget chatRoomList() {

    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            return ListView.builder(
              reverse: true,
              shrinkWrap: true,
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                itemBuilder: (context, index) {
                  return ChatRoomTile(
                      (snapshot.data! as QuerySnapshot)
                          .docs[index]
                          .get('chatRoomId').toString()
                  .replaceAll('_', '').replaceAll("${Constants.myName}", ''),
                      (snapshot.data! as QuerySnapshot)
                          .docs[index]
                          .get('chatRoomId'));

                });
          } else
            return CircularProgressIndicator(color: Colors.greenAccent,);
        });
  }



  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: Column(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 25, 5),
              child: ListTile(
                title: Text(
                  'Messages',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context).pushNamed('messagesSearch');
                  },
                ),
              )),
          chatRoomList(),

        ]),
        currentIndex: 1);
  }
}

class ChatRoomTile extends StatelessWidget {
  final String username;
  final String chatRoomId;
  ChatRoomTile(this.username, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade400)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder:
            (context)=> Message(chatRoomId,username)));
          },
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage('images/user.png'),
            radius: 25,
          ),
          title: Text(username),
        ),
      ),
    );
  }
}
