import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class WalkingSimulation extends StatefulWidget {
  const WalkingSimulation({Key? key}) : super(key: key);

  @override
  State<WalkingSimulation> createState() => _WalkingSimulationState();
}

class _WalkingSimulationState extends State<WalkingSimulation> {
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  late Timer timer;
  bool started = false;
  List laps = [];

  //walking
  var _accel = 0.0;
  var _currentAcc = 0.0;
  var lastAccel = 0.0;

  var stepCount = 0;

  var x= 0.0, y=0.0, z=0.0;

  //creating stop timer function

  void stop() {
    timer.cancel();
    setState(() {
      started = false;
      _accel = 0.0;
      for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
        subscription.cancel();
      }
    });
  }

  //creating reset function
  void reset() {
    timer.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";

      started = false;
      stepCount =0;
      _accel = 0;
    });
  }

  void addLaps() {
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }


  //walk
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
        userAccelerometerEvents.listen((UserAccelerometerEvent event) {
         setState(() {
            x = event.x;
            y = event.y;
            z = event.z;

          });


        })
    );
  }

  // create start function
  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";

        hitungStep(x, y, z);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    //timer

    return Scaffold(
      backgroundColor: const Color(0xFF1C2757),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Center(
                child: Text(
                  "StopWatch App",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                  child: Text(
                    "$digitHours:$digitMinutes:$digitSeconds",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 82.0,
                        fontWeight: FontWeight.w600),
                  )),
              Container(
                width: MediaQuery.of(context).size.width ,
                height: 400,
                decoration: BoxDecoration(
                    color: const Color(0xFF323F68),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Text("Jalan $stepCount Accelerometer : $_accel", style: const TextStyle(color: Colors.white, fontSize: 24.0),)

              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        setState(() {
                          (!started) ? start() : stop();
                        });

                      },
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.blue)),
                      child: Text(
                        (!started)?"Start" : "pause",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                      color: Colors.white,
                      onPressed: () {
                        addLaps();
                      },
                      icon: const Icon(Icons.flag)),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        setState(() {
                          reset();
                        });

                      },
                      fillColor: Colors.blue,
                      shape: const StadiumBorder(
                          side: BorderSide(color: Colors.blue)),
                      child: const Text(
                        "Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );


  }
  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  void hitungStep(double x, double y, double z) {
    _accel = 10;
    // _currentAcc = 9.8;
    lastAccel = 9.8;

    lastAccel = _currentAcc;

    _currentAcc = sqrt((x*x)+(y*y)+(z*z));
    var delta = _currentAcc - lastAccel;
    _accel = delta.abs();
    if(_accel > 1){
      stepCount++;
    }

    if(kDebugMode){
      print('nilai x :$x, nilai y: $y, nilai z: $z, delta: $delta', );
    }
  }
}
