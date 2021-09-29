import 'dart:ui';

import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(30, 10, 10, 20),
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.greenAccent,
                  ),
                  child: Image(
                    image: AssetImage('images/user.png'),
                    color: Colors.black,
                  ),
                ),
                Expanded(
                    child: Text('Modifier Photo',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)))
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
                        children: [
                          Text('Nom', style: TextStyle(color: Colors.black,fontSize: 19)),
                          Text('Nom', style: TextStyle(color: Colors.grey,fontSize: 19)),
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
                        children: [
                          Text('Prenom', style: TextStyle(color: Colors.black,fontSize: 19)),
                          Text('Prenom', style: TextStyle(color: Colors.grey,fontSize: 19)),
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
                        children: [
                          Text('Ville', style: TextStyle(color: Colors.black,fontSize: 19)),
                          Text('Ville', style: TextStyle(color: Colors.grey,fontSize: 19)),
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
                              style: TextStyle(color: Colors.black,fontSize: 19)),
                          Text('01 09 75 83 51',
                              style: TextStyle(color: Colors.grey,fontSize: 19)),
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
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [

                          Text('Lorem ipsum dolor sit amet, consectetur  '),
                              Text('sed do eiusmod tempor incididunt ut '),
                             Text(' Ut enim ad minim veniam, quis nostrud '),
                              Text(' nisi ut aliquip ex ea commodo consequat. '),
                              Text('reprehenderit in voluptate velit esse .',),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(40, 10, 10, 20),
                    child: Image(
                      image: AssetImage('images/ghost.png'),
                      height: 30,
                    )),
                Expanded(
                    child: Center(
                  child: Text('Ne plus apparaitre dans la communauté'),
                ))
              ],
            )
          ],
        ),
        currentIndex: 0);
  }
}
