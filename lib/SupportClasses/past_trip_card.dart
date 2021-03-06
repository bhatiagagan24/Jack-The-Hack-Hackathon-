import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PastTripCard extends StatelessWidget {
  String flight_number;
  var screen_width;
  PastTripCard(
      {Key? key, required this.flight_number, required this.screen_width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: screen_width,
      child: Card(
        color: Colors.black12,
        child: Center(
          child: Text(
            flight_number,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.blue.shade100,
            ),
          ),
        ),
      ),
    );
  }
}
