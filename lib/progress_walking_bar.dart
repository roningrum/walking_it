import 'package:flutter/material.dart';

class WalkingProgressWidget extends StatelessWidget {
  final double max;
  final double current;
  final Color color;

  const WalkingProgressWidget({Key? key, required this.current, this.color = Colors.amber, required this.max}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, boxConstraints){
       var x = MediaQuery.of(context).size.width;
       var percent = (current/max)* x;
       return Stack(
         children: [
           Container(
             width: x,
             height: 16,
             decoration: BoxDecoration(
               color: Colors.black12,
               borderRadius: BorderRadius.circular(20)
             ),
           ),
           AnimatedContainer(duration: const Duration(milliseconds: 500),
           width: percent,
             height: 16,
             decoration: BoxDecoration(
               color: color,
               borderRadius: BorderRadius.circular(20)
             ),
           )
         ],
       );
    });
  }
}
