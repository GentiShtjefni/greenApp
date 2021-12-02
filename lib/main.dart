import 'package:entre_cousins/LoginPage.dart';
import 'package:entre_cousins/loggedIn/AddEvent.dart';
import 'package:entre_cousins/loggedIn/AddProduct.dart';
import 'package:entre_cousins/loggedIn/Admin/AdminPanel.dart';
import 'package:entre_cousins/loggedIn/Admin/PotentialUsers.dart';
import 'package:entre_cousins/loggedIn/CGU.dart';
import 'package:entre_cousins/loggedIn/Carte.dart';
import 'package:entre_cousins/loggedIn/Contact.dart';
import 'package:entre_cousins/loggedIn/Event.dart';
import 'package:entre_cousins/loggedIn/Events.dart';
import 'package:entre_cousins/loggedIn/EventsSearch.dart';
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
import 'package:entre_cousins/tools/constants.dart';
import 'package:entre_cousins/tools/shared_preference.dart';
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
    }
    else if(firebaseUser.email == 'admin@gmail.com'){
      return CousinsAdmin();
    }
    else return CousinsAppSigned();
  }
}

class CousinsAppNot extends StatefulWidget {
  const CousinsAppNot({Key? key}) : super(key: key);

  @override
  State<CousinsAppNot> createState() => _CousinsAppNotState();
}

class _CousinsAppNotState extends State<CousinsAppNot> {
  getUsername() async{
    var smth = await SharedPreference().getUserName();
      Constants.myName = smth;
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Entre Cousins',
      debugShowCheckedModeBanner: false,
      initialRoute: 'Login',
      routes: {
        'potentialuser': (context) => PotentialUser(userId: ""),
        'admin': (context) => AdminPanel(),
        'Login': (context) => LoginPage(),
        'firstScreen': (context) => HomePage(),
        'profile': (context) => Profile(username: Constants.myName!,),
        'messages': (context) => Messages(),
        'shopping': (context) => Shopping(),
        'members': (context) => Members(),
        'events': (context) => Events(),
        'message': (context) => Message('',''),
        'eventsearch': (context) => EventSearch(),
        'product': (context) => ProductPage(productId: ''),
        'member': (context) => Member(),
        'event': (context) => Event(eventId: '',),
        'addproduct': (context) => AddProduct(),
        'contact': (context) => Contact(),
        'professionnels': (context) => Professionnels(),
        'carte': (context) => Carte(),
        'mentions': (context) => Mentions(),
        'CGU': (context) => CGU(),
        'addevent': (context) => AddEvent(),
        'professionnel': (context) => Professionnel(username: '',),
        'messagesSearch': (context) => MessagesSearch(),
      },
    );
  }
}
class CousinsAppSigned extends StatefulWidget {
  const CousinsAppSigned({Key? key}) : super(key: key);

  @override
  State<CousinsAppSigned> createState() => _CousinsAppSignedState();
}

class _CousinsAppSignedState extends State<CousinsAppSigned> {

  getUsername() async{
    var smth = await SharedPreference().getUserName();
    setState(() {
      Constants.myName = smth;
    });
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Entre Cousins',
      debugShowCheckedModeBanner: false,
      initialRoute: 'firstScreen',
      routes: {
        'potentialuser': (context) => PotentialUser(userId: "",),
        'admin': (context) => AdminPanel(),
        'Login': (context) => LoginPage(),
        'firstScreen': (context) => HomePage(),
        'profile': (context) => Profile(username: Constants.myName!,),
        'messages': (context) => Messages(),
        'shopping': (context) => Shopping(),
        'members': (context) => Members(),
        'events': (context) => Events(),
        'eventsearch': (context) => EventSearch(),
        'message': (context) => Message('',''),
        'product': (context) => ProductPage(productId: '',),
        'member': (context) => Member(),
        'event': (context) => Event(eventId: '',),
        'addproduct': (context) => AddProduct(),
        'contact': (context) => Contact(),
        'professionnels': (context) => Professionnels(),
        'carte': (context) => Carte(),
        'mentions': (context) => Mentions(),
        'CGU': (context) => CGU(),
        'addevent': (context) => AddEvent(),
        'professionnel': (context) => Professionnel(username: '',),
        'messagesSearch': (context) => MessagesSearch(),
      },
    );
  }
}
class CousinsAdmin extends StatefulWidget {
  const CousinsAdmin({Key? key}) : super(key: key);

  @override
  State<CousinsAdmin> createState() => _CousinsAdminState();
}

class _CousinsAdminState extends State<CousinsAdmin> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Entre Cousins',
      debugShowCheckedModeBanner: false,
      initialRoute: 'Login',
      routes: {
        'potentialuser': (context) => PotentialUser(userId: ""),
        'admin': (context) => AdminPanel(),
        'Login': (context) => LoginPage(),
      },
    );
  }
}
