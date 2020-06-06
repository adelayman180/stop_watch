import 'package:flutter/material.dart';
import 'dart:async' as time;

class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  Stopwatch stopwatch = Stopwatch();
  bool reset = false;

  @override
  void dispose() {
    super.dispose();
    stopwatch.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: stopwatch.isRunning ? Colors.red[600] : Colors.black,
        ),
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            stopwatch.elapsed.toString().substring(0, 9),
            style: TextStyle(fontSize: 45),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  size: 40,
                ),
                onPressed: () {
                  if (!stopwatch.isRunning) {
                    if (reset) {
                      stopwatch.reset();
                      reset = false;
                    }
                    stopwatch.start();

                    time.Timer.periodic(Duration(milliseconds: 100), (t) {
                      if (stopwatch.isRunning)
                        setState(() {});
                      else {
                        t.cancel();
                        setState(() {});
                      }
                    });
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.pause,
                  size: 40,
                ),
                onPressed: () {
                  stopwatch.stop();
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.stop,
                  size: 40,
                ),
                onPressed: () {
                  stopwatch.stop();
                  reset = true;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
