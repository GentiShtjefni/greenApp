import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Members extends StatefulWidget {
  const Members({Key? key}) : super(key: key);

  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;

  List<QueryDocumentSnapshot> _usersList = [];
  bool _loadingUsers = true;

  int _perPage = 10;
  late DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreUsers = false;
  bool _gettingMoreUsersAvailable = false;

  _addMembers() async {
    setState(() {
      _loadingUsers = true;
    });
    Query q =
        _firebaseStorage.collection('users').orderBy('name').limit(_perPage);
    QuerySnapshot querySnapshot = await q.get();
    _usersList = querySnapshot.docs;
    _lastDocument = querySnapshot.docs.last;
    setState(() {
      _loadingUsers = false;
    });
    if (querySnapshot.docs.length < _perPage) {
      setState(() {
        _gettingMoreUsersAvailable = false;
      });
    }
  }


  _getMoreUsers() async {
    print('getmoreUsers function called');
    if (_gettingMoreUsersAvailable == false) {
      return;
    }
    if (_gettingMoreUsers == true) {
      return;
    }

    _gettingMoreUsers = false;

    Query q = _firebaseStorage
        .collection('users').where("role", isEqualTo: "user").where("pending", isEqualTo: false)
        .orderBy('name')
        .startAfter([_lastDocument.get('name')]).limit(_perPage);

    QuerySnapshot querySnapshot = await q.get();

    if (querySnapshot.docs.length < _perPage) {
      setState(() {
        _gettingMoreUsersAvailable = false;
      });
    }
    _usersList.addAll(querySnapshot.docs);
    _lastDocument = querySnapshot.docs.last;
    setState(() {});
    _gettingMoreUsers = false;
  }

  @override
  void initState() {
    super.initState();
    _addMembers();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      if (maxScroll - currentScroll <= delta) {
        _getMoreUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      child: ListView(
        controller: _scrollController,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 25, 5),
              child: ListTile(
                title: Text(
                  'Communauté',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                trailing: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('messagesSearch');
                    },
                    icon: Icon(Icons.search)),
              )),
          _loadingUsers
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: _usersList.length,
                  padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5),
                      child: Column(
                        children: [
                          Container(
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
                                    child: Image(
                                        image: AssetImage('images/user.png'),
                                        color: Colors.white),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(_usersList[index].get('name')),
                                          Text(_usersList[index].get('email')),
                                        ],
                                      ),
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
                ),
          _gettingMoreUsersAvailable
              ? Center(
              heightFactor: 4,
              child: CircularProgressIndicator())
              : Center(
                  child:
                      Text('No more Users...', style: TextStyle(fontSize: 20))),
        ],
      ),
      currentIndex: 3,
    );
  }
}
