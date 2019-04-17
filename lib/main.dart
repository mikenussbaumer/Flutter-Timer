import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'dart:async';
import './timer-window.dart';
import './theme/themes.dart';
import './progress_painter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _counter = 0;
  Timer _timer;
  bool _timerStarted = false;

  void startTimer() {
    if (!_timerStarted) {
      _timerStarted = true;

      const oneSec = const Duration(seconds: 1);
      _timer = new Timer.periodic(
          oneSec,
          (Timer timer) => setState(() {
                if (_counter < 1) {
                  timer.cancel();
                  _timerStarted = false;
                } else {
                  _counter = _counter - 1;
                }
              }));
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Timer', style: TextStyle(fontSize: 60)),
              Container(
                margin: EdgeInsets.all(20),
                child: FluidSlider(
                  thumbColor: Colors.redAccent,
                  sliderColor: Colors.red,
                  labelsTextStyle: TextStyle(color: Colors.white),
                  valueTextStyle: TextStyle(color: Colors.white),
                  value: _counter,
                  onChanged: (double newValue) {
                    setState(() {
                      _counter = newValue;
                    });
                  },
                  min: 0.0,
                  max: 300.0,
                ),
              ),
              RaisedButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TimerScreen(timeToCount: _counter,)),
                      )
                    },
                child: Text('Start timer'),
              ),
            ],
          ),
        ));
  }
}
