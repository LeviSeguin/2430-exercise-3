import 'package:flutter/material.dart';

class Bucket extends StatelessWidget {
  late final x;
  late final y;
  late final bucketWidth;
  late final bucketHeight;
  Bucket(this.x, this.y, this.bucketWidth, this.bucketHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment((2* x +bucketWidth)/(2-bucketWidth), y),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/bucket.jpg',
            alignment: Alignment(0, 0),
            height: MediaQuery.of(context).size.height * bucketHeight / 2,
            width: MediaQuery.of(context).size.width * bucketWidth / 2,
          ),
        )
    );
  }
}