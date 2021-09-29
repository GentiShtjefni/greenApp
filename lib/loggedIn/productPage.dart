import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.greenAccent,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width/1.3,
                      MediaQuery.of(context).size.height/2.16,
                      20,
                      20),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 34,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.favorite,
                              color: Colors.black,
                              size: 61,
                            ),
                          ),
                          Center(
                            child: Icon(
                              Icons.favorite,
                              color: isFavorite ? Colors.greenAccent : Colors.white,
                              size: 58,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 25, 40),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nom de Produit', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      Text("50\$", style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Ville', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold, color: Colors.grey)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Row(
                      children: [
                        Text('lorem ipsum dolor sit amen, consectur...'),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                ],
              ),
            )
          ],
        ),
        currentIndex: 2);
  }
}
