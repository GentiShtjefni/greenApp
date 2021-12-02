import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entre_cousins/loggedIn/LocationClass.dart';
import 'package:entre_cousins/loggedIn/homePage.dart';
import 'package:entre_cousins/tools/DatabaseService.dart';
import 'package:entre_cousins/tools/authentication_service.dart';
import 'package:entre_cousins/tools/location_api.dart';
import 'package:entre_cousins/tools/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newemailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  late QuerySnapshot querySnapshot;
  bool loginError = false;
  bool errorLoginDatabase = false;
  String? errorSignUp = '';
  bool correctPassword = true;
  bool isUnique = false;
  bool obSecureText = true;
  int indexLogin = 0;
  bool isloading = false;

  DatabaseService databaseService = new DatabaseService();
  SharedPreference shp = new SharedPreference();
  int? groupValuePro = 1;

  void handleGroupValuePro(int? value2) {
    setState(() {
      groupValuePro = value2!;
    });
  }
  String isAdmin = "";
  checkAdmin() async{
    await FirebaseFirestore.instance.collection("users")
        .where("role", isEqualTo: "admin").where("email", isEqualTo: _emailController.text).get().then((value){

             if(value.docs.isEmpty){
               setState(() {

             });
             }else {
               setState(() {
                 isAdmin = "admin";
               });
             }

    });
  }

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
                isloading ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.greenAccent,
                    ),
                  ),
                ) : Container(
                  height: correctPassword ? 1400 : 1400,
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
                          Text(
                            'Entrer une adresse email valide',
                            style: TextStyle(
                              color: loginError
                                  ? Colors.red
                                  : Colors.grey.shade100,
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
                                    obscureText: obSecureText,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obSecureText = !obSecureText;
                                      });
                                    },
                                    icon: Icon(Icons.visibility_off))
                              ],
                            ),
                          ),
                          Text(
                            'le mot de passe doit comporter 6 caractères',
                            style: TextStyle(
                              color: loginError
                                  ? Colors.red
                                  : Colors.grey.shade100,
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
                          Text('email ou mot de passe incorrect',
                              style: TextStyle(
                                color: errorLoginDatabase
                                    ? Colors.red
                                    : Colors.grey.shade100,
                              )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  if (_emailController.text.isNotEmpty &&
                                      _passwordController.text.length > 5) {
                                    checkAdmin().whenComplete((){
                                      if(isAdmin == "admin"){
                                        context
                                            .read<AuthenticationService>()
                                            .signIn(
                                          email: _emailController.text.trim(),
                                          password:
                                          _passwordController.text.trim(),
                                        );
                                        Navigator.of(context).pushReplacementNamed('admin');
                                      }
                                      else {
                                        setState(() {
                                          isloading = true;
                                        });
                                        context
                                            .read<AuthenticationService>()
                                            .signIn(
                                          email: _emailController.text.trim(),
                                          password:
                                          _passwordController.text.trim(),
                                        );
                                        if (AuthenticationService()
                                            .authStateChanges ==
                                            User) {
                                          shp.saveEmail(_emailController.text);
                                          databaseService
                                              .getUserByUserEmail(
                                              _emailController.text)
                                              .then((val) {
                                            setState(() {
                                              querySnapshot = val;
                                            });
                                            shp.saveUserName(
                                                querySnapshot.docs[0].get('name'));
                                            shp.saveUserLoggedIn(true);
                                          });
                                        } else {
                                          setState(() {
                                            errorLoginDatabase = true;
                                            isloading = false;
                                          });
                                        }
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()));
                                      }
                                    });
                                  } else {
                                    setState(() {
                                      loginError = true;
                                      isloading = false;
                                    });
                                  }
                                },
                                child: Text('Connectez-vous',
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
                isloading ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.greenAccent,
                    ),
                  ),
                ) : Container(
                  height: correctPassword ? 1400 : 1400,
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
                                  "Nom ",
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
                                      hintText: 'Entrer votre nom',
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
                                  "Nom d'utilisateur",
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
                                    controller: _userNameController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Entrez votre nom d'utilisateur",
                                      errorText: isUnique ? "" : "Le nom d'utilisateur est pris",
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
                          LocationClass(),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  'Êtes-vous un professionnel?',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 0,
                                groupValue: groupValuePro,
                                onChanged: handleGroupValuePro,
                                activeColor: Colors.greenAccent,
                              ),
                              Text('Oui'),
                              Radio(
                                  value: 1,
                                  groupValue: groupValuePro,
                                  onChanged: handleGroupValuePro,
                                  activeColor: Colors.greenAccent),
                              Text('Non')
                            ],
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
                                    onSaved: (_){
                                      getAdress();
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Entrer votre mot de passe',
                                    ),
                                    obscureText: obSecureText,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obSecureText = !obSecureText;
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
                                    controller: _confirmPasswordController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      errorText: correctPassword
                                          ? null
                                          : "veuillez entrer le même mot de passe",
                                      hintText: 'Entrer votre mot de passe',
                                    ),
                                    obscureText: obSecureText,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obSecureText = !obSecureText;
                                      });
                                    },
                                    icon: Icon(Icons.visibility_off))
                              ],
                            ),
                          ),
                          Text('veuillez remplir tous les champs',
                              style: TextStyle(
                                  color: loginError
                                      ? Colors.red
                                      : Colors.grey.shade100)),
                          Container(
                              child: Text(errorSignUp!,
                                  style: TextStyle(color: Colors.red))),

                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  if (_newemailController.text.isNotEmpty &&
                                      _newpasswordController.text.length > 5 &&
                                      _telephoneController.text.isNotEmpty &&
                                      _nameController.text.isNotEmpty &&
                                  _userNameController.text.isNotEmpty) {
                                    print(isUnique);
                                    await checkUsername();
                                    print(isUnique);
                                      if(isUnique == true){
                                        print('isUnique');
                                          if (_newpasswordController.text ==
                                          _confirmPasswordController.text) {
                                            print('isUnique,samepass,');
                                            setState(() {
                                              correctPassword = true;
                                              loginError = false;
                                              isloading = true;
                                            });

                                            if(groupValuePro == 0){
                                              print('isUnique,samepass,pro');
                                              getAdress().whenComplete((){
                                                Map<String, dynamic> userInfoMap = {
                                                  "nom": _nameController.text,
                                                  "name": _userNameController.text,
                                                  "email": _newemailController.text,
                                                  "telephone": _telephoneController.text,
                                                  "adress": adresss,
                                                  "role": "pro",
                                                  "pending": true,
                                                  "password": _newpasswordController.text,
                                                };
                                                databaseService
                                                    .uploadUserInfo(userInfoMap);

                                                _nameController.clear();
                                                _confirmPasswordController.clear();
                                                _telephoneController.clear();
                                                _userNameController.clear();
                                                _newpasswordController.clear();
                                                _newemailController.clear();

                                                setState(() {
                                                  errorSignUp = "";
                                                  correctPassword = true;
                                                  isloading = false;
                                                });
                                                showDialog(
                                                    barrierDismissible: true,
                                                    context: context,
                                                    builder: (_){
                                                      return AlertDialog(
                                                        title: Text("votre candidature a été envoyée"),
                                                      );
                                                    }
                                                );
                                              });
                                            }else if(groupValuePro == 1) {
                                              getAdress.call().whenComplete((){
                                                Map<String, dynamic> userInfoMap = {
                                                  "nom": _nameController.text,
                                                  "name": _userNameController.text,
                                                  "email": _newemailController.text,
                                                  "telephone": _telephoneController.text,
                                                  "role": "user",
                                                  "pending": false,
                                                  "password": _newpasswordController.text,
                                                  "adress": adresss,
                                                };
                                                context
                                                    .read<AuthenticationService>()
                                                    .signUp(
                                                    email: _newemailController.text
                                                        .trim(),
                                                    password: _newpasswordController
                                                        .text
                                                        .trim())
                                                    .then((value) {
                                                  if (value == 'Signed up') {
                                                    databaseService
                                                        .uploadUserInfo(userInfoMap);
                                                    shp.saveUserName(
                                                        _nameController.text);
                                                    shp.saveEmail(
                                                        _newemailController.text);
                                                    shp.saveUserLoggedIn(true);
                                                    errorSignUp = "";


                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                HomePage()));
                                                    setState(() {
                                                      isloading = false;
                                                    });
                                                  } else {
                                                    if (value ==
                                                        'The email address is already in use by another account.') {
                                                      setState(() {
                                                        isloading = false;
                                                        errorSignUp =
                                                        "L'adresse e-mail est déjà utilisée par un autre compte.";
                                                      });
                                                    } else {
                                                      errorSignUp =
                                                      "Quelque chose s'est mal passé. Veuillez réessayer.";
                                                    }
                                                  }
                                                });
                                              });
                                              print('isUnique,samepass,no pro');
                                              print("$adresss before adding");



                                            }

                                          } else {
                                            print('isUnique,Nosamepass,');
                                            setState(() {
                                              correctPassword = false;
                                              isloading = false;
                                            });
                                          }
                                      }
                                      else {
                                        print('not isUnique');
                                        setState(() {
                                          isUnique = false;
                                          isloading = false;

                                        });
                                      }

                                  } else {
                                    print('something wrong');
                                    setState(() {
                                      loginError = true;
                                      correctPassword = false;
                                      isloading = false;

                                    });
                                  }
                                },
                                child: Text('Connectez-vous',
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
  late QuerySnapshot query;
  LocationClass locationClass = LocationClass();
  Future checkUsername() async {
    await databaseService.checkUserNameUnique(_userNameController.text).then((value){
      setState(() {
        query = value;
      });

    }).whenComplete((){
      if(query.size == 0){
        setState(() {
          isUnique = true;
        });
      }else {
        isUnique = false;
      }
    });
  }
  String adresss = "";
  getAdress() async {
    var smth = (await shp.getadress())!;
    setState(() {
      adresss = smth;
    });
    print("$adresss at get adresss");
  }

}
class SearchInjector extends StatelessWidget {
  final Widget child;

  const SearchInjector({Key? key, required this.child}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocationApi(),
      child: child,
    );
  }
}

