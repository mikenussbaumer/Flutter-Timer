import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'dart:async';
import './progress_painter.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

class TimerScreen extends StatefulWidget {
  TimerScreen({@required this.timeToCount});

  final double timeToCount;

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  double _counter = 0;
  Timer _timer;
  bool _timerStarted = false;

  void startTimer() {
    if (!_timerStarted) {
      _timerStarted = true;
      const oneSec = const Duration(milliseconds: 1);
      _timer = new Timer.periodic(
          oneSec,
          (Timer timer) => setState(() {
                if (_counter > widget.timeToCount) {
                  timer.cancel();
                  _timerStarted = false;
                } else {
                  _counter = _counter + 0.001;
                }
              }));
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void deactivate() {
    super.deactivate();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Stack(
          children: <Widget>[
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    (widget.timeToCount - _counter.floor()).floor().toString() +
                        ' Sekunden',
                    style: TextStyle(color: Colors.black, fontSize: 40),
                  )
                ],
              ),
            )),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                WaveWidget(
                  config: CustomConfig(
                    gradients: [
                      [Colors.red, Color(0xEEF44336)],
                      [Colors.red[800], Color(0x77E57373)],
                      [Colors.orange, Color(0x66FF9800)],
                      [Colors.yellow, Color(0x55FFEB3B)]
                    ],
                    durations: [35000, 19440, 10800, 6000],
                    heightPercentages: [0.20, 0.23, 0.25, 0.30],
                    blur: MaskFilter.blur(BlurStyle.solid, 10),
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                  waveAmplitude: 10,
                  heightPercentange: 100,
                  backgroundColor: Colors.transparent,
                  size: Size(
                      double.infinity,
                      (_counter *
                              (MediaQuery.of(context).size.height) /
                              widget.timeToCount -
                          1)),
                )
              ],
            ),
          ],
        ));
  }
}
