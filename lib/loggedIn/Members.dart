import 'package:entre_cousins/tools/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Members extends StatefulWidget {
  const Members({Key? key}) : super(key: key);

  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
        child: ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 20,
              padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
              itemBuilder: (BuildContext context, int index){
                if(index == 0){
                  return Padding(padding: EdgeInsets.fromLTRB(30, 10, 25, 5),
                    child: ListTile(
                      title: Text('Communauté', style: TextStyle(color: Colors.grey.shade700),),
                      trailing: Icon(Icons.search),
                    ));
                }else return InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed('member');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                    child: Container(
                      width: double.infinity,
                      child: Material(
                        elevation: 8,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              color: Colors.grey,
                              child: Image(image: AssetImage('images/user.png'), color: Colors.white),
                            ),
                            Expanded(
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Column(
                                 children: [
                                   Text('Nom Prenom'),
                                   Text('Lorem ipsum dolor sit'
                                     'adipiscing elit, sed do'
                                     'incididunt ut labore et'
                                     'aliqua. Ut enim ad minim'
                                     'nostrud exercitation...'),
                                 ],
                               ),
                             ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        currentIndex: 3,
    );
  }
}
