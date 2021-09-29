import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: ListView(
          children: [
            Center(child: Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Text('Nous contacter', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
            )),
            Container(
              margin: EdgeInsets.fromLTRB(25, 40, 25, 10),
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                    child: Text('Nom', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 10, 25, 30),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Texte',
                  ),
                  maxLines: 6,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 20),
              child: InkWell(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text('ENVOYER',
                        style: TextStyle(fontSize: 25, color: Colors.black)),
                  ),
                ),
              ),
            )
          ],
        ),
        currentIndex: 0);
  }
}