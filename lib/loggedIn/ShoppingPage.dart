import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_cousins/loggedIn/productPage.dart';
import 'package:entre_cousins/tools/DatabaseService.dart';
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
  bool isSelectedCategorie = false;
  DatabaseService databaseService = new DatabaseService();
  late Stream productStream;
  String productId = '';


  getProducts() {
    databaseService.getProducts().then((value) {
      setState(() {
        productStream = value;
      });
    });
  }
  getProductsByCategorie(String categorie){
    databaseService.getProductsByCategories(categorie).then((value){
      setState(() {
        productStream = value;
      });
    });
  }
  @override
  void initState() {
    getProducts();
    super.initState();
  }
  Widget productListCategories() {
    return StreamBuilder(
        stream: productStream,
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            return GridView.builder(
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),

                itemBuilder: (context, index) {
                  return GridProduct(
                    (snapshot.data! as QuerySnapshot)
                        .docs[index]
                        .get('price'),
                    (snapshot.data! as QuerySnapshot)
                        .docs[index]
                        .get('description'),
                    (snapshot.data! as QuerySnapshot)
                        .docs[index]
                        .get('name'),
                    (snapshot.data! as QuerySnapshot)
                        .docs[index].id,
                    (snapshot.data! as QuerySnapshot)
                        .docs[index]
                        .get('imageurl')[0],
                  );

                }
            );
          }
          else return CircularProgressIndicator();
        }
    );
  }



  Widget productList() {
    return StreamBuilder(
        stream: productStream,
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            return GridView.builder(
              itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),

                itemBuilder: (context, index) {
                return GridProduct(
                    (snapshot.data! as QuerySnapshot)
                        .docs[index]
                        .get('price'),
                    (snapshot.data! as QuerySnapshot)
                        .docs[index]
                        .get('description'),
                    (snapshot.data! as QuerySnapshot)
                        .docs[index]
                        .get('name'),
                    (snapshot.data! as QuerySnapshot)
                        .docs[index].id,
                  (snapshot.data! as QuerySnapshot)
                      .docs[index]
                      .get('imageurl')[0],
                );
                }
            );
          }
          else return CircularProgressIndicator();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 15, 10, 5),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.menu, color: Colors.white,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: DropdownButton(
                          underline: SizedBox(),
                          dropdownColor: Colors.greenAccent,
                          value: ddValue1,
                          elevation: 10,
                          onChanged: (var newValue) {
                            setState(() {
                              ddValue1 = newValue.toString();
                            });
                            if(ddValue1 != 'Categories'){
                              getProductsByCategorie(ddValue1);
                              setState(() {
                                isSelectedCategorie = true;
                                print(isSelectedCategorie);
                              });
                            }
                            else{
                              setState(() {
                                isSelectedCategorie = false;
                                getProducts();
                                print(isSelectedCategorie);
                              });
                            }
                          },
                          items: [
                            'Categories',
                            'automobile',
                            'Vêtements ',
                            'Électronique',
                            'Santé & Beauté',
                            'autre'
                          ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(value, style: TextStyle(
                                            color: Colors.black)),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith((
                              states) => Colors.white),
                        ),
                        child: Text(
                          'Sorte', style: TextStyle(color: Colors.black),),
                        onPressed: () {},
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
                  Text('Categorie', style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade700),),
                  Text(' / ', style: TextStyle(fontStyle: FontStyle.italic,
                      color: Colors.grey.shade700)),
                  Text(ddValue1, style: TextStyle(fontStyle: FontStyle.italic,
                      color: Colors.grey.shade700)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text('Produits', style: TextStyle(color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 1.8,
              child: isSelectedCategorie ? productListCategories() : productList(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 25),
              child: InkWell(
                onTap: () {
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


class GridProduct extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String productId;
  final String imageurl;

  GridProduct(this.price, this.description, this.name, this.productId, this.imageurl);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:
                  (context)=> ProductPage(productId: productId,)));

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
                            color: Colors.grey.shade400,
                            height: 180,
                            width: 200,
                            child: Image.network(imageurl,fit: BoxFit.contain,),

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
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Text(name, style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                      ),),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Text(descriptionLength(description)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(price),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
  String descriptionLength(String description){
    if(description.length > 25){
      return '${description.substring(0,24)}...';
    }else return description;
  }
}

