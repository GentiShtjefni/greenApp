import 'package:entre_cousins/loggedIn/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  final Widget child;
  final int currentIndex;

  MainScreen({Key? key, required this.child, required this.currentIndex}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState(
    currentIndex: currentIndex,
  );
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex;
  _MainScreenState(
      {required this.currentIndex,});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        // leading: IconButton(
        //     icon: Icon(Icons.more_vert),
        //   onPressed: ,
        // ),
        leading: Builder(builder: (context) => IconButton(
        icon: Icon(Icons.more_vert),
          onPressed: () => Scaffold.of(context).openDrawer(),
        )),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed('firstScreen');
                  },
                  child: Image(image: AssetImage('images/icon.png'), color: Colors.black, height: 40),
                ),
              )
            ],
          )
        ],
      ),
      body: Container(
        color: Colors.grey.shade100,
          child: widget.child
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        backgroundColor: Colors.greenAccent,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              new AssetImage('images/user.png'), size: 25.0, color: Colors.black,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(new AssetImage('images/messages.png'), size: 25.0, color: Colors.black,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              new AssetImage('images/shopping cart.png'), size: 25.0, color: Colors.black,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              new AssetImage('images/comunity.png'), size: 25.0, color: Colors.black,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              new AssetImage('images/event.png'), size: 25.0, color: Colors.black,),
            label: '',
          ),
        ],
        onTap: (index) {
          _onPageChanged(index);
        },
      ),
    );
  }
  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
      pageIndex();

    });
  }
  dynamic pageIndex() {
    if (currentIndex == 0) {
      return Navigator.of(context).pushNamed('profile');
    } else if (currentIndex == 1) {
      return Navigator.of(context).pushNamed('messages');
    } else if (currentIndex == 2) {
      return Navigator.of(context).pushNamed('shopping');
    } else if (currentIndex == 3) {
      return Navigator.of(context).pushNamed('members');
    } else if (currentIndex == 4) {
      return Navigator.of(context).pushNamed('events');
    }
    else return Navigator.of(context).pushNamed('firstScreen');
  }
}
