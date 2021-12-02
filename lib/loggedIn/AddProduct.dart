import 'dart:io';

import 'package:entre_cousins/tools/DatabaseService.dart';
import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String> images = [];
  List<File> imagesFiles = [];
  final picker = ImagePicker();
  String url = "";
  File? file;

  Future pickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagesFiles.add(File(image!.path));
    });
    if (image!.path == null) retrieveLostData;
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        imagesFiles.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  Future<void> uploadPhoto() async {
    print('$imagesFiles IMAGES FILES');
    for (var img in imagesFiles) {
      var imagefile =
          FirebaseStorage.instance.ref().child('path').child(img.toString());
      UploadTask task = imagefile.putFile(img);
      TaskSnapshot snapshot = await task;
      url = (await snapshot.ref.getDownloadURL());
      images.add(url);
      print('$images Url images');
    }
  }

  DatabaseService databaseService = new DatabaseService();
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController telephoneController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  bool isLoading = false;
  bool? filledFields;
  String ddValueCategories = 'Categories';

  nameError() {
    if (filledFields == false && nameController.text.isEmpty) {
      return "s'il vous plaît remplir le nom";
    } else if (nameController.text.length > 22) {
      return "Le nom est trop long";
    } else
      return '';
  }

  descriptionError() {
    if (filledFields == false && descriptionController.text.isEmpty) {
      return "veuillez remplir la description";
    } else
      return '';
  }

  priceError() {
    if (filledFields == false && priceController.text.isEmpty) {
      return "s'il vous plaît remplir le prix";
    } else
      return '';
  }

  categoriesError() {
    if (ddValueCategories != 'Categories') {
      return '';
    } else
      return 'veuillez sélectionner une catégorie';
  }

  addProduct() async {
    Map<String, dynamic> productMap = {
      'name': nameController.text,
      'description': descriptionController.text,
      'price': priceController.text,
      'postedTime': DateTime.now(),
      'categorie': ddValueCategories,
      'imageurl': images,
      'telephone': telephoneController.text,
    };
    await databaseService.addProduct(productMap);
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
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
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: Image(
                          image: AssetImage('images/upload.png'),
                          width: 80,
                          height: 80,
                        ),
                      ),
                      Text(
                          file == null
                              ? "s'il vous plait ajouter une photo"
                              : "vous pouvez ajouter d'autres photos",
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        constraints: BoxConstraints(
                          maxHeight: 120,
                          maxWidth: double.infinity,
                        ),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: imagesFiles.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.all(5),
                                  height: 150,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(imagesFiles[index]),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Image(
                                      image: FileImage(
                                        imagesFiles[index],
                                      ),
                                      height: 20,
                                      width: 20));
                            }),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 10),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 20),
                          child: Text('NOM',
                              style: TextStyle(
                                  color: Colors.greenAccent.shade700,
                                  fontSize: 19)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 20),
                          child: TextField(
                            controller: nameController,
                            style: TextStyle(
                              fontSize: 19,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                errorText: nameError(),
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                )),
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 20),
                          child: Text('DESCRIPTION',
                              style: TextStyle(
                                  color: Colors.greenAccent.shade700,
                                  fontSize: 19)),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 20),
                            child: TextField(
                              controller: descriptionController,
                              style: TextStyle(
                                fontSize: 19,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorText: descriptionError(),
                                  errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                  )),
                              textCapitalization: TextCapitalization.sentences,
                              maxLines: 10,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 20),
                          child: Text('PRIX',
                              style: TextStyle(
                                  color: Colors.greenAccent.shade700,
                                  fontSize: 19)),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 20),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: priceController,
                              style: TextStyle(
                                fontSize: 19,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorText: priceError(),
                                  errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                  ),
                                  suffixText: 'euro',
                                  suffixStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  )),
                              textCapitalization: TextCapitalization.sentences,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 20),
                          child: Text('TELEPHONE',
                              style: TextStyle(
                                  color: Colors.greenAccent.shade700,
                                  fontSize: 19)),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 20),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: telephoneController,
                              style: TextStyle(
                                fontSize: 19,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorText: priceError(),
                                  errorStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                  )),
                              textCapitalization: TextCapitalization.sentences,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.greenAccent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: DropdownButton(
                        underline: SizedBox(),
                        dropdownColor: Colors.greenAccent.shade100,
                        value: ddValueCategories,
                        elevation: 10,
                        onChanged: (var newValue) {
                          setState(() {
                            ddValueCategories = newValue.toString();
                          });
                        },
                        items: [
                          'Categories',
                          'automobile',
                          'Vêtements ',
                          'Électronique',
                          'Santé & Beauté',
                          'autre'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(value,
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ));
                        }).toList(),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      categoriesError(),
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 50, 50, 20),
                    child: InkWell(
                      onTap: () async {
                        if (nameController.text.isNotEmpty &&
                            descriptionController.text.isNotEmpty &&
                            priceController.text.isNotEmpty &&
                            ddValueCategories != 'Categories' &&
                            imagesFiles.length != 0) {
                          setState(() {
                            isLoading = true;
                          });
                          await uploadPhoto().whenComplete(() {
                            addProduct();
                            Navigator.of(context)
                                .pushReplacementNamed('shopping');
                          });
                          setState(() {
                            filledFields = true;
                          });
                        } else {
                          setState(() {
                            filledFields = false;
                          });
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text('ENREGISTER',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
        currentIndex: 2);
  }
}
