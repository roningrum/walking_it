import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:walking_it/progress_walking_bar.dart';
import 'package:walking_it/sqflite/database_handler.dart';
import 'package:walking_it/sqflite/walking.dart';

// class simpan data x,y,z

class WalkingApp extends StatefulWidget {
  const WalkingApp({super.key});

  @override
  State<WalkingApp> createState() => _WalkingAppState();
}

class _WalkingAppState extends State<WalkingApp> {
  bool isSwitched = false;
  bool isTomorrow = false;

  var _accel = 0.0;
  var _currentAcc = 0.0;
  var lastAccel = 0.0;
  var stepCount = 0;
  var x= 0.0, y=0.0, z=0.0;
  // late Walking walking;

  late Timer timer;
  StreamSubscription<AccelerometerEvent> ? eventListener;


   //walk
  // eventListener = <StreamSubscription<dynamic>>[];

  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var today = DateTime.now();
    DatabaseHandler.initializeDB();

    if(today.hour == 0){
      stepCount = 0;
    }
    else{
      stepCount = stepCount;
    }
  }

   void start() {
     setState(() {
       _streamSubscriptions.add(
           userAccelerometerEvents.listen((UserAccelerometerEvent event) {
             setState(() {
               x = event.x;
               y = event.y;
               z = event.z;
               hitungStep(x, y, z);
             });
           })
       );
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Walking App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Langkah yang di Hitung $stepCount'),
            SizedBox(
                width: 250.0,
                child: WalkingProgressWidget(current: stepCount.toDouble(), max: 1000)),
            Switch(
             value: isSwitched,
              onChanged: (value){
               setState(() {
                 isSwitched = value;
                 (isSwitched) ? start() : stop();
               });

              }
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
      print('nilai x :$x, nilai y: $y, nilai z: $z, step: $stepCount', );
    }
  }

  void stop(){
    var walking = Walking();
    walking.name = "User";
    walking.langkah = stepCount;
    walking.tgl = DateTime.now().toString();
    DatabaseHandler.insertWalkingData(walking);
    setState(() {
      for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
        subscription.cancel();
      }
    });

  }

}

