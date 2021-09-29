import 'package:entre_cousins/tools/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  AuthenticationService authenticationService = new AuthenticationService();

  bool isSelectedContact = false;
  bool isSelectedPro = false;
  bool isSelectedCarte = false;
  bool isSelectedMentions = false;
  bool isSelectedCGU = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: ListTile(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.more_vert)),
          ),
        ),
        ListTile(
          title: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: isSelectedContact
                      ? BorderSide(color: Colors.grey, width: 2.0)
                      : BorderSide(width: 0, color: Colors.white)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: Text(
                'Contact',
                style: TextStyle(
                    fontSize: isSelectedContact ? 25 : 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              isSelectedContact = true;
              isSelectedPro = false;
              isSelectedCarte = false;
              isSelectedMentions = false;
              isSelectedCGU = false;
            });
            Navigator.of(context).pushNamed('contact');
          },
        ),
        ListTile(
          title: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: isSelectedPro
                      ? BorderSide(color: Colors.grey, width: 2.0)
                      : BorderSide(width: 0, color: Colors.white)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: Text(
                'Professionnels',
                style: TextStyle(
                    fontSize: isSelectedPro ? 25 : 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              isSelectedContact = false;
              isSelectedPro = true;
              isSelectedCarte = false;
              isSelectedMentions = false;
              isSelectedCGU = false;
            });
            Navigator.of(context).pushNamed('professionnels');
          },
        ),
        ListTile(
          title: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: isSelectedCarte
                      ? BorderSide(color: Colors.grey, width: 2.0)
                      : BorderSide(width: 0, color: Colors.white)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: Text(
                'Carte',
                style: TextStyle(
                    fontSize: isSelectedCarte ? 25 : 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              isSelectedContact = false;
              isSelectedPro = false;
              isSelectedCarte = true;
              isSelectedMentions = false;
              isSelectedCGU = false;
            });
            Navigator.of(context).pushNamed('carte');
          },
        ),
        ListTile(
          title: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: isSelectedMentions
                      ? BorderSide(color: Colors.grey, width: 2.0)
                      : BorderSide(width: 0, color: Colors.white)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: Text(
                'Mentions legales',
                style: TextStyle(
                    fontSize: isSelectedMentions ? 25 : 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              isSelectedContact = false;
              isSelectedPro = false;
              isSelectedCarte = false;
              isSelectedMentions = true;
              isSelectedCGU = false;
              Navigator.of(context).pushNamed('mentions');
            });
          },
        ),
        ListTile(
          title: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: isSelectedCGU
                      ? BorderSide(color: Colors.grey, width: 2.0)
                      : BorderSide(width: 0, color: Colors.white)),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: Text(
                'CGU',
                style: TextStyle(
                    fontSize: isSelectedCGU ? 25 : 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              isSelectedContact = false;
              isSelectedPro = false;
              isSelectedCarte = false;
              isSelectedMentions = false;
              isSelectedCGU = true;
            });
            Navigator.of(context).pushNamed('CGU');
          },
        ),
        ListTile(
          title: Container(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: Text(
                'Sign out',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () {
            authenticationService.signOut();
            Navigator.of(context).pushNamed('Login');
          },
        ),
      ],
    ));
  }
}
