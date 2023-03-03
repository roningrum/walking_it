import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:walking_it/page/register_view.dart';
import 'package:walking_it/walking_app_v1.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterViewPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _accel = 0.0;
  var _currentAcc = 0.0;
  var lastAccel = 0.0;
  var shake = "no";

  var stepCount = 0;

  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
        accelerometerEvents.listen((AccelerometerEvent event) {
          _accel = 10;
          _currentAcc = 9.8;
          lastAccel = 9.8;

          setState(() {
            var x = event.x;
            var y = event.y;
            var z = event.z;

            lastAccel = _currentAcc;

            _currentAcc = sqrt((x*x)+(y*y)+(z*z));
            var delta = _currentAcc - lastAccel;
            _accel = _accel*0.9 + delta;

            if(_accel > 12){
              stepCount++;
            }

            if(kDebugMode){
              print('nilai x :$x, nilai y: $y, nilai z: $z, accel: $_accel');
            }
          });


        })
    );
    // _streamSubscriptions.add(
    //     accelerometerEvents.listen((AccelerometerEvent event) {
    //       setState(() {
    //         x= event.x;
    //         y = event.y;
    //         z= event.z;
    //         data.add(x);
    //         data.add(y);
    //         data.add(z);
    //
    //
    //         if(kDebugMode){
    //           print('nilai x :$x, nilai y: $y, nilai z: $z');
    //         }
    //
    //         // if(x > 0){
    //         //   direction = "back";
    //         // }else if(x < 0){
    //         //   direction = "forward";
    //         // }else if(y > 0){
    //         //   direction = "left";
    //         // }else if(y < 0){
    //         //   direction = "right";
    //         // }
    //       });
    //     })
    // );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pedometer'),),
      body: Center(
        child: Text("Jalan $stepCount"),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  // int hitungStep(double x, double y, double z) {
  //
  // }
}
