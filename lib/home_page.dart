import 'package:flutter/material.dart';
import './stop_watch.dart';
import './timer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcccccc),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black38,
        onTap: (i) {
          _pageController.animateToPage(i,
              duration: Duration(milliseconds: 500), curve: Curves.decelerate);
        },
        currentIndex: page,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Color(0xff999999),
            icon: Icon(Icons.av_timer),
            title: Text('Stop Watch'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xffaaaaaa),
            icon: Icon(Icons.timer),
            title: Text('Timer'),
          )
        ],
      ),
      body: PageView(
        onPageChanged: (i) {
          setState(() {
            page = i;
          });
        },
        controller: _pageController,
        children: <Widget>[StopWatch(), Timer()],
      ),
    );
  }
}
