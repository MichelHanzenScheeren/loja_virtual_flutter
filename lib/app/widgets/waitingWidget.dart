import 'package:flutter/material.dart';

class WaitingWidget extends StatelessWidget {
  final double width;
  final double height;
  WaitingWidget({this.width: 150, this.height: 150});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        child: CircularProgressIndicator(
          valueColor:
          AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 5,
        ),
      ),
    );
  }
}
