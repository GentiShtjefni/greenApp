import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_cousins/loggedIn/homePage.dart';
import 'package:entre_cousins/tools/DatabaseService.dart';
import 'package:entre_cousins/tools/authentication_service.dart';
import 'package:entre_cousins/tools/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newemailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  late QuerySnapshot querySnapshot;

  bool obsecureText = true;
  int indexLogin = 0;

  DatabaseService databaseService = new DatabaseService();
  SharedPreference shp = new SharedPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.greenAccent,
        child: ListView(
          children: [
            SizedBox(
              height: 200,
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('images/entre-cousins-logo.png'),
                height: 300,
                width: double.infinity,
              ),
            )),
            IndexedStack(
              index: indexLogin,
              children: [
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15)),
                          child: TextButton(
                            child: Text(
                              'Connectez-vous',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            // style: ButtonStyle(
                            //   backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black),
                            // ),
                            onPressed: () {
                              setState(() {
                                indexLogin = 1;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
                      child: Center(
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: TextButton(
                            child: Text(
                              "S'inscrire",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                indexLogin = 2;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 577,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Connectez-vous',
                              style: TextStyle(
                                  color: Colors.greenAccent, fontSize: 20),
                            ),
                            Text(
                              ' a votre compte',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Adresse e-mail',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.0),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Icon(
                                    Icons.email,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Entrer votre Email',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Mot de passe',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                )),
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7.0),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Entrer votre mot de passe',
                                    ),
                                    obscureText: obsecureText,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obsecureText = !obsecureText;
                                      });
                                    },
                                    icon: Icon(Icons.visibility_off))
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      indexLogin = 3;
                                    });
                                  },
                                  child: Text('Mot de passe oublie',
                                      style: TextStyle(
                                        color: Colors.greenAccent,
                                      )))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  context.read<AuthenticationService>().signIn(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                      );
                                  shp.saveEmail(_emailController.text);
                                  databaseService.getUserByUserEmail(_emailController.text)
                                      .then((val){
                                        setState(() {
                                          querySnapshot = val;
                                        });
                                        shp.saveUserName(querySnapshot.docs[0].get('name'));
                                        shp.saveUserLoggedIn(true);
                                        print(querySnapshot.docs[0].get('name'));


                                  });

                                },
                                child: Text('Connectez-vouz',
                                    style: TextStyle(color: Colors.black)),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.greenAccent),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 10, 20),
                            child: Row(
                              children: [
                                Text(
                                  "Vous n'avez pas encore de compte?",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        indexLogin = 2;
                                      });
                                    },
                                    child: Text("S'inscrire",
                                        style: TextStyle(
                                            color: Colors.greenAccent)))
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 669,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Creer ',
                              style: TextStyle(
                                  color: Colors.greenAccent, fontSize: 20),
                            ),
                            Text(
                              'Mon compte',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Name',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.0),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Entrer votre Pseudo',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Adresse e-mail',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.0),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Icon(
                                    Icons.email,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _newemailController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Entrer votre Email',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Telephone',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.0),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _telephoneController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          'Entrer votre numéro de téléphone',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Mot de passe',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                )),
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7.0),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _newpasswordController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Entrer votre mot de passe',
                                    ),
                                    obscureText: obsecureText,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obsecureText = !obsecureText;
                                      });
                                    },
                                    icon: Icon(Icons.visibility_off))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Confirmer le Mot de passe',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                )),
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7.0),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Divider(
                                  thickness: 0.5,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Entrer votre mot de passe',
                                    ),
                                    obscureText: obsecureText,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obsecureText = !obsecureText;
                                      });
                                    },
                                    icon: Icon(Icons.visibility_off))
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(20, 10, 10, 0))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Map<String, dynamic> userInfoMap = {
                                    "name": _nameController.text,
                                    "email": _newemailController.text,
                                    "telephone": _telephoneController.text,
                                    "password": _telephoneController.text,
                                  };

                                  context.read<AuthenticationService>().signUp(
                                      email: _newemailController.text.trim(),
                                      password:
                                          _newpasswordController.text.trim());

                                  databaseService.uploadUserInfo(userInfoMap);
                                  shp.saveUserName(_nameController.text);
                                  shp.saveEmail(_newemailController.text);
                                  shp.saveUserLoggedIn(true);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                },
                                child: Text('Connectez-vouz',
                                    style: TextStyle(color: Colors.black)),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.greenAccent),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 10, 20),
                            child: Row(
                              children: [
                                Text(
                                  "Avez vous déjà un compte?",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        indexLogin = 1;
                                      });
                                    },
                                    child: Text("Connectez-vous",
                                        style: TextStyle(
                                            color: Colors.greenAccent)))
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 577,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Mot de passe',
                              style: TextStyle(
                                  color: Colors.greenAccent, fontSize: 20),
                            ),
                            Text(
                              ' oublie?',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Adresse e-mail',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.0),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Icon(
                                    Icons.email,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Entrer votre Email',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    indexLogin = 0;
                                  });
                                },
                                child: Text('Continuer',
                                    style: TextStyle(color: Colors.black)),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.greenAccent),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
