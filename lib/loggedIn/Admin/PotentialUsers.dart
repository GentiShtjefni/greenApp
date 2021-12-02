import 'package:entre_cousins/tools/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';


class PotentialUser extends StatefulWidget {
  final String userId;
  PotentialUser({Key? key, required this.userId}) : super(key: key);

  @override
  _PotentialUserState createState() => _PotentialUserState();
}

class _PotentialUserState extends State<PotentialUser> {

  String name = "";
  String Email = "";
  String phoneNumber = "";
  DatabaseService dbS = new DatabaseService();

  getPhoneNumber() {
    print(widget.userId);
    dbS.getPendingInfo(widget.userId).then((value){
      setState(() {
        phoneNumber = value['telephone'];
        Email = value['email'];
        name = value["nom"];
      });
    });
  }
  @override
  void initState() {
    super.initState();
    getPhoneNumber();
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: Text('Name: ')),
                  Text(name),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: Text('Email: ')),
                  Text(Email),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: Text('PhoneNumber: ')),
                  InkWell(
                      onTap: (){
                        call();
                      },
                      child: Text(phoneNumber)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  call(){
    String phonenu = "tel:"+phoneNumber;
    launch(phonenu);
  }
}
