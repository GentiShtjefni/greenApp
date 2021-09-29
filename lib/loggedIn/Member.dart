import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Member extends StatelessWidget {
  const Member({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                },
                    icon: Icon(Icons.arrow_back_ios)),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 10, 25),
                  child: Container(
                    color: Colors.grey,
                    height: 150,
                    width: MediaQuery.of(context).size.width/2.5,
                  ),
                ),
                Column(
                  children: [
                    Text('Nom Prénom', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                    Text('Ville', style: TextStyle(color: Colors.grey, fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 50),
              child: Text('Lorem ipsum dolor sit amet, consectetur'
    'adipiscing elit, sed do eiusmod tempor'
    'incididunt ut labore et dolore magna aliqua.'
    'Ut enim ad minim veniam, quis nostrud'
   ' exercitation ullamco laboris nisi ut aliquip'
    'ex ea commodo consequat. Duis aute irure'
    'dolor in reprehenderit in voluptate velit'
    'esse cillum dolore eu fugiat nulla pariatur.'
    'Excepteur sint occaecat cupidatat non'
    'proident, sunt in culpa qui officia deserunt'
    'mollit anim id est laborum.'),
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
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
          ],
        ),
      ),
      currentIndex: 4,
    );
  }
}
