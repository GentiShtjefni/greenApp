import 'package:entre_cousins/LoginPage.dart';
import 'package:entre_cousins/loggedIn/AddEvent.dart';
import 'package:entre_cousins/loggedIn/AddProduct.dart';
import 'package:entre_cousins/loggedIn/CGU.dart';
import 'package:entre_cousins/loggedIn/Carte.dart';
import 'package:entre_cousins/loggedIn/Contact.dart';
import 'package:entre_cousins/loggedIn/Event.dart';
import 'package:entre_cousins/loggedIn/Events.dart';
import 'package:entre_cousins/loggedIn/Member.dart';
import 'package:entre_cousins/loggedIn/Members.dart';
import 'package:entre_cousins/loggedIn/Mentions.dart';
import 'package:entre_cousins/loggedIn/Messages.dart';
import 'package:entre_cousins/loggedIn/MessagesPage.dart';
import 'package:entre_cousins/loggedIn/MessagesSearch.dart';
import 'package:entre_cousins/loggedIn/Professionnel.dart';
import 'package:entre_cousins/loggedIn/Professionnels.dart';
import 'package:entre_cousins/loggedIn/ProfilePage.dart';
import 'package:entre_cousins/loggedIn/ShoppingPage.dart';
import 'package:entre_cousins/loggedIn/homePage.dart';
import 'package:entre_cousins/loggedIn/productPage.dart';
import 'package:entre_cousins/tools/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(CousinsApp());
}

class CousinsApp extends StatelessWidget {
  const CousinsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Entre Cousins',
        debugShowCheckedModeBanner: false,
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if(firebaseUser == null){
      return CousinsAppNot();
    }else return CousinsAppSigned();
  }
}

class CousinsAppNot extends StatelessWidget {
  const CousinsAppNot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Entre Cousins',
      debugShowCheckedModeBanner: false,
      initialRoute: 'Login',
      routes: {
        'Login': (context) => LoginPage(),
        'firstScreen': (context) => HomePage(),
        'profile': (context) => Profile(),
        'messages': (context) => Messages(),
        'shopping': (context) => Shopping(),
        'members': (context) => Members(),
        'events': (context) => Events(),
        'message': (context) => Message('',''),
        'product': (context) => ProductPage(),
        'member': (context) => Member(),
        'event': (context) => Event(),
        'addproduct': (context) => AddProduct(),
        'contact': (context) => Contact(),
        'professionnels': (context) => Professionnels(),
        'carte': (context) => Carte(),
        'mentions': (context) => Mentions(),
        'CGU': (context) => CGU(),
        'addevent': (context) => AddEvent(),
        'professionnel': (context) => Professionnel(),
        'messagesSearch': (context) => MessagesSearch(),
      },
    );
  }
}
class CousinsAppSigned extends StatelessWidget {
  const CousinsAppSigned({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Entre Cousins',
      debugShowCheckedModeBanner: false,
      initialRoute: 'firstScreen',
      routes: {
        'Login': (context) => LoginPage(),
        'firstScreen': (context) => HomePage(),
        'profile': (context) => Profile(),
        'messages': (context) => Messages(),
        'shopping': (context) => Shopping(),
        'members': (context) => Members(),
        'events': (context) => Events(),
        'message': (context) => Message('',''),
        'product': (context) => ProductPage(),
        'member': (context) => Member(),
        'event': (context) => Event(),
        'addproduct': (context) => AddProduct(),
        'contact': (context) => Contact(),
        'professionnels': (context) => Professionnels(),
        'carte': (context) => Carte(),
        'mentions': (context) => Mentions(),
        'CGU': (context) => CGU(),
        'addevent': (context) => AddEvent(),
        'professionnel': (context) => Professionnel(),
        'messagesSearch': (context) => MessagesSearch(),
      },
    );
  }
}
