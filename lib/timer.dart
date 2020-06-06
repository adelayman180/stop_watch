import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async' as time;

import 'package:flutter/rendering.dart';

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  Duration _duration = Duration();
  bool isRunnig = false;

  @override
  void dispose() {
    super.dispose();
    isRunnig = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isRunnig ? Colors.red : Colors.black),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _duration.toString().substring(0, 7),
                  style: TextStyle(fontSize: 45),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      onPressed: isRunnig
                          ? null
                          : () {
                              setState(() {
                                _duration = Duration();
                              });
                            },
                      child: Text('Reset'),
                    ),
                    FlatButton(
                      child: Text('Set Time'),
                      onPressed: isRunnig ? null : () => showSelectTime(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topCenter,
            child: FlatButton(
              child: Text(
                isRunnig ? 'Stop' : 'Start',
                style: TextStyle(fontSize: 27),
              ),
              onPressed: () => decreaseTime(),
            ),
          ),
        ),
      ],
    );
  }

  void decreaseTime() {
    if (!isRunnig && _duration != Duration()) {
      setState(() {
        isRunnig = true;
      });
      time.Timer.periodic(Duration(seconds: 1), (t) {
        if (_duration == Duration(seconds: 1) || !isRunnig) {
          if (_duration == Duration(seconds: 1)) _duration = Duration();
          t.cancel();
          isRunnig = false;
          setState(() {});
        } else
          setState(() {
            _duration -= Duration(seconds: 1);
          });
      });
    } else
      setState(() {
        isRunnig = false;
      });
  }

  void showSelectTime() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Color(0xffeeeeee),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoTimerPicker(
              onTimerDurationChanged: (t) {
                _duration = t;
              },
              initialTimerDuration: _duration,
            ),
            FlatButton(
              onPressed: () {
                setState(() {});
                Navigator.pop(context);
              },
              child: Text('Set'),
            ),
          ],
        ),
      ),
    );
  }
}
