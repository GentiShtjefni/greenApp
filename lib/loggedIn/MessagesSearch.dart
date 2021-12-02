import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_cousins/loggedIn/Messages.dart';
import 'package:entre_cousins/tools/DatabaseService.dart';
import 'package:entre_cousins/tools/constants.dart';
import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:entre_cousins/tools/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagesSearch extends StatefulWidget {
  const MessagesSearch({Key? key}) : super(key: key);

  @override
  _MessagesSearchState createState() => _MessagesSearchState();
}

class _MessagesSearchState extends State<MessagesSearch> {

  TextEditingController searchTextEditingController = new TextEditingController();
  DatabaseService databaseService = new DatabaseService();

  dynamic data;
  late QuerySnapshot querySnapshot;

  final Stream<QuerySnapshot> users =
  FirebaseFirestore.instance.collection('users').where("pending", isEqualTo: false).snapshots();

  Future initiateSearch(String searchString) async {
    await FirebaseFirestore.instance
        .collection('users').where("pending", isEqualTo: false)
        .where('name', isGreaterThanOrEqualTo: searchString)
        .get().then((value){
          setState(() {
            data = value;
          });
    }
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      currentIndex: 1,
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: Colors.greenAccent,
                      )),
                  Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: 'Search username...',
                        hintStyle: TextStyle(
                          color: Colors.black87,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(icon: Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.black87,
                  ),
                    onPressed: () {
                      initiateSearch(searchTextEditingController.text);
                    },),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                builder: (BuildContext context, index){
                  try{
                    if(data != null){
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.docs.length,
                        itemBuilder: (BuildContext context, index){
                          return Column(
                            children: [
                              SearchTile(
                                userEmail: data.docs[index].get('email'),
                                userName: data.docs[index].get('name'),
                              ),
                              Divider(),
                            ],
                          );
                        },
                      );
                    }
                    else return Container();
                  }catch(e){
                    if(e.toString() == 'RangeError (index): Invalid value: Valid value range is empty: 0'){
                      return Text('User not found');
                    }else return Text('something went wrong, please try again');
                  }
                  }
              ),
            )

          ],
        ),
      ),
    );
  }
  getChatRoomId(String? a, String? b){
    List list = [a,b];
    String id = (list..sort()).join('_') ;
    return id;
  }
  getUserInfo() async {
    var smth = await SharedPreference().getUserName();
    setState(() {
      Constants.myName = smth;
    });
    print('${Constants.myName} after set state');

  }
  createChatRoom({required BuildContext context,required String username}){

    print('${Constants.myName} before');
    String? chatRoomId = getChatRoomId(username,Constants.myName);
    print(username + "username");
    print("${Constants.myName} constants");
    List<String?> usersForChat = [username, Constants.myName];

    Map<String, dynamic> chatRoomMap = {
      "users": usersForChat,
      "chatRoomId": chatRoomId,
    };


    DatabaseService().createChatRoom(chatRoomId!, chatRoomMap);

    Navigator.push(context , MaterialPageRoute(
        builder: (context) => Message(chatRoomId, username)
    ));
  }
}




class SearchTile extends StatelessWidget {

  final String userName;
  final String userEmail;

  SearchTile({required this.userEmail, required this.userName});
  final widget = _MessagesSearchState();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10,0,0),
                child: Text(userName),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20,10,0,0),
                child: Text(userEmail),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GestureDetector(
              onTap: (){
                widget.createChatRoom(context: context, username: userName);

              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text("Message"),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

