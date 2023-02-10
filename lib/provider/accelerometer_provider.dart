import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

StateProvider<AccelerometerEvent> accelerometerEvent = StateProvider((ref) => AccelerometerEvent(0, 0, 0));

StateProvider<bool> isSwitchOn = StateProvider((ref)=>true);


