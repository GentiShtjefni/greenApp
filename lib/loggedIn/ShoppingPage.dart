import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Shopping extends StatefulWidget {
  const Shopping({Key? key}) : super(key: key);

  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  String ddValue1 = 'Categories';

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 15, 10, 5),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child:Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.menu, color: Colors.white,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:18.0),
                        child: DropdownButton(
                          underline: SizedBox(),
                          dropdownColor: Colors.greenAccent,
                          value: ddValue1,
                          elevation: 10,
                          onChanged: (var newValue) {
                            setState(() {
                              ddValue1 = newValue.toString();
                            });
                          },
                          items: [
                            'Categories',
                            'Categories 1',
                            'Categories 2',
                            'Categories 3',
                          ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(value, style: TextStyle(color: Colors.black)),
                                      ],
                                    )
                                );
                              }).toList(),
                        ),
                      ),

                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 0,0),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                      ),
                      child: Text('Filtre', style: TextStyle(color: Colors.black),),
                      onPressed: (){},
                    ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 0,0),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                        ),
                        child: Text('Sorte', style: TextStyle(color: Colors.black),),
                        onPressed: (){},
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Text('Categorie', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey.shade700),),
                  Text(' / ',style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey.shade700)),
                  Text(ddValue1,style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey.shade700)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text('Produits', style: TextStyle(color: Colors.black,fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            Container(
              height: MediaQuery.of(context).size.height/1.8,
              child: GridView.builder(
                shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: 20,
                  itemBuilder: (BuildContext ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed('product');
                        },
                        child: Material(
                          elevation: 10,
                          child: SizedBox(
                            height: 400,
                            width: 90,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Container(
                                        color: Colors.grey.shade700,
                                        height: 180,
                                        width: 200,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 145.0),
                                        child: Icon(Icons.favorite,
                                            color: Colors.greenAccent),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text('Nom de produit'),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  child: Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit'),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text("50 \$"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 25),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed('addproduct');
                },
                child: Container(
                  height: 60,
                  child: Material(
                    color: Colors.greenAccent,
                    elevation: 5,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text('ajouter un nouveau produit',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
        currentIndex: 2);
  }
}
