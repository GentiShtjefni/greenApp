import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class AddEvent extends StatelessWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: ListView(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 6, 30, 0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 6, 5, 20),
                  child: Image(
                    image: AssetImage('images/upload.png'),
                    width: 80,
                    height: 80,
                  ),
                ),
                Text('Ajouter Photo',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 0, 25, 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    child: Text('TITRE',
                        style: TextStyle(color: Colors.black, fontSize: 19)),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    child: Text('Titre',
                        style: TextStyle(color: Colors.grey, fontSize: 19)),
                  ),
                ],
              ),
            ),
            Container(
              height: 260,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    child: Text('DESCRIPTION',
                        style: TextStyle(color: Colors.black, fontSize: 19)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    child: TextField(
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
            child: Row(
              children: [
                InkWell(
                  child: CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    radius: 25,
                    child: Icon(Icons.add, color: Colors.black,size: 40,),
                  ),
                ),
                Expanded(
                  child: Text('  Ajouter un numéro de téléphone',style: TextStyle(fontSize: 17),),
                )
              ],
            )),
            Padding(padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: Row(
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        backgroundColor: Colors.greenAccent,
                        radius: 25,
                        child: Icon(Icons.add, color: Colors.black,size: 40,),
                      ),
                    ),
                    Expanded(
                      child: Text('  Ajouter une adresse e-mail',style: TextStyle(fontSize: 17),),
                    )
                  ],
                )),

            Padding(
              padding: EdgeInsets.fromLTRB(50, 50, 50, 20),
              child: InkWell(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text('ENREGISTER',
                        style: TextStyle(fontSize: 25, color: Colors.black)),
                  ),
                ),
              ),
            )
          ],
        ),
        currentIndex: 4);
  }
}
