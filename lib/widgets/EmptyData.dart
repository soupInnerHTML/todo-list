import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Lottie.asset('assets/empty.json'),
      ),
      Padding(
          child: Center(
              child: Text.rich(
            TextSpan(
                text: 'There is no TODOs to complete...',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Color.fromRGBO(90, 97, 103, 100),
                )),
            textAlign: TextAlign.center,
          )),
          padding: EdgeInsets.symmetric(horizontal: 10))
    ]);
  }
}
