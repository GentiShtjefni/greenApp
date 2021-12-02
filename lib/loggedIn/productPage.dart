import 'package:entre_cousins/tools/DatabaseService.dart';
import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductPage extends StatefulWidget {
  final String productId;

  ProductPage({required this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isFavorite = false;
  String phoneNumber = '';
  String name = '';
  String description = '';
  String price = '';
  List imageurl = [];
  DatabaseService dbS = new DatabaseService();

  getPhoneNumber() {
    dbS.getPhoneNumber(widget.productId).then((value) {
      setState(() {
        phoneNumber = value['telephone'];
        name = value['name'];
        description = value['description'];
        price = value['price'];
        imageurl = value['imageurl'];
        print(imageurl);
      });
    });
  }


  @override
  void initState() {
    getPhoneNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: ListView(

          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 20),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.greenAccent,
                      )),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 0; i < imageurl.length; i++)
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 2.2,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      height: MediaQuery.of(context).size.height / 2.2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(imageurl[i]), fit: BoxFit.contain),
                      ),
                    )
                ],
              ),
            ),
            // Container(
            // constraints: BoxConstraints(
            // maxHeight: MediaQuery.of(context).size.height / 2.2,
            // maxWidth: MediaQuery.of(context).size.width,
            // ),
            // height: MediaQuery.of(context).size.height / 2.2,
            // width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            // image: DecorationImage(image: NetworkImage(imageurl[index]), fit: BoxFit.fill),
            // ),
            // );
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 25, 40),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(price,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          Icon(Icons.euro_symbol),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 28.0),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            description,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      call();
                    },
                    child: Container(
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
                            child: Text(
                              phoneNumber,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        currentIndex: 2);
  }
  call(){
    String phonenu = "tel:"+phoneNumber;
    launch(phonenu);
  }
}
