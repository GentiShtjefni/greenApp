import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Professionnel extends StatelessWidget {
  const Professionnel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      child: ListView(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(30, 0, 10, 30),
                color: Colors.grey,
                child: Image(image: AssetImage('images/user.png'),height: 160,),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text('Nom Prenom', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                  ),
                  Text('Professionnel', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.grey),)
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.email),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Email.gmail.com', style: TextStyle(fontSize: 20),),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.message, color: Colors.white,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Contact', style: TextStyle(fontSize: 20, color: Colors.white),),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.greenAccent,
                  child: Icon(Icons.location_on, color: Colors.black,size: 35,),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 9),
                child: Text('Voir sur la carte', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              )
            ],
          )

        ],
      ),
      currentIndex: 0,
    );
  }
}
