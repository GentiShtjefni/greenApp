import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_cousins/tools/DatabaseService.dart';
import 'package:entre_cousins/tools/constants.dart';
import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {

  String chatRoomId;
  String username;
  Message(this.chatRoomId,this.username);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  TextEditingController messageController = new TextEditingController();
  DatabaseService databaseService = new DatabaseService();
  late Stream chatStream;

  Widget chatMessagesList(){
    return StreamBuilder(
      stream: chatStream,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return CircularProgressIndicator();
        }else{
          return ListView.builder(
              itemCount: (snapshot.data! as QuerySnapshot).docs.length,
              itemBuilder: (context, index) {
                return MessageTile((snapshot.data! as QuerySnapshot).docs[index].get('message'),
                    (snapshot.data! as QuerySnapshot).docs[index].get('sendBy') == Constants.myName);

              }
          );
        }
      }
    );
  }

  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String, dynamic> messageMap = {
        'message': messageController.text,
        'sendBy': Constants.myName,
        'time': DateTime.now().millisecondsSinceEpoch
      };
      databaseService.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = '';
    }
  }
  // @override
  // void initState() {
  //   databaseService.getConversationMessages(widget.chatRoomId).then((value){
  //     setState(() {
  //       chatStream = value;
  //     });
  //   });
  //   super.initState();
  // }
  @override
  void initState() {
    DatabaseService().getConversationMessages(widget.chatRoomId).then((val) {
      setState(() {
        chatStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade700, width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 3, 10),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                          color: Colors.greenAccent,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage('images/user.png'),
                      radius: 25,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(widget.username),
                        Text('online'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: chatMessagesList()),
            Padding(
              padding: const EdgeInsets.fromLTRB(30,10,30,5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.greenAccent, width: 1.0),
                ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            hintText: '  ESCRIRE UN MESSAGE',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(9),
                      child: GestureDetector(
                        onTap: sendMessage,
                          child: Icon(Icons.send))),
                    ],
                  ),
              ),
            )
          ],
        ),
        currentIndex: 1);
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  MessageTile(this.message, this.isSendByMe);
  bool isSendByMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10,10,10,0),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSendByMe ?[
                Colors.blueAccent,
                Colors.blue
              ] :
              [
                Colors.white,
                Colors.white
              ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: isSendByMe ? Radius.circular(15) : Radius.circular(0),
            bottomRight: isSendByMe ? Radius.circular(0) : Radius.circular(15),
          )
        ),
        child: Text(message),
      ),
    );
  }
}

